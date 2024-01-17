# BAXA3-Intel

## Public Functions:

### BAX_intel_fnc_giveIntelServer <br>
Create diary records for given targets.
|Parameter|Type|Description|
|-|-|-|
|_caller|Unit|The unit that "found" the intel. The receiver targets based on the caller|
|_intelTargetValue|Number|0 = caller. 1 = group of the caller. 2 = side of the caller. 3 = all players|
|_subject|String|The diary subject that the record is created under|
|_title|String|The title of the diary record. Multiple records can be grouped under a single title.|
|_description|String|The actual "intel". Allows for formatting tags like images and markers.|
|_notify|Bool|Whether or not to show a notification on the recievers screen|
|_force|Bool|Whether or not to create a diary record subject if the subject doesnt exist|

### BAX_intel_fnc_giveIntelServer <br>
Create an ace intel item for given targets. Must be called on server. Will silently fail if called on a client.
|Parameter|Type|Description|
|-|-|-|
|_caller|Unit|The unit that "found" the intel. The receiver targets based on the caller|
|_intelTargetValue|Number|0 = caller. 1 = group of the caller. 2 = side of the caller. 3 = all players|
|_intelType|String|Options: acex_intelitems_document \| acex_intelitems_notepad \| acex_intelitems_photo |
|_intelContent|String|Plain text for document and notepad. Image path for photo|
|_notify|Bool|Whether or not to show a notification on the recievers screen|
