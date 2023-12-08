
params ["_object","_actionName","_delete","_intelFunctionNumber","_onPickupCode","_intelArgs"];
params ["_object","_actionName","_delete","_intelFunctionNumber","_onPickupCode","_intelArgs","_pickupTargets"];

if (isNull (configFile >> "CfgPatches" >> "ace_interact_menu")) exitWith {
    diag_log "[BAX] Intel: ace_interact_menu is not loaded";
};

_actionId = _object getVariable ["aceActionIdCount",100];
_object setVariable ["aceActionIdCount",_actionId + 1];
_actionVarName = ((_actionName splitString " ") joinString "_") + "_" + (str _actionId);
_object setVariable [("pickupTargets_ace_" + (str _actionId)),_pickupTargets];

_action = [
	_actionVarName, // Variable name
	_actionName, // Display name
	"", //  Icon path
	{
        params ["_target", "_caller", "_arguments"];
        _arguments params ["_actionVarName","_delete","_intelFunctionNumber","_onPickupCode","_intelArgs"];
        _arguments params ["_actionVarName","_delete","_intelFunctionNumber","_onPickupCode","_actionId","_intelArgs"];

        _fullIntelArgs = [_caller] + _intelArgs;
        if (_intelFunctionNumber == 0) then {
            _fullIntelArgs remoteExec ["BAX_INTEL_fnc_giveIntelServer",2];
        } else {
            _fullIntelArgs remoteExec ["BAX_INTEL_fnc_giveAceIntel",2];
        };

        [_target,_caller,_delete,_intelArgs] call _onPickupCode;

        switch (_delete) do {
            case 1: { 
                [
                    _target,
                    0,
                    ["ACE_MainActions",_actionVarName]
                ] remoteExec ["ace_interact_menu_fnc_removeActionFromObject"];
            };
            case 2: { deleteVehicle _target; };
        };
    }, // Action code. params ["_target","_player","_params"]
	{
        params ["_target","_player","_args"];
        _actionId = _args select 4;        
        _pickupTargets = _target getVariable [("pickupTargets_ace_" + (str _actionId)),[west,east,independent,civilian]];
        // return
        (side group player) in _pickupTargets;
    }, // Condition code
	{}, // Insert children code, Optional
	[_actionVarName,_delete,_intelFunctionNumber,_onPickupCode,_intelArgs]
	[_actionVarName,_delete,_intelFunctionNumber,_onPickupCode,_actionId,_intelArgs]
] call ace_interact_menu_fnc_createAction;

[
	_object, // Object to add action to
	0, // Type of action. 0 = action, 1 = self-actions
	["ACE_MainActions"],
	_action
] call ace_interact_menu_fnc_addActionToObject;
