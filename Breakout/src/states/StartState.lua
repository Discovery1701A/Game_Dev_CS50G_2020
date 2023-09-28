 StartState = Class{__includes = BaseState}

 local highlighted = 1

 function StartState:update(dt)

    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlighted = highlighted == 1 and 2 or 1
       -- gSounds['select']:play()
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
       -- gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('serve', {
                paddle = Paddle(),
                bricks = LevelMaker.createMap(1),
                health = 3,
                score = 0,
                highScores = self.highScores,
                level = 1
            })
        else
            love.event.quit()
        end
    end
end

function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("QUIT", 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
end




