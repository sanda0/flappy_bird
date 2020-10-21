
local relayout = require("relayout")
local utilities = require("utilities")

---layout
--
local _W,_H,_CX,_CY = relayout._W,relayout._H,relayout._CX,relayout._CY

--varibles
local pipes = {}
local canAddPipe = 0
local isStrat = false
local score = 0

--groups
local gMain = display.newGroup()

local gWorld = display.newGroup()
gMain:insert(gWorld)

local gHud = display.newGroup()
gMain:insert(gHud)


--bgs
local bgs ={}
local b1 = display.newImageRect(gWorld,"background.png",_W,_H)
b1.x = _CX
b1.y = _CY
bgs[#bgs+1] = b1

local b2 = display.newImageRect(gWorld,"background.png",_W,_H)
b2.x = _CX + _W
b2.y = _CY
bgs[#bgs+1] = b2

local b3 = display.newImageRect(gWorld,"background.png",_W,_H)
b3.x = _CX +(_W*2)
b3.y = _CY
bgs[#bgs+1] = b3

--score_label
local scoreL = display.newText("0p",_CX,80,"font.ttf",40)
scoreL.fill = {0,0,0}
gHud:insert(scoreL)
--bird
local bird = display.newImageRect(gWorld,"flappy.png",25,20)
bird.x = 100
bird.y = _CY
bird.velocity = 0
bird.gravity = 0
bird.crashed = false



--sounds
local souFlap = audio.loadStream("flap.wav")
local souCrash = audio.loadStream("crash.wav")
local souScore = audio.loadStream("score.mp3")

--add pipe
local function addPipe()
    local destanceBetween = math.random(180,220)
    local yPosition = math.random(150,_H-150)

    local pTop = display.newImageRect(gWorld,"pipe.png",50,600)
    pTop.x = _W+50
    pTop.y = yPosition-(destanceBetween/2)-300
    pTop.rotation = 180 -- rotate 180
    pTop.type = "pipe"
    pipes[#pipes+1] = pTop

    local pBottom = display.newImageRect(gWorld,"pipe.png",50,600)
    pBottom.x = _W+50
    pBottom.y = yPosition+(destanceBetween/2)+300
    pBottom.type = "pipe"
    pipes[#pipes+1] = pBottom

    local pSensor = display.newRect(gWorld,_W+80,_CY,5,_H)
    pSensor.fill = {0,1,0}
    pSensor.type = "sensor"
    pSensor.alpha = 0
    pipes[#pipes+1] = pSensor


end

-- chack collision
--
local function checkCollision(obj1, obj2)

    local left  = (obj1.contentBounds.xMin) <= obj2.contentBounds.xMin and (obj1.contentBounds.xMax) >= obj2.contentBounds.xMin
    local right = (obj1.contentBounds.xMin) >= obj2.contentBounds.xMin and (obj1.contentBounds.xMin) <= obj2.contentBounds.xMax
    local up    = (obj1.contentBounds.yMin) <= obj2.contentBounds.yMin and (obj1.contentBounds.yMax) >= obj2.contentBounds.yMin
    local down  = (obj1.contentBounds.yMin) >= obj2.contentBounds.yMin and (obj1.contentBounds.yMin) <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end

print(_W)
--
--update
local function update()
    if isStrat and bird.crashed==false then
        
        for i=#bgs,1,-1 do
            local bg_obj = bgs[i]
            bg_obj:translate(-1,0)

            if bg_obj.x < (_W/2)-360 then
                bg_obj.x = bg_obj.x+(_W*3)
            end
        end
    
        for i=#pipes,1,-1 do 
            local object = pipes[i]
            object:translate(-2,0)

            if object.x < -100 then
                local chaid = table.remove(pipes,i)

                if chaid ~= nil then
                    chaid:removeSelf()
                    chaid = nil
                end
            end

            --check check Collision
            if checkCollision(object,bird) then
                if object.type == "sensor" then
                    -- print("scoore!!")
                    score = score +1
                    scoreL.text = score.."p"
                    print("score : "..score)
                    audio.play(souScore)

                    local chaid = table.remove(pipes,i)
                    if chaid ~= nil then
                        chaid:removeSelf()
                        chaid = nil
                    end

                else
                    audio.play(souCrash)
                    -- print("diieee!!!")
                    transition.to(bird,{time=200,y=_H -30})
                    bird.crashed = true

                    utilities:setHighScore(score)
                    print("highscore : "..utilities:getHighscore())
                end
            end

        end
    
        -- print("update")
        bird.velocity = bird.velocity - bird.gravity
        bird.y = bird.y - bird.velocity

        --
        if canAddPipe > 110 then
            addPipe()
            canAddPipe = 0 
        end

        if isStrat then 
            bird.gravity = 0.6   
        end

        --up or down check --
        if bird.y > _H or bird.y < 0 then
            -- bird.gravity = 0
            -- print("dieee")
            audio.play(souCrash)
            transition.to(bird,{time=200,y=_H -30})
            bird.crashed = true

            utilities:setHighScore(score)
            print("highscore : "..utilities:getHighscore())
        end
        ---run and stop
        canAddPipe = canAddPipe +1
        ---------------------------
    end
end

Runtime:addEventListener("enterFrame",update)

--
--touch
local function touch(event)
    if event.phase == "began" then
        isStrat = true
        bird.velocity = 10
        audio.play(souFlap)
    end
end
Runtime:addEventListener("touch",touch)