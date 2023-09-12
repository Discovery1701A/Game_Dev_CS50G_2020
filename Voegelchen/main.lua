push = require 'push'
Class = require 'class'
require 'Bird'
require 'Pipe'
require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/PauseState'

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
local GROUND_LOOPING_POINT = 514

local scrolling = true
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flying Birdy')
    smallFont = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)
    sounds = {
        ['jump'] = love.audio.newSource('jump.wav','static'),
        ['explosion'] = love.audio.newSource('explosion.wav','static'),
        ['hurt'] = love.audio.newSource('hurt.wav','static'),
        ['score'] = love.audio.newSource('score.wav','static'),
        ['music'] = love.audio.newSource('marios_way.mp3','static')
    }
    sounds['music']:setLooping(true)
    sounds['music']:play()
    math.randomseed(os.time())
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
    
    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
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

function love.mousepressed(x,y,button)
    love.mouse.buttonsPressed[button] = true
end
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end

function love.resize(w,h)
    push:resize(w,h)
end

function love.update(dt)
    if gStateMachine.current.name == 'pause' then
        sounds['music']:pause()
        scrolling = false
        else
            sounds['music']:play()
            scrolling = true
    end
    if scrolling then
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
            % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
            % GROUND_LOOPING_POINT
    end
        gStateMachine:update(dt)
        love.keyboard.keysPressed = {}
        love.mouse.buttonsPressed = {}

        
            
    
end

function love.draw()
    push:start()
    --love.graphics.printf(tostring(bird.dy), 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    push:finish()
end
