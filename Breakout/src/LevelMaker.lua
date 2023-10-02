NONE = 1
SINGLE_PYRAMID = 2
MULTI_PYRAMID = 3

SOLID = 1
ALTERNATE = 2
SKIP = 3
NONE = 4

LevelMaker = Class{}


function LevelMaker.createMap(level)
    local bricks = {}
    local numRows = math.random(1, 5)
    local numCols = math.random(7, 13)
    numCols = numCols % 2 == 0 and (numCols + 1) or numCols
    local highestTier = math.min(3, math.floor(level / 5))
    local highestColor = math.min(5, level % 5 + 3)
    for y = 1, numRows do
        local skipPattern = math.random(1, 2) == 1 and true or false
        local alternatePattern = math.random(1, 2) == 1 and true or false
        local alternateColor1 = math.random(1, highestColor)
        local alternateColor2 = math.random(1, highestColor)
        local alternateTier1 = math.random(0, highestTier)
        local alternateTier2 = math.random(0, highestTier)
        local skipFlag = math.random(2) == 1 and true or false
        local alternateFlag = math.random(2) == 1 and true or false
        for x = 1, numCols do
            b = Brick(
                (x - 1) * 32 + 8 + (13 - numCols) * 16,
                y * 16
            )
            table.insert(bricks, b)
        end
    end
    return bricks
end