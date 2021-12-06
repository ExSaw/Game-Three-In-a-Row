require("Crystal")

GameField = {}

-- Global private variables:
local width = 9
local height = 9
local mixIterations = 250
local movePattern = {'L','R','U','D'}
local lastMoveAction = {0,0,0,0}

-- Global private methods:
local function printRes ()
    print ("w="..width.." h="..height)
end

-- Access to global private variables
function GameField.setWidth (value)
    width = value
end

function GameField.setHeight (value)
    height = value
end

-- Global public variables:
-- GameField.var = value

function GameField.new()
    local self = {}

    -- Private variables:
    local gameFieldArray = {}
    local matchedGameFieldArray = {}

    -- Public variables:
    -- self.var = value

    -- Private methods:
    local function create()
        for i=0,width do
            gameFieldArray[i]={}
            matchedGameFieldArray[i]={}
            for j=0,height do
                gameFieldArray[i][j]=Crystal.new()
                matchedGameFieldArray[i][j]=' '
            end
        end
    end

    local function clone()
        for i=0,width do
            for j=0,height do
                matchedGameFieldArray[i][j] = gameFieldArray[i][j]
            end
        end
    end

    --Public methods:
    function self.mix()
        for i=0,mixIterations,1 do
            local from = {math.random(10)-1,math.random(10)-1}
            local to = movePattern[math.random(4)]
            self.move(from,to)
        end
    end

    function self.getColor(posX,posY)
        return gameFieldArray[posX][posY].getColor()
    end

    function self.move(from,to)

        if to ~= nil then
            if to == 'L' then
                to = {0, -1}
            elseif to == 'R' then
                to = {0, 1}
                elseif to == 'U' then
                to = {-1, 0}
                    elseif to == 'D' then
                    to = {1, 0}
            end

            if from[1]+to[1] >= 0 and from[1]+to[1] <= width and from[2]+to[2] >= 0 and from[2]+to[2] <= height then
                local memory = gameFieldArray[from[1]][from[2]]
                gameFieldArray[from[1]][from[2]] = gameFieldArray[from[1]+to[1]][from[2]+to[2]]
                gameFieldArray[from[1]+to[1]][from[2]+to[2]] = memory
                lastMoveAction = {from[1],from[2],to[1],to[2]}
            end
        end

    end

    function self.fill()

        for i = 0,9 do
            for j = 0,9 do
                if gameFieldArray[i][j].getColor() == ' ' then
                    gameFieldArray[i][j].setColorRand()
                end
            end
        end

    end

    function self.physics()

        for j = 0,9 do
            for i = 9,0,-1 do
                    if gameFieldArray[i][j].getColor() ~= ' ' then
                        for ip=i,9 do
                            if ip+1<10 and gameFieldArray[ip+1][j].getColor() == ' ' then
                                local memory = gameFieldArray[ip+1][j]
                                gameFieldArray[ip+1][j] = gameFieldArray[ip][j]
                                gameFieldArray[ip][j] = memory
                            end
                        end

                    end
            end
        end

    end

    function self.validateIfSolvable()

        for i = 0,9 do
            for j = 0,9 do
                if  i-2>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-2][j].getColor() then --1
                    if i-3>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-3][j].getColor() then --2
                        return true
                    elseif j-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j-1].getColor() then --3
                        return true
                    elseif j+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j+1].getColor() then --4
                        return true
                    elseif gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j].getColor() then --5
                        if j-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-2][j-1].getColor() then --6
                            return true
                        elseif j+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i-2][j+1].getColor() then --7
                            return true
                        end
                    end

                    elseif j+2<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i][j+2].getColor() then --1
                        if j+3<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i][j+3].getColor() then --2
                            return true
                        elseif i-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j+1].getColor() then --3
                            return true
                        elseif i+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j+1].getColor() then --4
                            return true
                        elseif gameFieldArray[i][j].getColor() == gameFieldArray[i][j+1].getColor() then --5
                            if i-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j+2].getColor() then --6
                                return true
                            elseif i+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j+2].getColor() then --7
                                return true
                            end
                        end

                    elseif i+2<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+2][j].getColor() then --1
                        if i+3<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+3][j].getColor() then --2
                            return true
                        elseif j-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j-1].getColor() then --3
                            return true
                        elseif j+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j+1].getColor() then --4
                            return true
                        elseif gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j].getColor() then --5
                            if j-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i+2][j-1].getColor() then --6
                                return true
                            elseif j+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+2][j+1].getColor() then --7
                                return true
                            end
                        end

                    elseif j-2>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i][j-2].getColor() then --1
                        if j-3>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i][j-3].getColor() then --2
                            return true
                        elseif i-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j-1].getColor() then --3
                            return true
                        elseif i+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j-1].getColor() then --4
                            return true
                        elseif gameFieldArray[i][j].getColor() == gameFieldArray[i][j-1].getColor() then --5
                            if i-1>=0 and gameFieldArray[i][j].getColor() == gameFieldArray[i-1][j-2].getColor() then --6
                                return true
                            elseif i+1<=9 and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j-2].getColor() then --7
                                return true
                            end
                        end

                end
            end
        end

        return false

    end

    function  self.findAndRemoveCoincided()

        local clean = true

        --vertical
        for i = 0,9 do

            local matched = 0
            for j = 0,9 do

                if j+1 <= 9 and gameFieldArray[i][j].getColor() ~= ' '
                        and gameFieldArray[i][j].getColor() == gameFieldArray[i][j+1].getColor() then
                    matched = matched + 1
                elseif matched >= 2 then
                    for k = 0, matched do
                        matchedGameFieldArray[i][j-k] = gameFieldArray[i][j-k].getColor()
                        matched = 0
                    end
                else matched = 0
                end
            end
        end

        --horizontal
        for j = 0,9 do

            local matched = 0
            for i = 0,9 do

                if i+1 <= 9 and gameFieldArray[i][j].getColor() ~= ' '
                        and gameFieldArray[i][j].getColor() == gameFieldArray[i+1][j].getColor() then
                    matched = matched + 1
                elseif matched >= 2 then
                    for k = 0, matched do
                        matchedGameFieldArray[i-k][j] = gameFieldArray[i-k][j].getColor()
                        matched = 0
                    end
                else matched = 0
                end
            end
        end

        --update fields
        for i = 0,9 do
            for j = 0,9 do
                if matchedGameFieldArray[i][j] ~= ' ' then
                    if clean == true then clean = false end
                    gameFieldArray[i][j].setColor(0)
                    matchedGameFieldArray[i][j] = ' '
                end
            end
        end


        if clean == true then
            local memory = gameFieldArray[lastMoveAction[1]][lastMoveAction[2]]
            gameFieldArray[lastMoveAction[1]][lastMoveAction[2]] = gameFieldArray[lastMoveAction[3]][lastMoveAction[4]]
            gameFieldArray[lastMoveAction[3]][lastMoveAction[4]] = memory
        end

        return clean
    end


    -- Apply private methods
    create()

    return self

end