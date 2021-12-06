local CrystalBomb = {}

function CrystalBomb:new(num_xPos,num_yPos)

    --Private Properties
    local private={}

        --reserved letters are [A,B,C,D,E,F] you should use the others for custom crystals
        private.color = 'G'
        private.xPos = num_xPos
        private.yPos = num_yPos

    --Public Properties
    local public={}

        --Public Methods
        function public:getColor()
            return private.color
        end

        function public:getPosX()
            return private.xPos
        end

        function public:getPosY()
            return private.yPos
        end

        function public:setColor(str_color)
            private.color = str_color or 'A'
        end

        function public:setPosX(num_xPos)
            private.xPos = num_xPos or 0
        end

        function public:setPosY(num_yPos)
            private.yPos = num_yPos or 0
        end

    --setting table
    setmetatable(public, self)
    self.__index = self; return public

end