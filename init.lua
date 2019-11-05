hs.window.animationDuration = .2
units = {
  right30       = { x = 0.70, y = 0.00, w = 0.30, h = 1.00 },
  right70       = { x = 0.30, y = 0.00, w = 0.70, h = 1.00 },
  left70        = { x = 0.00, y = 0.00, w = 0.70, h = 1.00 },
  left30        = { x = 0.00, y = 0.00, w = 0.30, h = 1.00 }, top50         = { x = 0.00, y = 1.00, w = 1.00, h = 1.00 },
  left50        = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 },
  right50        = { x = 0.50, y = 0.00, w = 0.50, h = 1.00 },
  upright30     = { x = 0.70, y = 0.00, w = 0.30, h = 0.50 },
  botright30    = { x = 0.70, y = 0.50, w = 0.30, h = 0.50 },
  upleft70      = { x = 0.00, y = 0.00, w = 0.70, h = 0.50 },
  botleft70     = { x = 0.00, y = 0.50, w = 0.70, h = 0.50 },
  up       = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 },
  down     = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 },
  mid40        = { x = 0.30, y = 0.00, w = 0.40, h = 1.00 },
  maximum       = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
}

upper = 'PHL 278E9Q'
 main = 'LG HDR WFHD'

-- k
layouts = {
  zero = {
    { name = 'Chrome', app = 'Safari.app', unit = units.left70 , screen = upper},
    { name = 'atom', app = 'Atom.app',            unit = units.right30, screen = main }
  },
  one = {
    -- { name = 'VimR',              unit = units.left30 },
    { name = 'Chrome', app = 'Google Chrome.app', unit = units.left70 },
    { name = 'atom', app = 'Atom.app',  unit = units.left30 }
  }
} -- end of layouts

-- Takes a layout definition (e.g. 'layouts.work') and iterates through
-- each application definition, laying it out as speccified
-- borrowed from shiftit/hs example. not working?
function runLayout(layout)
  for i = 1,#layout do
    local t = layout[i]
    local theapp = hs.application.get(t.name)
    if win == nil then
      hs.application.open(t.app)
      theapp = hs.application.get(t.name)
    end
    local win = hs.window.focusedWindow() --theapp:mainWindow()
    local screen = nil
    if t.screen ~= nil then
      screen = hs.screen.find(t.screen)
    end
    win:move(t.unit, screen, true)
  end
end


function toggleFullScreen()
  local f = not hs.window.focusedWindow():isFullScreen()
  hs.window.focusedWindow():setFullScreen(f)
end


mash = { 'option', 'cmd' }
hs.hotkey.bind(mash, ']', function() hs.window.focusedWindow():move(units.right50,  nil, true) end)
hs.hotkey.bind(mash, '[', function() hs.window.focusedWindow():move(units.left50,   nil, true) end)
hs.hotkey.bind(mash, 'j', function() hs.window.focusedWindow():move(units.up,     nil, true) end)
hs.hotkey.bind(mash, 'k', function() hs.window.focusedWindow():move(units.down,      nil, true) end)
hs.hotkey.bind(mash, 'l', function() hs.window.focusedWindow():move(units.left30,    nil, true) end)
hs.hotkey.bind(mash, ";", function() hs.window.focusedWindow():move(units.mid40,  nil, true) end)
hs.hotkey.bind(mash, "'", function() hs.window.focusedWindow():move(units.right30, nil, true) end)
hs.hotkey.bind(mash, 'm', function() hs.window.focusedWindow():move(units.maximum,    nil, true) end)
hs.hotkey.bind(mash, 'n', function() toggleFullScreen() end)
hs.hotkey.bind(mash, '0', function() runLayout(layouts.zero) end)
hs.hotkey.bind(mash, '9', function() runLayout(layouts.one) end)
