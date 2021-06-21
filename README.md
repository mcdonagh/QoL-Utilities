# QoL Utilities
WoW addon for minor quality of life changes.  
1. [Configuration](#config)
1. [Achievement Tracker Cleaner](#atc)
	- [Usage](#atc-usage)
1. [Announce Target](#at)
	- [Usage](#at-usage)
	- [Command Arguments](#at-arguments)
	- [Destinations](#at-destinations)
	- [SubDestinations](#at-subdestinations)
1. [Auto Confirm](#ac)
	- [Usage](#ac-usage)
1. [Middle Marker](#mm)
	- [Usage](#mm-usage)
1. [Quiet Mode](#qm)
	- [Usage](#qm-usage)
1. [Volume Cycler](#vc)
	- [Usage](#vc-usage)
	- [Command Arguments](#vc-arguments)

<h2 id='config'>Configuration</h2>

The following features are available for configuration on a **per account** basis.  
Configuration is available through slash commands or via the in-game interface options.  
See the feature's details for more information on the corresponding slash command.
> *Features not mentioned have no configuration associated with them*  

**[Auto Confirm's](#ac)** in-game configuration is a checkbox to turn the feature on or off.  

**[Quiet Mode's](#qm)** in-game configuration is a checkbox to turn the feature on or off.  

**[Volume Cycler's](#vc)** in-game configuration is comprised of two input fields.  
The first is a list of preset volume percentages that you will be able to cycle through.  
The second is the index of the preset that you currently wnat to use.

<h2 id='atc'>Achievement Tracker Cleaner</h2>

Exactly what it says on the tin: Cleans the in-game achievement tracker by untracking completed achievements.  

*Ever run into the issue of trying to track an achievement and get the message that you can only track 10 achievements at a time?
And you only see 6 achievements being tracked?
That means there's completed achievements that the game, for whatever reason, did not auto untrack.  
This removes those hidden, but still tracked completed achievements from the tracker.*

<h3 id='atc-usage'>Usage & Output</h3>

Untracking completed achievements occurs at every player login, on reload, and on every achievement earned.  
Manual execution is not needed, but is available.  
If you want to trigger the cleaning manually, run the command **\/qol atc**  

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

The command **\/qol at w** will announce your targets life and location through a whisper to yourself.  

Output Format:  
> *\<target name\>* \[*\<target life percentage\>*\] near \(*\<player coords\>*\) *\<map pin\>*  

Example Output:  
> Vyragosa \[Health 53%\] near \(51\.4, 70\.8\) \[Map Pin Location\]

<h3 id='at-arguments'>Command Arugments</h3>

All *Announce Target* slash commands begin with ***\/qol at***.  
Additional command arguments are separated by whitespace.  
*subDestination is ****only available after**** specifying a destination*.

Command Format: \/qol at \[***optional:*** *destination*\] \[***optional:*** *subDestination*\]
> *Running the comand with* ***no*** *optional arguments sends the target information to the first available chat channel.*
> *The command* ***\/qol at*** *is equivalent to **\/qol at c 1**.*

<h3 id='at-destinations'>Destinations and Meaning</h3>

Destination Argument | Destination Name | Example Command
:---:|---|---
c | channel | *\/qol at c 1*
g | guild    | *\/qol at g*
w | whisper  | *\/qol at w*
p | party    | *\/qol at p*
r | raid     | *\/qol at r*
s | say      | *\/qol at s*
i | instance | *\/qol at i*
y | yell     | *\/qol at y*

<h3 id='at-subdestinations'>SubDestinations</h3>

SubDestinations are only available when using *whisper* and *channel* Destinations.

#### Whispers
The subDestination for any whisper command is the name of the player you want to send the target information.
Simply using the command **\/qol at w** without a subDestination will send the target information to yourself in a whisper.
The command **\/qol at w** ***\<player name\>*** will send the target information to the specified player.

#### Channels
The subDestination for any channel is the number for that channel.  
Simply using the command **\/qol at c** without a subDestination or **\/qol at** without either a destination or subDestination sends the target information to the first available channel \(channel 1\).
  
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

Command Format: **\/qol ac**  
Executing this command will toggle the functionality on or off.  
The output will be printed to the chat window and will either be  
> Automatically confirming to equip Refundable & Tradeable items.

or  
> Manual confirmation required to equip Refundable & Tradeable items.

<h2 id='mm'>Middle Marker</h2>

Creates lines demarcating the vertical and horizontal middles of the game window.  
Four \(4\) lines are created along the top, left, right, and bottom of the screen.  
Each line begins at the edge of the screen pointing towards the center of the screen.
> Lines are **hidden** by default.

<h3 id='mm-usage'>Usage & Output</h3>

Command Format: **\/qol mm**  
Executing this command will toggle the visibility of the lines.  
No text is printed to the chat window.  

<h2 id='qm'>Quite Mode</h2>

Automatically declines party invites and duel requests.  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload.  
> Functionality is turned **off** by default.  
> State is saved **per account**, ***NOT*** per character.

<h3 id='qm-usage'>Usage & Output</h3>

Command Format: **\/qol qm**  
Executing this command will toggle the functionality on or off.  
The output prints to the chat window and will either be
> Automatically declining Party Invites & Duel Requests.

or  
> Manual confirmation required for Party Invites & Duel Requests.

When a party invite is declined this way the output reads
> Declined Party Invite from *\<player name\>*

When a duel request is declined this way the output reads
> Declined Duel Request from *\<player name\>*

<h2 id='vc'>Volume Cycler</h2>

Allows you to cycle the master volume of the game through a list of preset values.  
*The default values are 80%, 20%, and 5%.*  
Also allows you to quickly set the master volume of the game to any percentage from 0 through 100.  

<h3 id='vc-usage'>Usage & Output</h3>

Command Format: **\/qol vc**
Executing this command will set the in-game master volume to the next preset in the list.  
If the last preset is reached, *Volume Cycler* will begin again at the start of the list.  
The new volume setting is reported via the chat window.
> Master Volume set to 20%.

<h3 id='vc-arguments'>Command Arguemnts</h3>

If you want to change the in-game volume to a level not currently in the configurable preset list, you can execute the command **\/qol vc** with the optional argument.  
The slash command for *Volume Cycler* only looks for the first available optional argument. Any additional arguements are ignored.  

Command Format
> \/qol vc *\<custom volume percentage\>*

Example Command
> \/qol vc 46

Example Output
> Master Volume set to 46%.