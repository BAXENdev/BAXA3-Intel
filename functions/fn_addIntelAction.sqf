
params ["_object","_actionName","_delete","_intelFunctionNumber","_intelArgs"];

_object addAction
[
    _actionName,
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        _arguments params ["_delete","_intelFunctionNumber","_intelArgs"];

        _intelArgs = [_caller] + _intelArgs;
        if (_intelFunctionNumber == 0) then {
            _intelArgs remoteExec ["BAX_INTEL_fnc_giveIntelServer",2];
        } else {
            _intelArgs remoteExec ["BAX_INTEL_fnc_giveIntelAce",2];
        };

        switch (_delete) do {
            case 1: { [_target,_actionId] remoteExec ["removeAction"]; };
            case 2: { deleteVehicle _target; };
        };
    },
    [_delete,_intelFunctionNumber,_intelArgs], // arguments
    1.5,    // priority
    true,   // showWindow
    true,   // hideOnUse
    "",     // shortcut
    "true", // condition
    5,      // radius
    false,  // unconscious
    "",     // selection
    ""      // memoryPoint
];
