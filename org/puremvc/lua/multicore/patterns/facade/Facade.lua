local Model = require "org.puremvc.lua.multicore.core.Model";
local View = require "org.puremvc.lua.multicore.core.View";
local Controller = require "org.puremvc.lua.multicore.core.Controller";
local Notification = require "org.puremvc.lua.multicore.patterns.observer.Notification";

local Facade = {};
Facade.instanceMap = {};
Facade.MULTITON_MSG = "Facade instance for self Multiton key already constructed!";

function Facade:new(key)

    if self.instanceMap[key] then
        error(self.MULTITON_MSG);
    end    
    
    local instance = {};
    function instance:initializeNotifier(key)    
    end

    function instance:initializeController()
        if self.controller then
            return;
        end
        self.controller = Controller:getInstance(self.multitonKey);
    end
    
    function instance:initializeModel()
        if self.model then
            return;
        end
        self.model = Model:getInstance(self.multitonKey);
    end

    function instance:initializeView()
        if self.view then
            return;
        end
        self.view = View:getInstance(self.multitonKey);
    end
    
    function instance:initializeFacade()
        self:initializeModel();
        self:initializeController();
        self:initializeView();
    end

    function instance:registerCommand(notificationName, commandClassRef)
        self.controller:registerCommand(notificationName, commandClassRef);
    end

    function instance:removeCommand(notificationName)
        self.controller:removeCommand(notificationName);
    end

    function instance:hasCommand(notificationName)
        return self.controller:hasCommand(notificationName);
    end
    
    function instance:registerProxy(proxy)
        self.model:registerProxy(proxy);
    end

    function instance:retrieveProxy(proxyName)
        return self.model:retrieveProxy(proxyName);
    end

    function instance:removeProxy(proxyName)
        local proxy;
        if self.model then
            proxy = self.model:removeProxy(proxyName);
        end
        return proxy;
    end

    function instance:hasProxy(proxyName)
        return self.model:hasProxy(proxyName);
    end

    function instance:registerMediator(mediator)
        if self.view then
            self.view:registerMediator(mediator);
        end
    end

    function instance:retrieveMediator(mediatorName)
        return self.view:retrieveMediator(mediatorName);
    end

    function instance:removeMediator(mediatorName)
        local mediator;
        if self.view then
            mediator = self.view:removeMediator(mediatorName);
        end
        return mediator;
    end

    function instance:hasMediator(mediatorName)
        return self.view:hasMediator(mediatorName);
    end

    function instance:sendNotification(notificationName, body, type)
        self:notifyObservers(Notification:new(notificationName, body, type));
    end

    function instance:notifyObservers(notification)
        if self.view then
            self.view:notifyObservers(notification);
        end
    end

    function instance:initializeNotifier(key)
        self.multitonKey = key;
    end
    instance:initializeNotifier(key);

    self.instanceMap[key] = instance;
    
    return instance;    
end

function Facade:getInstance(key)
    if key == nil then
	return key;
    end
    return self.instanceMap[key] or self:new(key);                
end

function Facade:hasCore(key)
    return self.instanceMap[key] ~= nil;
end

function Facade:removeCore(key)
    if self.instanceMap[key] == nil then
        return;
    end

    Model:removeModel(key);
    View:removeView(key);
    Controller:removeController(key);
    self.instanceMap[key] = nil;
end

return Facade;