
local Notification = {};

function Notification:new(name, body, type)

    local instance = {name=name, body=body, type=type};
    
    function instance:getName()
        return instance.name;
    end

    function instance:setName(name)
        instance.name = name;
    end

    function instance:getBody()
        return instance.body;
    end
    
    function instance:setBody(body)
        instance.body = body;
    end
    
    function instance:getType()
        return instance.type;
    end    

    function instance:setType(type)
        instance.type = type;
    end    
    
    return instance;
end

return Notification;