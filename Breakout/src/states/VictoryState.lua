VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
    self.paddle = params.paddle
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
    self.level = params.level
    self.highScores = params.highScores
    self.recoverPoints = params.recoverPoints
end

function VictoryState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('serve', {
            paddle = self.paddle,
            bricks = LevelMaker.createMap(self.level+1),
            health = self.health,
            score = self.score,
            ball = self.ball,
            highScores = self.highScores,
            level = self.level+1,
            recoverPoints = self.recoverPoints
        })
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function VictoryState:render()
    self.paddle:render()
    self.ball:render()
    renderScore(self.score)
    renderHealth(self.health)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level ' .. tostring(self.level) .. ' complete!', 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
end

