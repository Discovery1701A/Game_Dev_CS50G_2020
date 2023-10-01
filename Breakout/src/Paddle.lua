Paddle = Class{}

function Paddle:init()
    -- x is placed in the middle
    self.x = VIRTUAL_WIDTH / 2 - 32
    -- y is placed a little above the bottom edge of the screen
    self.y = VIRTUAL_HEIGHT - 32
    -- start us off with no velocity
    self.dx = 1
    self.skin = 1
    -- starting dimensions
    self.width = 64
    self.height = 16
    self.size = 2
end

function Paddle:update(dt)
    -- keyboard input
    if love.keyboard.isDown('left') then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end
    -- math.max here ensures that we're the greater of 0 or the player's
    -- current calculated Y position when pressing up so that we don't
    -- go into the negatives; the movement calculation is simply our
    -- previously-defined paddle speed scaled by dt
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(gTextures['main'], gFrames['paddles'][self.size + 4 * (self.skin - 1)],
        self.x, self.y)
end