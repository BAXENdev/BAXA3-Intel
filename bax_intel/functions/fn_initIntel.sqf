
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

// diag_log "Test This Intel!";
// diag_log ("Is server: " + (str isServer));
// diag_log _this;

if (_activated) then {

    private ["_subject","_title","_description","_intelTargetValue","_useAceInteract","_actionName","_delete","_notify"];
    _subject = _logic getVariable ["subject", "zen_modules_intel"];
    _title = _logic getVariable ["title", ""];
    _description = _logic getVariable ["description", ""];
    _intelTargetValue = _logic getVariable ["intelTargets", 0];
    if (_intelTargetValue isEqualType "") then { _intelTargetValue = parseNumber _intelTargetValue; };
    _notify = _logic getVariable ["notify", true];
    _useAceInteract = _logic getVariable ["useAceInteract", false];
    _actionName = _logic getVariable ["actionName", "Pickup Intel"];
    _delete = _logic getVariable ["delete", 2];
    if (_delete isEqualType "") then { _delete = parseNumber _delete; };
    _force = _logic getVariable ["force",true];
    _pickupBlufor = _logic getVariable ["pickupBlufor",true];
    _pickupOpfor = _logic getVariable ["pickupOpfor",true];
    _pickupIndfor = _logic getVariable ["pickupIndfor",true];
    _pickupCiv = _logic getVariable ["pickupCiv",true];
    _onPickupCode = _logic getVariable ["onPickupCode",{}];
    if (_onPickupCode isEqualType "") then { _onPickupCode = compile _onPickupCode; };

    private ["_intelArgs","_objects"];
    _objects = synchronizedObjects _logic;
    if (_objects isEqualTo []) exitWith { true; };
    _intelArgs = [_intelTargetValue,_subject,_title,_description,_notify,_force];

    _pickupArgs = [];
    if (_pickupBlufor) then { _pickupArgs pushBack west; };
    if (_pickupOpfor) then { _pickupArgs pushBack east; };
    if (_pickupIndfor) then { _pickupArgs pushBack independent; };
    if (_pickupCiv) then { _pickupArgs pushBack civilian; };

    if (_useAceInteract) then {
        _objects apply { 
            [_x,_actionName,_delete,0,_onPickupCode,_intelArgs,_pickupArgs] call BAX_INTEL_fnc_addAceIntelAction; 
        };
    } else {
        _objects apply { 
            [_x,_actionName,_delete,0,_onPickupCode,_intelArgs,_pickupArgs] call BAX_INTEL_fnc_addIntelAction; 
        };
    };
};

true;
