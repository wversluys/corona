
local Observer = {};

function Observer:new(notifyMethod, notifyContext)

    local instance = {};

    function instance:setNotifyMethod(notifyMethod)
        self.notify = notifyMethod;
    end
    
    function instance:setNotifyContext(notifyContext)
        self.context = notifyContext;
    end
    
    function instance:getNotifyMethod()
        return self.notify;
    end
    
    function instance:getNotifyContext()
        return self.context;
    end

    function instance:notifyObserver(notification)
        self.notify(self.context, notification);
    end

    function instance:compareNotifyContext(object)    
        return object == self.context;
    end

    instance:setNotifyMethod(notifyMethod);
    instance:setNotifyContext(notifyContext);
    
    return instance;
end

return Observer;