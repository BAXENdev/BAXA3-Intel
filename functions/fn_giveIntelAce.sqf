
params["_caller","_intelTargetValue","_aceIntelType", "_intelContent"];

private ["_intelTargets"];
_allPlayers = allPlayers - (entities "HeadlessClient_F");
switch (_intelTargetValue) do {
    case 1: { _intelTargets = _allPlayers select { (group _x) isEqualTo (group _caller); }; };
    case 2: { _intelTargets = _allPlayers select { (side group _x) isEqualTo (side group _caller); }; };
    case 3: { _intelTargets = _allPlayers select { (side group _x) isEqualTo west; }; };
    case 4: { _intelTargets = _allPlayers select { (side group _x) isEqualTo east; }; };
    case 5: { _intelTargets = _allPlayers select { (side group _x) isEqualTo resistance; }; };
    case 6: { _intelTargets = _allPlayers select { (side group _x) isEqualTo civilian; }; };
    case 7: { _intelTargets = _allPlayers; };
    default { _intelTargets = [_caller]; };
};

_intelTargets apply {
    [
        "TaskAssigned",
        ["","Intel Collected"]
    ] remoteExec ["BIS_fnc_showNotification",_x];

    // ace add intel is server only function!
    [
        _x,
        _aceIntelType,
        _intelContent
    ] call ace_intelitems_fnc_addIntel;
};
