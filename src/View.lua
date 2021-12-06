local View = {}
local lastStr = ''

function iop(str)
        local strW = lastStr
        --io.write(('\b \b'):rep(#strW))  -- erase old line
        io.write(str)                     -- write new line
        io.flush()
        lastStr = str
end

function View.draw(field)
    lastStr=''
    lastStr = lastStr.."\n\n\n  0 1 2 3 4 5 6 7 8 9\n"
    lastStr = lastStr.."  -------------------"

    for i=0,9 do
        lastStr = lastStr.."\n"..i.."|"
        for j=0,9 do
            local color = field.getColor(i,j)
            lastStr = lastStr..color..' '
        end
    end
        lastStr = lastStr.."\n  -------------------"
        lastStr = lastStr.."\n  0 1 2 3 4 5 6 7 8 9"

        lastStr = lastStr.."\n\n"
        iop(lastStr)
end

return View