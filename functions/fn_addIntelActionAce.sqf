
params ["_object","_actionName","_delete","_intelFunctionNumber","_intelArgs"];

if (isNull (configFile >> "CfgPatches" >> "ace_interact_menu")) exitWith {
    diag_log "[BAX] Intel: ace_interact_menu is not loaded";
};

_actionVarName = _actionName + "_" + (str time);

_action = [
	_actionVarName, // Variable name
	_actionName, // Display name
	"", //  Icon path
	{
        params ["_target", "_caller", "_arguments"];
        _arguments params ["_actionVarName","_delete","_intelFunctionNumber","_intelArgs"];

        _intelArgs = [_caller] + _intelArgs;
        if (_intelFunctionNumber == 0) then {
            _intelArgs remoteExec ["BAX_INTEL_fnc_giveIntelServer",2];
        } else {
            _intelArgs remoteExec ["BAX_INTEL_fnc_giveIntelAce",2];
        };

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
	{ true }, // Condition code
	{}, // Insert children code, Optional
	[_actionVarName,_delete,_intelFunctionNumber,_intelArgs]
] call ace_interact_menu_fnc_createAction;

[
	_object, // Object to add action to
	0, // Type of action. 0 = action, 1 = self-actions
	["ACE_MainActions"],
	_action
] call ace_interact_menu_fnc_addActionToObject;
