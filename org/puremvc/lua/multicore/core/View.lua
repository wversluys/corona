
local Observer = require "org.puremvc.lua.multicore.patterns.observer.Observer";

local View = {};
      View.instanceMap = {};
      View.MULTITON_MSG = "View instance for this Multiton key already constructed!";

function View:new(key)
    if self.instanceMap[key] then
        error(self.MULTITON_MSG);
    end
    
    -- Create new view instance    
    local instance = {};
    instance.multitonKey = key;
    instance.mediatorMap = {};
    instance.observerMap = {};
    function instance:initializeView()
    end

    function instance:registerMediator(mediator)
        if self.mediatorMap[mediator:getMediatorName()] then
            return;
        end

        mediator:initializeNotifier(self.multitonKey);
        self.mediatorMap[mediator:getMediatorName()] = mediator;

        -- get notification interests if any
        local interests = mediator:listNotificationInterests();

        -- register mediator as an observer for each notification
        if #interests > 0 then
            -- create observer referencing this mediators handleNotification method
            local observer = Observer:new(mediator.handleNotification, mediator);
            for i = 1, #interests, 1 do
                self:registerObserver(interests[i], observer);
            end
            observer = nil;
        end
        interests = nil;

        mediator:onRegister();
    end
    
    
    function instance:removeMediator(mediatorName)
        local mediator = self.mediatorMap[mediatorName];
        if mediator then
            local interests = mediator:listNotificationInterests();
            for i = 1, #interests, 1 do
                self:removeObserver(interests[i], mediator);
            end
            self.mediatorMap[mediatorName] = nil;
            mediator:onRemove();
            interests = nil;
        end
        return mediator;
    end
    
    function instance:notifyObservers(notification)
        if self.observerMap[notification:getName()] then

            local observers_ref, observers, observer = self.observerMap[notification:getName()], {};

            for i = 1, #observers_ref, 1 do
                observer = observers_ref[i];
                observers[#observers + 1] = observer;
            end

            for i = 1, #observers, 1 do
                observer = observers[i];
                observer:notifyObserver(notification);
            end
            
            -- Cleanup
            observers_ref = nil;
            observers = nil;
            observer = nil;
        end
    end
    
    function instance:registerObserver(notificationName, observer)        
        self.observerMap[notificationName] = self.observerMap[notificationName] or {};
        self.observerMap[notificationName][#self.observerMap[notificationName] + 1] = observer;
    end
    
    function instance:removeObserver(notificationName, notifyContext)

        local observers = self.observerMap[notificationName];
        for i = 1, #observers, 1 do
            if observers[i]:compareNotifyContext(notifyContext) then
                table.remove(observers, i);
                break;
            end
        end

        if #observers == 0 then
            self.observerMap[notificationName] = nil;
        end
        
        observers = nil;
    end
        
    function instance:retrieveMediator(mediatorName)
        return self.mediatorMap[mediatorName];
    end
    
    function instance:hasMediator(mediatorName)
        return self.mediatorMap[mediatorName] ~= nil;
    end
    
    -- Add to instance map
    self.instanceMap[key] = instance;
    
    return instance;
end

function View:getInstance(key)
    if key == nil then
        return key;
    end
    return self.instanceMap[key] or self:new(key);
end

function View:removeView(key)
    self.instanceMap[key] = nil;
end

return View;