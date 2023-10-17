
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

// diag_log "Test This Intel!";
// diag_log ("Is server: " + (str isServer));
// diag_log _this;

if (_activated) then {

    private ["_subject","_title","_description","_intelTargetValue","_useAceInteract","_actionName","_delete"];
    _subject = _logic getVariable ["subject", "zen_modules_intel"];
    _title = _logic getVariable ["title", ""];
    _description = _logic getVariable ["description", ""];
    _intelTargetValue = _logic getVariable ["intelTargets", 0];
    if (_intelTargetValue isEqualType "") then { _intelTargetValue = parseNumber _intelTargetValue; };
    _useAceInteract = _logic getVariable ["useAceInteract", false];
    _actionName = _logic getVariable ["actionName", "Pickup Intel"];
    _delete = _logic getVariable ["delete", 2];
    if (_delete isEqualType "") then { _delete = parseNumber _delete; };

    private ["_intelArgs","_objects"];
    _objects = synchronizedObjects _logic;
    if (_objects isEqualTo []) exitWith { true; };
    _intelArgs = [_intelTargetValue,_subject,_title,_description];

    if (_useAceInteract) then {
        _objects apply { 
            [_x,_actionName,_delete,0,_intelArgs] call BAX_INTEL_fnc_addIntelActionAce; 
        };
    } else {
        _objects apply { 
            [_x,_actionName,_delete,0,_intelArgs] call BAX_INTEL_fnc_addIntelAction; 
        };
    };
};

true;
