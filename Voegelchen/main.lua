push = require 'push'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Flappy Birdy')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
function love.resize(w,h)
    push:resize(w,h)
end

function love.update(dt)
   -- backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
      --  % BACKGROUND_LOOPING_POINT
    --groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
       -- % VIRTUAL_WIDTH
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    push:finish()
end
