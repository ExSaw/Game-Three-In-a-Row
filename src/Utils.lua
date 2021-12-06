local Utils = {}

function Utils.wait(msec)
    local t = os.clock()
    repeat until os.clock() > t + msec * 1e-3
end

function Utils.genRandSeed()
    math.randomseed(os.time())
end

function Utils.splitString(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function Utils.terminateProgram()
    print("Program Terminated!")
    os.exit()
end

return Utils
