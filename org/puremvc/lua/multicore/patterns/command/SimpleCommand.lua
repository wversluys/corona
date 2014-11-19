local Notifier = require "org.puremvc.lua.multicore.patterns.observer.Notifier";

local SimpleCommand = {};

function SimpleCommand:new()

    local instance = Notifier:new();

    function instance:execute(notification) 
    end

    return instance;
end

return SimpleCommand;