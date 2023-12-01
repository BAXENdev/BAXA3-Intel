
params ["_subject","_title","_description","_notify","_force"];

if !(player diarySubjectExists _subject) then {
	if !(_force) exitWith {
		if (_notify) then {
			[
				"TaskAssigned",
				["","Intel is unreadable"]
			] call BIS_fnc_showNotification;
		};
	};
	
	_subject = "zen_modules_intel";
	if !(player diarySubjectExists "zen_modules_intel") then {
		player createDiarySubject ["zen_modules_intel","Intel"];
	};
};

if (_notify) then {
	[
		"TaskAssigned",
		["","Intel Collected"]
	] call BIS_fnc_showNotification;
};

player createDiaryRecord [_subject,[_title,_description]];
