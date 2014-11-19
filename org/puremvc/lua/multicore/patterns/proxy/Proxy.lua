
local Notifier = require "org.puremvc.lua.multicore.patterns.observer.Notifier";

local Proxy = {};
      Proxy.NAME = "Proxy";

function Proxy:new(proxyName, data)

    local instance = Notifier:new();
    instance.proxyName = proxyName or self.NAME;
    
    function instance:getProxyName()
        return self.proxyName;
    end

    function instance:setData(data)
        self.data = data;
    end

    function instance:getData()
        return self.data;
    end

    function instance:onRegister()
        return true;
    end

    function instance:onRemove()
        return true;
    end
    
    if data then
        instance:setData(data);
    end   
    
    return instance;
end

return Proxy;