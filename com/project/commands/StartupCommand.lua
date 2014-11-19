--[[
    @title          Startup command
    @Author:        Wouter Versluijs
    @Date:          19 november 2014

    @description
    Command to startup application
    Registers commands, mediators and proxies
]]--

local Notifier = require (AppConstants.MVC_OBSERVER..'.Notifier');

local StartupCommand = {};

function StartupCommand:new()

    local instance = Notifier:new();

    function instance:execute(notification)

        local   app,
                proxy;

        -- Remove command
        self.facade:removeCommand(AppCommands.STARTUP);


        -- Fetch app view
        app = notification:getBody();


        -- Add commands
        -- self.facade:registerCommand(AppCommands.CHANGE_SCREEN, require(AppConstants.PROJECT_NAME..'.commands.ChangeScreenCommand'));
        -- package.loaded[AppConstants.PROJECT_NAME..'.commands.ChangeScreenCommand'] = nil;
    end

    return instance;
end

return StartupCommand;