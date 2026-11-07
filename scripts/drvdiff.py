#!/usr/bin/env python3
"""Compare two derivation graphs, separating real changes from reorderings.

    scripts/drvdiff.py OLD.drv NEW.drv

Walks both graphs in parallel from the top-level derivations. Store paths in
values are replaced by their name so that changes are reported once, at the
derivation where they originate. Each differing attribute is classified:

- reordered: same tokens in a different order (e.g. a list option whose
  definitions now come from files in a different order);
- changed: anything else, shown as a diff.

Exit status is 0 if nothing changed (reorderings allowed), 1 otherwise.
"""

import difflib
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict

STORE_PATH = re.compile(r"/nix/store/[0-9a-z]{32}-([^/\s\"'`$:;,)\]}]+)")
TOKEN = re.compile(r"[^\s\"',\[\]{}:]+")


def load(drv):
    out = subprocess.run(
        ["nix", "derivation", "show", "-r", drv],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    data = json.loads(out)
    # Nix versions differ on whether keys include the store directory.
    return {(k if k.startswith("/nix/store/") else "/nix/store/" + k): v for k, v in data.items()}


def normalise(value):
    return STORE_PATH.sub(lambda m: "/nix/store/<" + m.group(1) + ">", value)


def pretty(value):
    try:
        return json.dumps(json.loads(value), indent=2, sort_keys=True)
    except (ValueError, TypeError):
        return value


def fields(d):
    yield "builder", d.get("builder", "")
    yield "args", " ".join(d.get("args", []))
    for key, value in sorted(d.get("env", {}).items()):
        yield "env." + key, value
    for key, value in sorted(d.get("structuredAttrs", {}).items()):
        yield "attrs." + key, value if isinstance(value, str) else json.dumps(value, sort_keys=True)
    srcs = sorted(normalise(p) for p in d.get("inputSrcs", []))
    yield "inputSrcs", "\n".join(srcs)


def input_drvs(graph, d):
    inputs = d.get("inputDrvs", {})
    by_name = defaultdict(list)
    for path in inputs:
        path = path if path.startswith("/nix/store/") else "/nix/store/" + path
        by_name[graph[path]["name"]].append(path)
    return by_name


class Differ:
    def __init__(self, old, new):
        self.old, self.new = old, new
        self.seen = set()
        self.changed = 0
        self.reordered = 0

    def report(self, chain, kind, detail=""):
        where = " > ".join(chain)
        print(f"[{kind}] {where}")
        if detail:
            for line in detail.splitlines():
                print("    " + line)

    def compare(self, a, b, chain):
        if a == b or (a, b) in self.seen:
            return
        self.seen.add((a, b))
        da, db = self.old[a], self.new[b]
        chain = chain + [da["name"]]
        fa, fb = dict(fields(da)), dict(fields(db))
        for key in sorted(set(fa) | set(fb)):
            va, vb = normalise(fa.get(key, "")), normalise(fb.get(key, ""))
            if va == vb:
                continue
            if Counter(TOKEN.findall(va)) == Counter(TOKEN.findall(vb)):
                self.reordered += 1
                self.report(chain, "reordered", key)
            else:
                self.changed += 1
                diff = difflib.unified_diff(
                    pretty(va).splitlines(),
                    pretty(vb).splitlines(),
                    "old",
                    "new",
                    lineterm="",
                    n=1,
                )
                self.report(chain, "changed", key + "\n" + "\n".join(list(diff)[2:]))

        ia, ib = input_drvs(self.old, da), input_drvs(self.new, db)
        for name in sorted(set(ia) | set(ib)):
            pa, pb = sorted(ia.get(name, [])), sorted(ib.get(name, []))
            common = set(pa) & set(pb)
            pa = [p for p in pa if p not in common]
            pb = [p for p in pb if p not in common]
            for x, y in zip(pa, pb):
                self.compare(x, y, chain)
            for x in pa[len(pb):]:
                self.changed += 1
                self.report(chain, "changed", f"input removed: {name}")
            for y in pb[len(pa):]:
                self.changed += 1
                self.report(chain, "changed", f"input added: {name}")


def main():
    old_drv, new_drv = sys.argv[1:3]
    differ = Differ(load(old_drv), load(new_drv))
    differ.compare(old_drv, new_drv, [])
    print(f"{differ.changed} changed, {differ.reordered} reordered")
    sys.exit(1 if differ.changed else 0)


if __name__ == "__main__":
    main()
