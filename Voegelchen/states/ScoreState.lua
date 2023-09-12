ScoreState = Class{__includes = BaseState}
rang ={1,2,3}
gold =love.graphics.newImage('Gold.png')
silber = love.graphics.newImage('Silber.png')
bronze =love.graphics.newImage('Bronze.png')
medalien ={bronze,silber,gold}
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    for k = 1,3 do
        if self.score >= rang[k] then
            love.graphics.draw(medalien[k],VIRTUAL_WIDTH/2 -64, VIRTUAL_HEIGHT/2-64)
        end
    end
    love.graphics.printf('Oof! You lost!', 0, 14, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 50, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Enter to Play Again!', 0, 210, VIRTUAL_WIDTH, 'center')
end
