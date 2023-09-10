push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288



local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60
local BACKGROUND_LOOPING_POINT = 413

local bird = Bird()
local pipes = {}
local spawnTimer = 0

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Birdy')
    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    love.keyboard.keysPressed = {}
end
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.resize(w,h)
    push:resize(w,h)
end

function love.update(dt)
   backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % VIRTUAL_WIDTH

        spawnTimer = spawnTimer + dt
        if spawnTimer > 2 then
            table.insert(pipes, Pipe())
            spawnTimer = 0
        end

    bird:update(dt)
    for k, pipe in pairs(pipes) do
        pipe:update(dt)
        if pipe.x < -pipe.width then
            table.remove(pipes, k)
        end
    end
    


    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    --love.graphics.printf(tostring(bird.dy), 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(background, -backgroundScroll, 0)
    for k, pipe in pairs(pipes) do
        pipe:render()
    end
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
bird:render()

    push:finish()
end
