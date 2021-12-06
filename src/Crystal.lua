Crystal = {}

function Crystal.new()

    local self = {}

    -- Private variables:
    local color

    -- Private methods:
    local function create()
        self.setColorRand()
    end

    --Public methods
    function self.setColor(str_color)
        --empty=0 A=1 B=2 C=3 D=4 E=5 F=6 ... add G=7(CrystalBomb) H=8 I=9 J=10 etc for more crystals
        if str_color == 0 then color = ' '
        elseif str_color == 1 then color = 'A'
        elseif str_color == 2 then color = 'B'
        elseif str_color == 3 then color = 'C'
        elseif str_color == 4 then color = 'D'
        elseif str_color == 5 then color = 'E'
        elseif str_color == 6 then color = 'F'
        end
    end

    function self.setColorRand()
        self.setColor(math.random(6))
    end

    function self.getColor()
        return color
    end

    -- Apply private methods
    create()

    return self

end