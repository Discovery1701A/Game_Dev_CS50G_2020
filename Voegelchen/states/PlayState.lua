PlayState = Class{__includes = BaseState}
PIPE_HEIGHT =288
PIPE_WIDTH = 70
PIPE_SPEED = 60
GAP_HEIGHT = 90

function PlayState:enter(params)
   
    if  params == nil then
        self.score = 0
        self.bird = Bird()
        self.pipePairs = {}
        self.timer = 0
        self.nextTime = 2
        self.lastY = -PIPE_HEIGHT + math.random(80) + 20 
    else
       
        self.score = params.score
            self.bird = params.bird
            self.pipePairs = params.pipePairs
            self.timer = params.timer
            self.lastY = params.lastY
            self.nextTime = params.nextTime
    end

end
function PlayState:update(dt) 
    
    self.timer = self.timer + dt
            if self.timer > self.nextTime then
                local y = math.max(-PIPE_HEIGHT + 10,
                    math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
                    self.lastY = y
                    table.insert(self.pipePairs, PipePair(y))
                self.nextTime = math.random(2, 5)
                self.timer = 0
            end

        self.bird:update(dt)
        for k, pair in pairs(self.pipePairs) do
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    pair.scored = true
                    sounds['score']:play()
                end
            end

            pair:update(dt)
            for l, pipe in pairs(pair.pipes)do
                if self.bird:collides(pipe) then
                    sounds['explosion']:play()
                    sounds['hurt']:play()
                    gStateMachine:change('score', {
                        score = self.score
                    })
                end
            end

            if pair.x < -PIPE_WIDTH then
                pair.remove = true
            end
        end
        for k, pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(self.pipePairs, k)
            end
        end
        if self.bird.y > VIRTUAL_HEIGHT - 15 then
            gStateMachine:change('score', {
                score = self.score
            })
        end
        if love.keyboard.wasPressed('p') then
            gStateMachine:change('pause', {
                bird = self.bird,
                pipePairs = self.pipePairs,
                timer = self.timer,
                nextTime = self.nextTime,
                score = self.score,
                lastY = self.lastY
            })
        end
    end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    self.bird:render()
end
