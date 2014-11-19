local View = require("org.puremvc.lua.multicore.core.View");
local Observer = require("org.puremvc.lua.multicore.patterns.observer.Observer");

local Controller = {};
      Controller.instanceMap = {};
      Controller.MULTITON_MSG = "controller key for this Multiton key already constructed";

function Controller:new(key)
    if self.instanceMap[key] then
        error(self.MULTITON_MSG);
    end
    
    -- Create new controller instance
    local instance = {};
          instance.multitonKey = key;
          instance.commandMap = {};
          
    function instance:initializeController() 
        self.view = View:getInstance(self.multitonKey);
    end

    function instance:executeCommand(note)   
        local commandClassRef = self.commandMap[note:getName()];
        if not commandClassRef then
            return;
        end

        local commandInstance = commandClassRef:new();
              commandInstance:initializeNotifier(self.multitonKey);
              commandInstance:execute(note);
              
        -- Cleanup
        commandClassRef = nil;
        commandInstance = nil;
    end

    function instance:registerCommand(notificationName, commandClassRef)
        if self.commandMap[notificationName] == nil then
            self.view:registerObserver(notificationName, Observer:new(self.executeCommand, self));
        end
        self.commandMap[notificationName] = commandClassRef;
    end
    
    function instance:hasCommand(notificationName)
        return self.commandMap[notificationName] ~= nil;
    end
    
    function instance:removeCommand(notificationName)
        if self:hasCommand(notificationName) then
            self.view:removeObserver(notificationName, self);
            self.commandMap[notificationName] = nil;
        end
    end
       
    instance:initializeController();
       
    -- Add to instance map       
    self.instanceMap[key] = instance;

    return instance;
end

function Controller:getInstance(key)
    if key == nil then
        return key;
    end
    return self.instanceMap[key] or self:new(key);
end    

function Controller:removeController(key)
    self.instanceMap[key] = nil;
end

return Controller;