
local Facade = require "org.puremvc.lua.multicore.patterns.facade.Facade";

local Notifier = {};
      Notifier.MULTITON_MSG = "multitonKey for this Notifier not yet initialized!";

function Notifier:new()
    local instance = {};
    
    function instance:sendNotification(notificationName, body, type)
        local facade = self:getFacade();
        if facade then
            facade:sendNotification(notificationName, body, type);
        end
    end
    
    function instance:initializeNotifier(key)
        self.multitonKey = key;
        self.facade = instance:getFacade();
    end
    
    function instance:getFacade()
        if self.multitonKey == nil then
            error(Notifier.MULTITON_MSG);
        end
        return Facade:getInstance(self.multitonKey);
    end

    return instance;
end

return Notifier;