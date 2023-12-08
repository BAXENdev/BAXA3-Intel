
params ["_object","_actionName","_delete","_intelFunctionNumber","_onPickupCode","_intelArgs","_pickupTargets"];

_actionID = _object addAction
[
    _actionName,
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params ["_delete","_intelFunctionNumber","_onPickupCode","_intelArgs"];

        _fullIntelArgs = [_caller] + _intelArgs;
        if (_intelFunctionNumber == 0) then {
            _fullIntelArgs remoteExec ["BAX_INTEL_fnc_giveIntelServer",2];
        } else {
            _fullIntelArgs remoteExec ["BAX_INTEL_fnc_giveAceIntel",2];
        };

        [_target,_caller,_delete,_intelArgs] call _onPickupCode;

        switch (_delete) do {
            case 1: { [_target,_actionId] remoteExec ["removeAction"]; };
            case 2: { deleteVehicle _target; };
        };
    },
    [_delete,_intelFunctionNumber,_onPickupCode,_intelArgs], // arguments
    1.5,    // priority
    true,   // showWindow
    true,   // hideOnUse
    "",     // shortcut
    "(side group _this) in (_originalTarget getVariable [(""pickupTargets_action_"" + (str _actionId)),[west,east,independent,civilian]])", // condition
    5,      // radius
    false,  // unconscious
    "",     // selection
    ""      // memoryPoint
];

_object setVariable [("pickupTargets_action_" + (str_actionID)),_pickupTargets];
