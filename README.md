# Crush Crush Automator

This is an [AutoHotKey](https://www.autohotkey.com/) script for the idle game [Crush Crush](http://www.kongregate.com/games/SadPandaStudios/crush-crush) on Kongregate. This game's progression is set by the "prestige" gained upon reset, which is a number that increases based on your progress in the current game. The prestige gained progression is linear, but the time to increase is exponential, meaning that progression is far faster to reset early than it is to try to progress farther before resetting.

### How to Use
You only need the CC.ahk file.
The CC.txt file is the series of commands that I am currently using at about 600 prestige and 55 time slots. It will likely not work for you unless your progress is similar. Feel free to look at it for an example.
The CC.xlsx file is a spreadsheet I use to determine which jobs to invest time in.

To use, create a CC.txt file in the same folder and enter the commands to execute as listed below. Then press the appropriate hotkey to start the script running. On first run, place your cursor pointer at the upper left corner of the game window (where the pink meets the black); this tells the script where the game is located on your screen.

When I first created this, I had about 250 prestige and I used this to gain about 4.5 prestige every six minutes. I also use it to set up a run when I'm going to attempt to advance more to gain gems and time slots.

### Hotkeys
Hotkeys&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Action
------- | ------
<nobr><kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>1</kbd></nobr> | Runs the test function. You really don't need to use this.
<nobr><kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>5</kbd></nobr> | Sets the coordinate offsets. You need to do this if you have moved or resized the game window since you first ran the script.
<nobr><kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>8</kbd></nobr> | Runs the command sequence found in CC.txt only once and skips the Reset command. This can be useful for initial set up after a reset.
<nobr><kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>9</kbd></nobr> | Loops the command sequence found in CC.txt until stopped.
<nobr><kbd>CTRL</kbd>+<kbd>SHIFT</kbd>+<kbd>0</kbd></nobr> | Stops whatever is executing currently. Note that some commands will run to completion after this is pressed.

### Commands
Command&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | Action
------- | ------
<nobr>Stop</nobr>     | Stops the sequence and immediately terminates the loop. This is useful for debugging and setting up your command sequence.
<nobr>Wait n</nobr>   | Tells the script to do nothing for the specified number (*n*) of milliseconds.
<nobr>Girl n</nobr>   | Switches to the girl screen and selects the girl at position *n*. The numbers ascend from top to bottom (Cassie is 1, Mio is 2, etc.)
<nobr>Job n</nobr>    | Toggles the specified job number (*n*) on or off. Jobs are numbered from left to right and top to bottom (Fast Food is 1, Computers is 2, Restaurant is 3, etc.)
<nobr>Hobby n</nobr>  | Toggles the specified hobby number (*n*) on or off. Hobbies are numbered in the order they are acquired which is top to bottom and then left to right (Suave is 1, Funny is 2, Tenderness is 5, etc.)
<nobr>Date n m</nobr> | Switches to the girl screen and activates the specified date number (*n*) the amount of times specified by *m*. Date numbers are specified from top to bottom. (Date 1 2 will run the Moonlight Stroll date 2 times.) *m* can be omitted if only running once.
<nobr>Gift n m</nobr> | Switches to the girl screen and gives the specified gift number (*n*) the amount of times specified by *m*. Gift numbers are specified from left to right and then top to down and then by page (Shell is 1, Rose is 2, Hand Lotion is 3, etc.) *m* can be omitted if only giving one gift.
<nobr>Tap n</nobr>    | Switches to the girl screen and taps the girl the specified number of times (*n*) to accumulate hearts.
<nobr>Talk n</nobr>   | Switches to the girl screen and presses the talk button (Sorry, Flirt, etc.) the specified number of times (*n*) to accumulate hearts. Does not take the cooldown into consideration. You an think of the number specified as more like a time than a number of clicks.
<nobr>Upgrade</nobr>  | Switches to the girl screen and upgrades the girl's relationship level with you.
<nobr>Reset</nobr>    | Resets the game to gain prestige.

### Limitations
None of the commands take into account cooldown times. You must use `Wait` to specify them where necessary.

### ToDo
- Implement Steam version compatibility.
- Implement a pause hotkey that will resume execution from the point where it stopped.
