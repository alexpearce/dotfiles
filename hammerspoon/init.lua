-- Reload Hammerspoon configuration.
hs.hotkey.bind({"⌘", "⌥", "⌃"}, "h", function()
    hs.reload()
    hs.console.clearConsole()
end)

-- Enter hotkey mode with option-space.
leader = hs.hotkey.modal.new({"⌥"}, "space")

-- Exit hotkey mode with escape.
leader:bind("", "escape", nil, function() leader:exit() end, nil)

-- Hide focused application.
leader:bind("", "h", function() hs.application.frontmostApplication():hide() leader:exit() end, nil)

-- Launch applications.
leader:bind("", "f", function() hs.application.launchOrFocus("Firefox") leader:exit() end, nil)
leader:bind("", "o", function() hs.application.launchOrFocus("Obsidian") leader:exit() end, nil)
leader:bind("", "s", function() hs.application.launchOrFocus("Slack") leader:exit() end, nil)
leader:bind("", "t", function() hs.application.launchOrFocus("WezTerm") leader:exit() end, nil)

-- Window management.
hs.loadSpoon("WindowHalfsAndThirds")
wm = spoon.WindowHalfsAndThirds

-- Move focused window to left half.
leader:bind("", "left", function() wm.leftHalf() leader:exit() end, nil)
-- Move focused window to right half.
leader:bind("", "right", function() wm.rightHalf() leader:exit() end, nil)
-- Move focused window to top half.
leader:bind("", "up", function() wm.topHalf() leader:exit() end, nil)
-- Move focused window to bottom half.
leader:bind("", "down", function() wm.bottomHalf() leader:exit() end, nil)
-- Center focused window.
leader:bind("", "c", function() wm.center() leader:exit() end, nil)
-- Undo previous window movement.
leader:bind("", "delete", function() wm.undo() leader:exit() end, nil)

-- Move focused window to screen to the left.
leader:bind("⌥", "left", function()
  local window = hs.application.frontmostApplication():focusedWindow()
  window:moveToScreen(window:screen():toWest())
  leader:exit()
end, nil)

-- Move focused window to screen to the right.
leader:bind("⌥", "right", function()
  local window = hs.application.frontmostApplication():focusedWindow()
  window:moveToScreen(window:screen():toEast())
  leader:exit()
end, nil)
