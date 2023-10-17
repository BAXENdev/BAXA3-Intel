class CfgPatches {
    class BAX_Intel {
        units[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"A3_Modules_F"};
    };
};

// class CfgFactionClasses {
//     class NO_CATEGORY;
//     class BAX_Intel: NO_CATEGORY {
//         displayName = "[BAX] Intel";
//     };
// };

class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit;					// Default edit box (i.e. text input field)
            class EditMulti5;
            class Combo;				// Default combo box (i.e. drop-down menu)
            class Checkbox;				// Default checkbox (returned value is Boolean)
            class ModuleDescription;	// Module description
        };

        // Description base classes (for more information see below):
        class ModuleDescription {
            class AnyBrain;
        };
    };

    class BAX_Module_AddIntelAction: Module_F {
        scope = 2;
        displayName = "[BAX] Add Intel Action";
        icon = "a3\modules_f_curator\data\icondiary_ca.paa";
        category = "Intel";

        function = "BAX_INTEL_fnc_addIntelInit";
        functionPriority = 2;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 1;
        // curatorInfoType = "";

        class Attributes: AttributesBase {
            class SubCategoryIntel {
                data = "AttributeSystemSubcategory";
                control = "SubCategory";
                displayName = "Intel Settings";
            };

            class Subject: Edit {
                displayName = "Diary Subject";
                tooltip = "The subject used with createDiaryRecord. Default value ""zen_modules_intel"" is the same subject that the zen intel module uses.";
                property = "BAX_Module_Intel_Subject";
                defaultValue = "'zen_modules_intel'";
            };

            class Title: Edit {
                displayName = "Intel Title";
                tooltip = "Use the same title for multiple intel for the intel to grouped together."
                property = "BAX_Module_Intel_Title";
                defaultValue = "''";
            };

            // class Description: EditMulti5 {
            class Description {
                control = "EditcodeMulti5";
                displayName = "Intel Description";
                property = "BAX_Module_Intel_Description";
                expression = "_this setVariable ['%s',_value,true];";
                typeName = "STRING";
                defaultValue = "''";
            };

            // class Targets: Combo {
            class IntelTargets: Combo {
                displayName = "Give To";
                tooltip = "Whether to give to the player who up the intel, the player's group, the player's side, or everyone.";
                property = "BAX_Module_Intel_IntelTargets";
                defaultValue = 2;
                typeName = "NUMBER";
                class Values {
                    class Player      { name = "Player";         value = 0; };
                    class PlayerGroup { name = "Player's Group"; value = 1; };
                    class PlayerSide  { name = "Player's Side";  value = 2; default = 1; };
                    class West        { name = "Blufor";         value = 3; };
                    class East        { name = "Opfor";          value = 4; };
                    class Guer        { name = "Indfor";         value = 5; };
                    class Civ         { name = "Civlian";        value = 6; };
                    class Everyone    { name = "Everyone";       value = 7; };
                };
            };

            class SubCategoryAction {
                data = "AttributeSystemSubcategory";
                control = "SubCategory";
                displayName = "Action Settings";
            };

            class UseAceInteract: Checkbox {
                displayName = "Use Ace Interect";
                tooltip = "Whether to use arma's addAction (scroll menu) or add ace interaction. If ace is loaded, module will fail without error.";
                property = "BAX_Module_Intel_UseAceInteract";
                defaultValue = "false";
            };

            class ActionName: Edit {
                displayName = "Action Name";
                tooltip = "Action's name shown in scroll menu or ace interact menu.";
                property = "BAX_Module_Intel_ActionName";
                defaultValue = "'Pickup Intel'";
            };

            class Delete: Combo {
                displayName = "Delete on Pickup";
                tooltip = "When a player pick's up the object, whether to delete nothing, the action, or the object.";
                property = "BAX_Module_Intel_Delete";
                defaultValue = 2;
                typeName = "NUMBER";
                class Values {
                    class Nothing { name = "Nothing"; value = 0; };
                    class Action  { name = "Action";  value = 1; };
                    class Object  { name = "Object";  value = 2; default = 1; };
                };
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Adds an action to the object that will give the selected targets the intel.<br/>If the given subject has not been created, then the subject will use ""zen_modules_intel"".<br/>If Ace Interact is selected and Ace is not loaded, the module will fail without error.<br/>Content can use images and styling according to: https://community.bistudio.com/wiki/createDiaryRecord";
        };
    };

    class BAX_Module_AddIntelActionAce: Module_F {
        scope = 2;
        displayName = "[BAX] Add Ace Intel Action";
        icon = "a3\modules_f_curator\data\icondiary_ca.paa";
        category = "Intel";

        function = "BAX_INTEL_fnc_addIntelInitAce";
        functionPriority = 2;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 1;
        // curatorInfoType = "";

        class Attributes: AttributesBase {
            class SubCategoryIntel {
                data = "AttributeSystemSubcategory";
                control = "SubCategory";
                displayName = "Intel Settings";
            };

            class IntelType: Combo {
                displayName = "Intel Type";
                // tooltip = "";
                property = "BAX_Module_Intel_IntelType";
                defaultValue = 0;
                typeName = "STRING";
                class Values {
                    class Documents { name = "Documents"; value = "acex_intelitems_document"; default = 1; };
                    class Notepad   { name = "Notepad";   value = "acex_intelitems_notepad"; };
                    class Photo     { name = "Photo";     value = "acex_intelitems_photo"; };
                };
            };

            // class Description: EditMulti5 {
            class Content {
                control = "EditcodeMulti5";
                displayName = "Intel Content";
                property = "BAX_Module_Intel_Content";
                tooltip = "For the photo intel type, content needs to be a filepath to an image.";
                expression = "_this setVariable ['%s',_value,true];";
                typeName = "STRING";
                defaultValue = "''";
            };

            class IntelTargets: Combo {
                displayName = "Give To";
                tooltip = "Whether to give to the player who up the intel, the player's group, the player's side, or everyone.";
                property = "BAX_Module_Intel_IntelTargets";
                defaultValue = 2;
                typeName = "NUMEBR";
                class Values {
                    class Player      { name = "Player";         value = 0; };
                    class PlayerGroup { name = "Player's Group"; value = 1; };
                    class PlayerSide  { name = "Player's Side";  value = 2; default = 1; };
                    class West        { name = "Blufor";         value = 3; };
                    class East        { name = "Opfor";          value = 4; };
                    class Guer        { name = "Indfor";         value = 5; };
                    class Civ         { name = "Civlian";        value = 6; };
                    class Everyone    { name = "Everyone";       value = 7; };
                };
            };

            class SubCategoryAction {
                data = "AttributeSystemSubcategory";
                control = "SubCategory";
                displayName = "Action Settings";
            };

            class UseAceInteract: Checkbox {
                displayName = "Use Ace Interect";
                tooltip = "Whether to use arma's addAction (scroll menu) or add ace interaction. If ace is loaded, module will fail without error.";
                property = "BAX_Module_Intel_UseAceInteract";
                defaultValue = "false";
            };

            class ActionName: Edit {
                displayName = "Action Name";
                tooltip = "Action's name shown in scroll menu or ace interact menu.";
                property = "BAX_Module_Intel_ActionName";
                defaultValue = "'Pickup Intel'";
            };

            class Delete: Combo {
                displayName = "Delete on Pickup";
                tooltip = "When a player pick's up the object, whether to delete nothing, the action, or the object.";
                property = "BAX_Module_Intel_Delete";
                defaultValue = 2;
                typeName = "NUMBER";
                class Values {
                    class Nothing { name = "Nothing"; value = 0; };
                    class Action  { name = "Action";  value = 1; };
                    class Object  { name = "Object";  value = 2; default = 1; };
                };
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Adds an action to the object that will give the selected targets ace intel.<br/>If ACE is not loaded, the module will fail without error.";
        };
    };

    class BAX_Module_CreateDiarySubject: Module_F {
        scope = 2;
        displayName = "[BAX] Create Diary Subject";
        icon = "a3\modules_f_curator\data\icondiary_ca.paa";
        category = "Intel";

        function = "BAX_INTEL_fnc_addDiarySubjectInit";
        functionPriority = 1;
        isGlobal = 2;
        isTriggerActivated = 1;
        isDisposable = 1;
        // curatorInfoType = "";

        class Attributes: AttributesBase {
            class Subject: Edit {
                displayName = "Diary Subject";
                tooltip = "The subject used with BIS_fnc_createDiaryRecord.";
                property = "BAX_Module_Intel_Subject";
                defaultValue = "'zen_modules_intel'";
            };

            class DisplayName: Edit {
                displayName = "Subject Display Name";
                tooltip = "Display Name is in the upperleft corner of the map menu for grouping intel together."
                property = "BAX_Module_Intel_DisplayName";
                defaultValue = "''";
            };

            class ModuleDescription: ModuleDescription {};
        };

        class ModuleDescription: ModuleDescription {
            description = "Creates a custom diary subject for diary intel to be grouped under.";
        };
    };
};

class CfgFunctions {
    class BAX_INTEL {
        class intel {
            file = "\bax_intel\functions";
            class addDiarySubjectInit {};
            class addIntelAction {};
            class addIntelActionAce {};
            class addIntelInit {};
            class addIntelInitAce {};
            class giveIntelAce {};
            class giveIntelClient {};
            class giveIntelServer {};
        };
    };
};
