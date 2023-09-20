require 'src/Dependencies'


function love.load()
     love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Breakout')
    math.randomseed(os.time())

    gFonts = {
        ['small'] = love.graphics.newFont('fonts/EarthrealmBold-Edmg.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/EarthrealmBold-Edmg.ttf', 14),
        ['large'] = love.graphics.newFont('fonts/EarthrealmBold-Edmg.ttf', 28)
    }

    gTextures = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['main'] = love.graphics.newImage('graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
    }
end

