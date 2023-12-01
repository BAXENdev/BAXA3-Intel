
_logic = _this param [0,objnull,[objnull]];
_units = _this param [1,[],[[]]];
_activated = _this param [2,true,[true]];

if !(hasInterface) exitWith {};

if (_activated) then {

	waitUntil { local player; };

    private ["_subject","_displayName","_picture","_targetValue","_diaryRecord"];
    _subject = _logic getVariable ["subject", "zen_modules_intel"];
    _displayName = _logic getVariable ["displayName", "Intel"];
    _picture = _logic getVariable ["picture", ""];
	_targetValue = _logic getVariable ["targets", 7];

	// diag_log ("Test1: " + (name player));
	// diag_log [_subject,_displayName,_picture,_targetValue];

	diag_log "Test";
	diag_log name player;
	diag_log side group player;
	diag_log _targetValue;

	if (_targetValue isEqualType "") then { _targetValue = parseNumber _targetValue; };

	_subject = [((_subject splitString ",. -") joinString "_")] call BIS_fnc_filterString;

	switch (_targetValue) do {
		case 3: { if ((side group player) isEqualTo west) then { player createDiarySubject [_subject,_displayName,_picture]; }; diag_log "C3"; };
		case 4: { if ((side group player) isEqualTo east) then { player createDiarySubject [_subject,_displayName,_picture]; }; diag_log "C4"; };
		case 5: { if ((side group player) isEqualTo resistance) then { player createDiarySubject [_subject,_displayName,_picture]; }; diag_log "C5"; };
		case 6: { if ((side group player) isEqualTo civilian) then { player createDiarySubject [_subject,_displayName,_picture]; }; diag_log "C6"; };
		default { player createDiarySubject [_subject,_displayName,_picture]; diag_log "Cd"; };
	};

	// diag_log "Test2";
	// if (isNull _diaryRecord) then { _diaryRecord = "null"; };
	// diag_log (format ["T2: %1",_diaryRecord]);
};

true;
