local utils = require("Utils")
local view = require("View")
local input = require("Input")
require("GameField")

-- vars
local gameField
-- states: wait = wait for input;
local state

function init()
    utils.genRandSeed()
    gameField = GameField.new() --create and fill new gameField
    dump()
    state = "check"
    tick()
end

function tick()
    utils.wait(200)
    if state ~= "check" then dump() end
    print(state.."\n")
    if state == "wait" then
        move(input.waitForCommand())
        state = "check"

    elseif state == "check" or state == "filled" then
        local clean = gameField.findAndRemoveCoincided()
        if clean == true then state = "validate" else state = "physics" end

    elseif state == "physics" then
        gameField.physics()
        state = "fill"

    elseif state == "fill" then
        gameField.fill()
        state = "filled"

    elseif state == "validate" then

        while gameField.validateIfSolvable() == false do
            gameField.mix()
        end

        state = "wait"

    end

    tick()
end

function move(from,to)
    gameField.move(from,to)
end

function mix()
    gameField.mix()
end

function dump()
    view.draw(gameField)
end

init()
