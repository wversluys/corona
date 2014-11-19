local Model = {};
      Model.instanceMap = {};
      Model.MULTITON_MSG = "Model instance for this Multiton key already constructed!";

function Model:new(key)
    if self.instanceMap[key] then
        error(self.MULTITON_MSG);
    end
    
    -- Create new model instance
    local instance = {};
          instance.multitonKey = key;
          instance.proxyMap = {};
    function instance:initializeModel() 
    
    end

    function instance:registerProxy(proxy)
        proxy:initializeNotifier(self.multitonKey);
        self.proxyMap[proxy:getProxyName()] = proxy;
        proxy:onRegister();    
    end
    
    function instance:retrieveProxy(proxyName)
        return self.proxyMap[proxyName];
    end

    function instance:hasProxy(proxyName)
        return self.proxyMap[proxyName] ~= nil;
    end
    
    function instance:removeProxy(proxyName)
        local proxy = self.proxyMap[proxyName];
        if proxy then
            self.proxyMap[proxyName] = nil;
            proxy:onRemove();
        end
        return proxy;
    end
    
    -- Add to instance map
    self.instanceMap[key] = instance;
    
    return instance;
end

function Model:getInstance(key)
    if key == nil then
        return nil;
    end
    return self.instanceMap[key] or self:new(key);
end
    
function Model:removeModel(key)
    self.instanceMap[key] = nil;
end
 
return Model;