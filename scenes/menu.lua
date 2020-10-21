-- -----------------------------------------------------------------------------------
-- Import
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local relayout = require("relayout")
local os = require("os")
-- local utilities = require("utilities")



-- -----------------------------------------------------------------------------------
-- Set variables
-- -----------------------------------------------------------------------------------

-- Layout
local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

-- Scene
local scene = composer.newScene()

-- Groups
local gMain



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
  print("scene:create - menu")

  -- Create main group and insert to scene
  gMain = display.newGroup()

  self.view:insert(gMain)

  -- Insert objects to gMain here
  local bg = display.newImageRect("background.png",_W,_H)
  bg.x = _CX
  bg.y = _CY
  gMain:insert(bg)

  --start btn
  local btnPlay = display.newText("Tap to Start",_CX,_CY,"font.ttf",25)
  gMain:insert(btnPlay)
  btnPlay:addEventListener("tap",function()
        composer.gotoScene("scenes.game")
  end)

  --exit btn
  local exitBtn = display.newText("Exit",_CX,_CY+130,"font.ttf","15")
  exitBtn.fill = {1,0,0}
  gMain:insert(exitBtn)

  exitBtn:addEventListener("tap",function()
      os.exit()
  end)

end



-- show()
function scene:show( event )
  if ( event.phase == "will" ) then
  elseif ( event.phase == "did" ) then
  end
end



-- hide()
function scene:hide( event )
  if ( event.phase == "will" ) then
  elseif ( event.phase == "did" ) then
  end
end



-- destroy()
function scene:destroy(event)
  if event.phase == "will" then
  end
end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
