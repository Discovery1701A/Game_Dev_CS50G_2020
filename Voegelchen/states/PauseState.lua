PauseState = Class{__includes = BaseState}
function PauseState:enter(params)
        self.score = params.score +10
        self.bird = params.bird
        self.pipePairs = params.pipePairs
        self.timer = params.timer
        self.lastY = params.lastY
        self.nextTime = params.nextTime
    

end
function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            nextTime = self.nextTime,
            score = self.score,
            lastY = self.lastY
        })
    end
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    self.bird:render()

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Pause', 0, 64, VIRTUAL_WIDTH, 'center')

end