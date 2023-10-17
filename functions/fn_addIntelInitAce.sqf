
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

// diag_log "Test This Intel Ace!";
// diag_log ("Is server: " + (str isServer));
// diag_log _this;

if (_activated) then {

    private ["_intelType","_content","_intelTargetValue","_useAceInteract","_actionName","_delete"];
    _intelType = _logic getVariable ["intelType", "acex_intelitems_document"];
    _content = _logic getVariable ["content", ""];
    _intelTargetValue = _logic getVariable ["intelTargets", 0];
    if (_intelTargetValue isEqualType "") then { _intelTargetValue = parseNumber _intelTargetValue; };
    _useAceInteract = _logic getVariable ["useAceInteract", false];
    _actionName = _logic getVariable ["actionName", "Pickup Intel"];
    _delete = _logic getVariable ["delete", 2];
    if (_delete isEqualType "") then { _delete = parseNumber _delete; };

    private ["_intelFunctionName","_intelArgs","_objects"];
    _objects = synchronizedObjects _logic;
    if (_objects isEqualTo []) exitWith { true; };
    _intelFunctionName = "BAX_INTEL_fnc_giveIntelAce";
    _intelArgs = [_intelTargetValue,_intelType,_content];

    if (isNull (configFile >> "CfgPatches" >> "ace_intelitems") and isNull (configFile >> "CfgPatches" >> "acex_intelitems")) exitWith {
        diag_log "[BAX] Intel: ace_intelitems and acex_intelitems are not loaded";
    };

    if (_useAceInteract) then {
        _objects apply { 
            [_x,_actionName,_delete,1,_intelArgs] call BAX_INTEL_fnc_addIntelActionAce; 
        };
    } else {
        _objects apply { 
            [_x,_actionName,_delete,1,_intelArgs] call BAX_INTEL_fnc_addIntelAction; 
        };
    };
};

true;
