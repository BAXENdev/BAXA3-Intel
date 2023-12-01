params ["_caller","_intelTargetValue","_subject","_title","_description","_notify","_force"];

private ["_intelTargets"];
_allPlayers = allPlayers - (entities "HeadlessClient_F");
switch (_intelTargetValue) do {
    case 1: { _intelTargets = _allPlayers select { (group _x) isEqualTo (group _caller); }; };
    case 2: { _intelTargets = _allPlayers select { (side group _x) isEqualTo (side group _caller); }; };
    case 3: { _intelTargets = _allPlayers; };
    default { _intelTargets = [_caller]; };
};

_intelTargets apply {
	[_subject,_title,_description,_notify,_force] remoteExec ["BAX_INTEL_fnc_giveIntelClient",_x];
};
