--[[
    @title          Application Constants
    @Author:        Wouter Versluijs
    @Date:          19 november 2014

    @description
    Various constants used throughout the application
]]--

local M = {};

      -- Packages
      M.MVC_CORE                    = 'org.puremvc.lua.multicore.core';
      M.MVC_CORE_CONTROLLER         = M.MVC_CORE..'.Controller';
      M.MVC_CORE_MODEL              = M.MVC_CORE..'.Model';
      M.MVC_CORE_VIEW               = M.MVC_CORE..'.View';

      M.MVC_PATTERNS                = 'org.puremvc.lua.multicore.patterns';
      M.MVC_COMMAND                 = M.MVC_PATTERNS..'.command';
      M.MVC_FACADE                  = M.MVC_PATTERNS..'.facade';
      M.MVC_MEDIATOR                = M.MVC_PATTERNS..'.mediator';
      M.MVC_OBSERVER                = M.MVC_PATTERNS..'.observer';
      M.MVC_PROXY                   = M.MVC_PATTERNS..'.proxy';

      M.PROJECT_NAME                = 'com.project';

return M;