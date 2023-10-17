
params ["_subject","_title","_description"];

if !(player diarySubjectExists _subject) then {
	_subject = "zen_modules_intel";
	if !(player diarySubjectExists "zen_modules_intel") then {
		player createDiarySubject ["zen_modules_intel","Intel"];
	};
};

[
	"TaskAssigned",
	["","Intel Collected"]
] call BIS_fnc_showNotification;

player createDiaryRecord [_subject,[_title,_description]];
