# RedbeardsUtilities
WoW addon for minor quality of life changes
1. [Achievement Tracker Cleaner](#atc)
	- [Usage](#atc-usage)
1. [Announce Target](#at)
	- [Usage](#at-usage)
	- [Slash Commands](#at-arguments)
	- [Destinations](#at-destinations)
	- [SubDestinations](#at-subdestinations)
1. [Auto Confirm](#ac)
	- [Usage](#ac-usage)
1. [Middle Marker](#mm)
	- [Usage](#mm-usage)
1. [Quiet Mode](#qm)
	- [Usage](#qm-usage)

<h2 id='atc'>Achievement Tracker Cleaner</h2>

Exactly what it says on the tin: Cleans the in-game achievement tracker by untracking completed achievements.  

*Ever run into the issue of trying to track an achievement and get the message that you can only track 10 achievements at a time?
And you only see 6 achievements being tracked?
That means there's completed achievements that the game, for whatever reason, did not auto untrack.  
This removes those hidden, but still tracked completed achievements from the tracker.*

<h3 id='atc-usage'>Usage & Output</h3>

Untracking completed achievements occurs at every player login, on reload, and on every achievement earned.  
Manual execution is not needed, but is available.  
If you want to trigger the cleaning manually, run the command **\/ru atc**  

Each completed achievement that is untracked will be printed to the chat window on its own line with a link to the achievement.  
The last line will print the total number of achievements untracked.  

Output Format:  
> Stopped tracking *\<achievement link\>*  
> *\<num achievements removed\>* completed achievements untracked.

Example Output:
> Stopped tracking \[Field Photographer\]  
> Stopped tracking \[Northern Explorer\]  
> Stopped tracking \[Glory of the Hero\]  
> 3 completed achievements untracked.

<h2 id='at'>Announce Target</h2>

Sends your current target's life percentage and location to the designated chat.

<h3 id='at-usage'>Usage & Output</h3>

Example Usage: **\/ru at w**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will announce the targets life and location through a whisper to yourself.  

Output Format:  
> \<target name\> \[\<target life percentage\>\] near \(\<player coords\>\) \<map pin\>  

Example Output:  
> Vyragosa \[Health 53%\] near \(51\.4, 70\.8\) \[Map Pin Location\]

<h3 id='at-arguments'>Command Arugments</h3>

All *Announce Target* slash commands begin with ***\/ru at***.  
Additional command arguments are separated by whitespace.  
  *subDestination is ****only available after**** specifying a destination*.

Command Format: \/ru at \[***optional:*** *destination*\] \[***optional:*** *subDestination*\]
> *Running the comand with* ***no*** *optional arguments sends the target information to the first available chat channel.*
> *The command* ***\/ru at*** *is equivalent to **\/ru at c 1**.*

<h3 id='at-destinations'>Destinations and Meaning</h3>

Destination Argument | Destination Name | Example Command
---|---|---
c | channel | *\/ru at c 1*
g | guild    | *\/ru at g*
w | whisper  | *\/ru at w*
p | party    | *\/ru at p*
r | raid     | *\/ru at r*
s | say      | *\/ru at s*
i | instance | *\/ru at i*
y | yell     | *\/ru at y*

<h3 id='at-subdestinations'>SubDestinations</h3>

SubDestinations are only available when using *whisper* and *channel* Destinations.

#### Whispers
The subDestination for any whisper command is the name of the player you want to send the target information.
Simply using the command **\/ru at w** without a subDestination will send the target information to yourself in a whisper.
The command **\/ru at w** ***\<player name\>*** will send the target information to the specified player.

#### Channels
The subDestination for any channel is the number for that channel.  
Simply using the command **\/ru at c** without a subDestination or **\/ru at** without either a destination or subDestination sends the target information to the first available channel \(channel 1\).
  
Channel Number | Default Channel
:---: | ---
1 | General
2 | Trade
3 | Local Defense
4 | LFG

<h2 id='ac'>Auto Confirm</h2>

Automatically clicks the confirmation button on the popup that shows when attempting to equip items that are still Refundable or Tradeable.  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload.
> Functionality is turned **off** by default.  
> State is saved **per account**, ***NOT*** per character.

<h3 id='ac-usage'>Usage & Output</h3>

Command Format: **\/ru ac**  
Executing this command will toggle the functionality on or off.  
The output will be printed to the chat window and will either be  
> Refundable & Tradeable items now auto confirming to equip

or  
> Refundable & Tradeable items now requiring manual confirmation to equip

<h2 id='mm'>Middle Marker</h2>

Creates lines demarcating the vertical and horizontal middles of the game window.  
Four \(4\) lines are created along the top, left, right, and bottom of the screen.  
Each line begins at the edge of the screen pointing towards the center of the screen.
> Lines are **hidden** by default.

<h3 id='mm-usage'>Usage & Output</h3>

Command Format: **\/ru mm**  
Executing this command will toggle the visibility of the lines.  
No text is printed to the chat window.  

<h2 id='qm'>Quite Mode</h2>

Automatically declines party invites and duel requests.  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload.  
> Functionality is turned **off** by default.  
> State is saved **per account**, ***NOT*** per character.

<h3 id='qm-usage'>Usage & Output</h3>

Command Format: **\/ru qm**  
Executing this command will toggle the functionality on or off.  
The output prints to the chat window and will either be
> now accepting invites & duels

or  
> now declining invites & duels

When a party invite is declined this way the output reads
> declined invite from *\<player name\>*

When a duel request is declined this way the output reads
> declined duel from *\<player name\>*