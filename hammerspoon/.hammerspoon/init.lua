local cmdalt = {"cmd", "alt"}
local meta = {"cmd", "alt", "ctrl"}

-- Disable animations during window movement
hs.window.animationDuration = 0

function reload_config(files)
  hs.reload()
  hs.alert.show("Config loaded")
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reload_config):start()

-- Lock the screen
hs.hotkey.bind(meta, "l", function()
  hs.caffeinate.lockScreen()
end)

-- Start the screensaver
hs.hotkey.bind(meta, "s", function()
  hs.caffeinate.startScreensaver()
end)

-- Make window take all available space
hs.hotkey.bind(cmdalt, "f", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = 0
  f.w = screen.w
  f.h = screen.h
  win:setFrame(f)
end)

-- Center window
hs.hotkey.bind(cmdalt, "c", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = (screen.w - f.w)/2
  f.y = ((screen.h - f.h)/2) + screen.y
  win:setFrame(f)
end)

-- Move window to left half of screen
hs.hotkey.bind(cmdalt, "h", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = 0
  f.w = screen.w/2
  f.h = screen.h
  win:setFrame(f)
end)

-- Move window to right half of screen
hs.hotkey.bind(cmdalt, "l", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = screen.w/2
  f.y = 0
  f.w = screen.w/2
  f.h = screen.h
  win:setFrame(f)
end)

-- Move window to top half of screen
hs.hotkey.bind(cmdalt, "k", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = 0
  f.w = screen.w
  f.h = screen.h/2
  win:setFrame(f)
end)

-- Move window to bottom half of screen
hs.hotkey.bind(cmdalt, "j", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = screen.y + screen.h/2
  f.w = screen.w
  f.h = screen.h/2
  win:setFrame(f)
end)

-- Move window to top-left quarter of screen
hs.hotkey.bind(cmdalt, "y", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = 0
  f.w = screen.w/2
  f.h = screen.h/2
  win:setFrame(f)
end)

-- Move window to top-right quarter of screen
hs.hotkey.bind(cmdalt, "u", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = screen.w/2
  f.y = 0
  f.w = screen.w/2
  f.h = screen.h/2
  win:setFrame(f)
end)

-- Move window to bottom-left quarter of screen
hs.hotkey.bind(cmdalt, "b", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = 0
  f.y = screen.y + screen.h/2
  f.w = screen.w/2
  f.h = screen.h/2
  win:setFrame(f)
end)

-- Move window to bottom-right quarter of screen
hs.hotkey.bind(cmdalt, "n", function()
  local win = hs.window.focusedWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  f.x = screen.w/2
  f.y = screen.y + screen.h/2
  f.w = screen.w/2
  f.h = screen.h/2
  win:setFrame(f)
end)
