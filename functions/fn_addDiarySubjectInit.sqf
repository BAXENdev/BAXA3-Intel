
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if (_activated) then {

    private ["_subject","_displayName"];
    _subject = _logic getVariable ["subject", "zen_modules_intel"];
    _displayName = _logic getVariable ["displayName", "Intel"];
    
	if !(hasInterface) exitWith {};

	_subject = [((_subject splitString ",. -") joinString "_")] call BIS_fnc_filterString;

	player createDiarySubject [_subject,_displayName];
};

true;
