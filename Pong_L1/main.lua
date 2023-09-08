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
    largeFont = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 16)
    soreFont = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 32)
    love.graphics.setFont(smallFont)

    sound = {['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
    ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
}

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
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

function love.resize(w,h)
    push:resize(w,h)
end

function love.update(dt)
   
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
                 sound['paddle_hit']:play()
            end
            if ball:collides(player2)then
                ball.dx = -ball.dx * 1.03
                ball.x = player2.x - ball.width
    
                if ball.dy <0 then
                    ball.dy = -math.random(10,150)
    
                else
                    ball.dy = math.random(10,150)
                end
                sound['paddle_hit']:play()
            end
            if ball.y <= 0 then
                ball.y = 0
                ball.dy = -ball.dy
                sound['wall_hit']:play()
            end
            if ball.y >= VIRTUAL_HEIGHT - 4 then
                ball.y = VIRTUAL_HEIGHT - 4
                ball.dy = -ball.dy
                sound['wall_hit']:play()
            end

   
        ball:update(dt)
    end
    if ball.x+ball.width < 0 then
        serveringPlayer = 1
        if gameState == 'play' then
            player2Score = player2Score + 1
            sound['score']:play()
        end
        if player2Score == 10 then
            winningPlayer = 2
            gameState = 'done'
        else
        gameState = 'serve'
        ball:reset()
        end
    
    elseif ball.x > VIRTUAL_WIDTH then
        serveringPlayer = 2
        if gameState == 'play' then
            
            player1Score = player1Score + 1
            sound['score']:play()
        end
        if player1Score == 10 then
            winningPlayer = 1
            gameState = 'done'
        else
        gameState = 'serve'
        ball:reset()
        end
    end
    --if love.keyboard.isDown('w') then
        --player1.dy = -PADDLE_SPEED
   -- elseif love.keyboard.isDown('s') then
        --player1.dy = PADDLE_SPEED
    --else 
        --player1.dy = 0
    
    --end
    
    --if love.keyboard.isDown('up') then
        --player2.dy = -PADDLE_SPEED
    --elseif love.keyboard.isDown('down') then
       -- player2.dy = PADDLE_SPEED
   -- else
       -- player2.dy = 0
    --end
    if player == 1 or player == 0 then
        if ball.dx > 0 then
            if ball.y < player2.y then
                player2.dy = -PADDLE_SPEED
            elseif ball.y > player2.y + player2.height then
                player2.dy = PADDLE_SPEED
            else
                player2.dy = 0
            end
        end
    else
        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    end
    if player == 0 then
        if ball.dx < 0 then
            if ball.y < player1.y then
                player1.dy = -PADDLE_SPEED
            elseif ball.y > player1.y + player1.height then
                player1.dy = PADDLE_SPEED
            else
                player1.dy = 0
            end
        end
    else
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else 
            player1.dy = 0
        
        end
    end

    player1:update(dt)
    player2:update(dt)

    

end



function love.keypressed(key)
    if key == '1'then
        player = 1
    elseif key == '2' then
        player = 2
    elseif key == '0' then
        player = 0
    end
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
            --ball:reset()
        elseif gameState == 'done' then
            player1Score = 0
            player2Score = 0

            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
                
            end
            ball:reset()
            gameState = 'serve'

            
            
            
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

    elseif gameState == 'done'then
        love.graphics.setFont(largeFont)
        love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!',0, 10, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!',0,30,VIRTUAL_WIDTH,'center')
    end
displayScore()
   
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