XCVB: Next Generation (HaxeFlixel Port)
A modern port of the classic Flash game XCVB, rebuilt using HaxeFlixel. 
This version replaces the original ActionScript 3 / Flixel 2.55 engine to ensure compatibility with modern desktop and web platforms.
🚀 Current Status
Core Engine: Ported to Haxe 4.3+ and HaxeFlixel 5.0+.
Menu: Fully functional with a dynamic HSV color-cycling background.
Level Select: Implemented a 25-level slider system .
Gameplay: Level 1 and Level 2 BAW are playable with corrected goal coordinates $(96, 192)$ and $(40, 192)$ from the original source.
Save System: Persistent level unlocking via XCVBLevelData.

🛠 Tech Stack
Language: HaxeFramework: HaxeFlixel
Build Tool: Lime / OpenFL
🎨 Credits
Programming & Art: David Ryan
Music: Jarryd "Atomsmasha" Nielsen
Porting Assistance: Google Gemini
📝 How to Build
Install Haxe.
Install HaxeFlixel via terminal:Bash
haxelib install mmvc
haxelib install flixel
haxelib run limetools setup
Compile the project:Bashlime test windows   # For Desktop
lime test html5     # For Web
