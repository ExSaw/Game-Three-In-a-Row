local utils = require("Utils")
local Input = {}

function Input.waitForCommand()
    local input = io.read()
    input = string.upper(input)
    local words = utils.splitString(input," ")
    local to = words[4]
    local from = {tonumber(words[2]),tonumber(words[3])}

    if checkInputSyntax(words) == true then
        return from,to
    else
        to = nil
        print("Wrong Command! Only commands:( m stroke row lrud )  and ( q ) allowed. Example: m 2 5 r")
    end

end

--only commands:   m # # lrud   and   q   allowed
function checkInputSyntax(words)

    if words[1] == 'Q' then
        utils.terminateProgram()
    elseif words[1] == 'M' then
        if type(tonumber(words[2])) == "number" then
            if type(tonumber(words[3])) == "number" then
                if words[4] == 'L' or words[4] == 'R' or words[4] == 'U' or words[4] == 'D' then
                    return true
                end
            end
        end
    end

    return false

end

return Input