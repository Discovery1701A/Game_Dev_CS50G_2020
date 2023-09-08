push = require 'push'
Class = require 'class'
require 'Ball'
require 'Paddle'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
-- Load function
function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    love.window.setTitle('Pong')

    smallFont = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 10)
    soreFont = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 32)
    love.graphics.setFont(smallFont)
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    player1Score = 0
    player2Score = 0
    servingPlayer = 1
    player1 = Paddle(10,30,5,20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    gameState = 'start'

end

function love.update(dt)
    if ball.x+ball.width < 0 then
        serveringPlayer = 1
        player2Score = player2Score + 1
        ball:reset()
        gameState = 'serve'
    end
    if ball.x > VIRTUAL_WIDTH then
        serveringPlayer = 2
        player1Score = player1Score + 1
        ball:reset()
        gameState = 'serve'
    end
    if gameState == 'serve' then
        ball.dy = math.random(-50,50)
        if serveringPlayer == 1 then
            ball.dx = math.random(140,200)
        else
            ball.dx = -math.random(140,200)
        end
    elseif gameState == 'play' then
       
            if ball:collides(player1)then
             ball.dx = -ball.dx * 1.03
             ball.x = player1.x + player1.width
     
                 if ball.dy <0 then
                     ball.dy = -math.random(10,150)
     
                 else
                     ball.dy = math.random(10,150)
                 end
            end
            if ball:collides(player2)then
                ball.dx = -ball.dx * 1.03
                ball.x = player2.x - ball.width
    
                if ball.dy <0 then
                    ball.dy = -math.random(10,150)
    
                else
                    ball.dy = math.random(10,150)
                end
            end
            if ball.y <= 0 then
                ball.y = 0
                ball.dy = -ball.dy
            end
            if ball.y >= VIRTUAL_HEIGHT - 4 then
                ball.y = VIRTUAL_HEIGHT - 4
                ball.dy = -ball.dy
            end

   
        ball:update(dt)
    end
    
    if love.keyboard.isDown('w') then
        player1.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('s') then
        player1.dy = PADDLE_SPEED
    else 
        player1.dy = 0
    
    end
    if love.keyboard.isDown('up') then
        player2.dy = -PADDLE_SPEED
    elseif love.keyboard.isDown('down') then
        player2.dy = PADDLE_SPEED
    else
        player2.dy = 0
    end
    player1:update(dt)
    player2:update(dt)

    

end



function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
            ball:reset()
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    love.graphics.setFont(smallFont)
    if gameState == 'start' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Welcome to Pong!', 0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to begin!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'serve' then
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve!", 
            0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to serve!', 0, 20, VIRTUAL_WIDTH, 'center')
    elseif gameState == 'play' then
        -- no UI messages to display in play
    end
displayScore()
    --love.graphics.setFont(soreFont)
    --love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    --love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    --links
    player1:render()
    --rechts
    player2:render()
    ball:render()

    displayFPS()
    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0,255,0,255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function displayScore() 
    love.graphics.setFont(soreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

end