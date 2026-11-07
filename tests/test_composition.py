"""Regression tests for Dendritic module composition, without activation.

Run with: python3 -m unittest discover -s tests
Only Nix evaluation is performed; no host is rebuilt or deployed.
"""

import json
from pathlib import Path
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[1]

SNAPSHOT = r'''
flake:
let
  hm = config: {
    inherit (config.home) username homeDirectory stateVersion;
    fishPlugins = map (plugin: plugin.name) config.programs.fish.plugins;
    gitSsh = config.programs.git.settings.core.sshCommand or null;
    ghosttyPackageIsNull = config.programs.ghostty.package == null;
    hammerspoon = config.xdg.configFile ? hammerspoon;
    opencode = config.programs.opencode.enable;
    opencodeModel = config.programs.opencode.settings.model;
    enabledPrograms = builtins.filter
      (name: config.programs.${name}.enable)
      [ "bat" "direnv" "eza" "fish" "fzf" "gh" "ghostty" "git" "helix" "starship" "zoxide" ];
  };
in {
  registry = builtins.mapAttrs (_: builtins.attrNames) flake.modules;
  homes = builtins.mapAttrs (_: home: hm home.config) flake.homeConfigurations;
  laptop = hm flake.darwinConfigurations.pearwin-laptop.config.home-manager.users.apearwin;
  stateVersions = {
    laptop = flake.darwinConfigurations.pearwin-laptop.config.system.stateVersion;
    kazooie = flake.nixosConfigurations.kazooie.config.system.stateVersion;
  };
  nixosChecks = builtins.mapAttrs
    (name: host: {
      host = host.config.system.build.toplevel.drvPath;
      check = flake.checks.${host.pkgs.stdenv.hostPlatform.system}.${name}.drvPath;
      colmena = flake.colmenaHive.nodes.${name}.config.system.build.toplevel.drvPath;
    }) flake.nixosConfigurations;
  darwinChecks = builtins.mapAttrs
    (name: host: {
      host = host.system.drvPath;
      check = flake.checks.${host.pkgs.stdenv.hostPlatform.system}.${name}.drvPath;
    }) flake.darwinConfigurations;
}
'''


class CompositionTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        result = subprocess.run(
            [
                "nix", "eval", "--json", "--impure", "--no-write-lock-file",
                "--expr", "builtins.getFlake (toString ./.)", "--apply", SNAPSHOT,
            ],
            cwd=ROOT,
            capture_output=True,
            text=True,
        )
        if result.returncode:
            raise RuntimeError(result.stderr)
        cls.snapshot = json.loads(result.stdout)

    def test_home_manager_features_are_bridged(self):
        registry = self.snapshot["registry"]
        for platform in ["darwin", "nixos"]:
            self.assertTrue(set(registry["homeManager"]) <= set(registry[platform]))

    def test_nixos_checks_and_colmena_use_the_host_system(self):
        self.assertIn("kazooie", self.snapshot["nixosChecks"])
        for name, paths in self.snapshot["nixosChecks"].items():
            with self.subTest(host=name):
                self.assertEqual(paths["host"], paths["check"])
                self.assertEqual(paths["host"], paths["colmena"])

    def test_darwin_checks_use_the_host_system(self):
        self.assertIn("pearwin-laptop", self.snapshot["darwinChecks"])
        for name, paths in self.snapshot["darwinChecks"].items():
            with self.subTest(host=name):
                self.assertEqual(paths["host"], paths["check"])

    def test_standalone_profiles_retain_their_identity(self):
        homes = self.snapshot["homes"]
        for name, username, directory in [
            ("apearwin", "apearwin", "/Users/apearwin"),
            ("apearwin-ci", "runner", "/home/runner"),
        ]:
            with self.subTest(profile=name):
                self.assertEqual(homes[name]["username"], username)
                self.assertEqual(homes[name]["homeDirectory"], directory)
                self.assertEqual(homes[name]["stateVersion"], "23.11")

    def test_macos_settings_apply_to_standalone_and_integrated_homes(self):
        for home in [self.snapshot["homes"]["apearwin"], self.snapshot["laptop"]]:
            self.assertCountEqual(home["fishPlugins"], ["fzf", "nix-env"])
            self.assertEqual(home["gitSsh"], "/usr/bin/ssh")
            self.assertTrue(home["ghosttyPackageIsNull"])
            self.assertTrue(home["hammerspoon"])

    def test_linux_profile_does_not_import_macos_settings(self):
        home = self.snapshot["homes"]["apearwin-ci"]
        self.assertEqual(home["fishPlugins"], ["fzf"])
        self.assertIsNone(home["gitSsh"])
        self.assertFalse(home["ghosttyPackageIsNull"])
        self.assertFalse(home["hammerspoon"])

    def test_personal_features_are_present_in_each_home(self):
        expected = {"bat", "direnv", "eza", "fish", "fzf", "gh", "ghostty", "git", "helix", "starship", "zoxide"}
        for home in [*self.snapshot["homes"].values(), self.snapshot["laptop"]]:
            self.assertEqual(set(home["enabledPrograms"]), expected)
            self.assertTrue(home["opencode"])
            self.assertEqual(home["opencodeModel"], self.snapshot["laptop"]["opencodeModel"])

    def test_host_state_versions_are_preserved(self):
        self.assertEqual(self.snapshot["stateVersions"], {"laptop": 4, "kazooie": "26.05"})


if __name__ == "__main__":
    unittest.main()
