PipePair = Class{}

-- zwischenraum zwischen den pipes
--local GAP_HEIGHT = math.random(10, 120)

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    self.y = y
    self.gap_Height= math.random(80, 140)

    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + self.gap_Height)
    }
    self.remove = false
    self.scored = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
