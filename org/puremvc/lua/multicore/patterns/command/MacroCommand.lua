local Notifier = require "org.puremvc.lua.multicore.patterns.Notifier";

local MacroCommand = {};

function MacroCommand:new()

    local instance = Notifier:new();
    instance.subCommands = {};
    
    function instance:initializeMacroCommand()
    end    
    
    function instance:addSubCommand(commandClassRef)
        self.subCommands[#self.subCommands + 1] = commandClassRef;
    end
    
    function instance:execute(note)
        while #self.subCommands > 0 do
            local ref, cmd = self.subCommands[1];
            table.remove(self.subCommands, 1);            
            cmd = ref:new();
            cmd:initializeNotifier(self.multitonKey);
            cmd:execute(note);
        end
    end    
    
    return instance;
end

return MacroCommand;