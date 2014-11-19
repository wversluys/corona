
local Notifier = require "org.puremvc.lua.multicore.patterns.observer.Notifier";

local Mediator = {};
Mediator.NAME= "Mediator";

function Mediator:new(mediatorName, viewComponent)

    local instance = Notifier:new();
    instance.mediatorName = mediatorName or Mediator.NAME;
    instance.viewComponent = viewComponent;  
    
    function instance:getMediatorName()
        return self.mediatorName;
    end
    
    function instance:setViewComponent(viewComponent)
        self.viewComponent = viewComponent;
    end    
    
    function instance:getViewComponent()
        return self.viewComponent;
    end
    
    function instance:listNotificationInterests()
        return {};
    end
    
    function instance:handleNotification(notification)
        return true;
    end
    
    function instance:onRegister()
        return true;
    end

    function instance:onRemove()
        return true;
    end

    return instance;
end

return Mediator;