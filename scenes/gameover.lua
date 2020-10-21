-- -----------------------------------------------------------------------------------
-- Import
-- -----------------------------------------------------------------------------------
local composer = require("composer")
local relayout = require("relayout")
local utilities = require("utilities")
local os = require("os")



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
  print("scene:create - game over")

  -- Create main group and insert to scene
  gMain = display.newGroup()
  self.view:insert(gMain)
  -- Insert objects to grpMain here

  local bg = display.newImageRect("background.png",_W,_H)
  bg.x = _CX
  bg.y = _CY
  gMain:insert(bg)

  --- scores
  local score = display.newText("Score : "..utilities:getPreviousScore(),_CX,_CY,"font.ttf",18)
  gMain:insert(score)
  -- high score
  local high_score = display.newText("High Score: "..utilities:getHighscore(),_CX,_CY+35,"font.ttf",18)
  high_score.fill = {0,0,1}
  gMain:insert(high_score)
  --restat
  local restart = display.newText("Restart",_CX,_CY+85,"font.ttf","22")
  restart.fill = {1,1,0}
  gMain:insert(restart)
  --
  restart:addEventListener("tap",function()
    composer.gotoScene("scenes.game")
  end)

  --exit
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
