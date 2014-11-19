-- Hide status bar
display.setStatusBar(display.HiddenStatusBar);

_G.AppCommands = require('com.project.models.ApplicationCommands');
package.loaded['com.project.models.ApplicationCommands'] = nil;

_G.AppConstants = require('com.project.models.ApplicationConstants');
package.loaded['com.project.models.ApplicationConstants'] = nil;


-- Private properties
local   application,
        container,
        onSystem;


-- Private event handlers
function onSystem(e)
    if e.type == 'applicationSuspend' then
        -- Do stuff when app suspends
    elseif e.type == 'applicationResume' then
        -- Do stuff when app suspends
    end
end


-- Setup view container and application facade
container = display.newGroup();
container.anchorX = 0;
container.anchorY = 0;

application = require(AppConstants.MVC_FACADE..'.Facade'):new('MainApp');

-- Override initalise controller function to register startup command
-- This follows closely the PureMVC philosophy of overriding this function to attach your startup command
local _initializeController = application['initializeController'];
function application:initializeController()
    _initializeController(self);
    self:registerCommand(AppCommands.STARTUP, require(AppConstants.PROJECT_NAME..'.commands.StartupCommand'));
    _initializeController = nil;
end

function application:startup(view)
    -- This needs to be called to trigger initilisation
    self:initializeFacade();    
    Runtime:addEventListener('system', onSystem);
    self:sendNotification(AppCommands.STARTUP, view);
end

application:startup(container);