# QoL Utilities
A *World of Warcraft* addon that provides various minor quality of life changes.  
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
	- [Command Arguments](#ac-arguments)
1. [Middle Marker](#mm)
	- [Usage](#mm-usage)
1. [Quiet Mode](#qm)
	- [Usage](#qm-usage)
	- [Command Arguments](#qm-arguments)
1. [Summoning Mounts & Battle Pets](#smn)
	- [Usage](#smn-usage)
	- [Command Arguments](#smn-arguments)
1. [Volume Cycler](#vc)
	- [Usage](#vc-usage)
	- [Command Arguments](#vc-arguments)

<h2 id='config'>Configuration</h2>

All configuration is available on a **per account** or **per character** basis.  
Most configuration options present in the in-game configuration window are also available through slash commands.  
> Use the command **\/qol** to quickly open the in-game configuration window.

Turning *per character* settings on or off is only possible through the in-game configuration window.  
When using *per character* settings, Slash Commands only affect the current character's settings.  
See the feature's details for more information on the corresponding slash commands.

### Enabling Individual Features
Each feature is able to be enabled/disabled individually via the in-game configuration window.  
All features are **disabled** by default to avoid potential conflicts with other addons.  

Feature enabling ***is*** affected by the **per character** setting.  
> *Say you wanted Volume Cycler enabled on only one character and not others.*
> *On the character you wanted it enabled, you would make sure the setting \"Use character specific settings.\" is checked.*
> *Then you would scroll down to Volume Cycler and make sure the setting \"Feature enabled.\" is checked.*

### Feature Specific Configuration
> ***Features not mentioned in this section have no additional configuration associated with them***	  

**[Auto Confirm's](#ac)** in-game configuration consists of four checkboxes.
The first is to toggle on/off the report that is shown at player logon and on reload.
The other three are to toggle on/off the ability to automatically confirm equipping different items.
One for Refundable items, one for Tradeable items, and one for "Bind on Equip" items.

**[Quiet Mode's](#qm)** in-game configuration consists of three checkboxes.
The first is to toggle on/off the report that is shown at player logon and on reload.
The other two are to toggle on/off the ability to automatically decline certain requests.
One for decling Party Invites, and one for declining Duel Requests.

**[Summoning Mounts & Battle Pets'](#smn)** in-game configuration consists of three checkboxes.
The first is to toggle on/off the report that is shown at player logon and on reload.
The other two are to toggle on/off the restriction of summoning to favorited summons.
One for mounts, and one for battle pets.

**[Volume Cycler's](#vc)** in-game configuration consists of a single input field.
A list of preset volume percentages that you will be able to cycle through, in the order in which they are entered.  

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

Allows you to quickly send your current target's life percentage and location to the designated chat.  
Does not trigger automatically; use the command **\/qol at** to trigger the message.
*See below on how to use the optional arguments for the different chat destinations.*  

Because of WoW's api limitations, the coordinates used are the player's current coordinates when the message is triggered.

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

Command Format: \/qol at \[***optional:*** *destination* \[***optional:*** *subDestination*\]\]
> *Running the comand with* ***no*** *optional arguments sends the target information to the first available chat channel.*
> *The command* ***\/qol at*** *is equivalent to **\/qol at c 1**.*

<h3 id='at-destinations'>Destinations and Meaning</h3>

Argument: *destination* | Argument Name | Example Command
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

Automatically clicks the confirmation button on the popup that shows when attempting to equip items that are still Refundable, Tradeable, or items that are "Bind on Equip".  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload. 
> Functionality is turned **off** by default.  

<h3 id='ac-usage'>Usage & Output</h3>

Command Format: **\/qol ac**  
Executing this command *without* the optional subargument will toggle the functionality on or off for *all* items.  
The output will be printed to the chat window and will either be  
> Automatically confirming to equip Refundable, Tradeable, and "Bind on Equip" items.

or  
> Manual confirmation required to equip Refundable, Tradeable, and "Bind on Equip" items.

<h3 id='ac-arguments'>Command Arugments</h3>

All *Auto Confirm* slash commands begin with ***\/qol ac***.  
Additional command arguments are separated by whitespace.  

Command Format: \/qol ac \[***optional:*** *feature*\]
> *Running the comand with* ***no*** *optional arguments toggles the functionality for all items.*

### Optional Arguments

Argument: *feature* | Description | Example Command
:---:|---|---
r | Toggle functionality on/off for Refundable items | *\/qol ac r*
t | Toggle functionality on/off for Tradeable items | *\/qol ac t*
b | Toggle functionality on/off for *Bind on Equip* items | *\/qol ac b*
on | Turn functionality *on* for all items | *\/qol ac on*
off | Turn functionality *off* for all items | *\/qol ac off*

<h2 id='mm'>Middle Marker</h2>

Creates lines demarcating the vertical and horizontal middles of the game window.  
Four \(4\) lines are created along the top, left, right, and bottom of the screen.  
Each line begins at the edge of the screen pointing towards the center of the screen.
> Lines are **hidden** by default.

<h3 id='mm-usage'>Usage & Output</h3>

Command Format: **\/qol mm**  
Executing this command will toggle the visibility of the lines.  
No text is printed to the chat window.  

<h2 id='qm'>Quiet Mode</h2>

Automatically declines party invites and duel requests.  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload.  
> Functionality is turned **off** by default.  

<h3 id='qm-usage'>Usage & Output</h3>

Command Format: **\/qol qm**  
Executing this command *without* the optional subargument will toggle the functionality on or off for *all* requests.  
The output will be printed to the chat window and will either be  
> Automatically declining Party Invites and Duel Requests.

or  
> Manual confirmation required for Party Invites and Duel Requests.

When a party invite is declined this way the output reads
> Declined Party Invite from *\<player name\>*

When a duel request is declined this way the output reads
> Declined Duel Request from *\<player name\>*

<h3 id='ac-arguments'>Command Arugments</h3>

All *Quiet Mode* slash commands begin with ***\/qol qm***.  
Additional command arguments are separated by whitespace.  

Command Format: \/qol qm \[***optional:*** *feature*\]
> *Running the comand with* ***no*** *optional arguments toggles the functionality for all items.*

### Optional Arguments

Argument: *feature* | Description | Example Command
:---:|---|---
p | Toggle functionality on/off for Party Invites | *\/qol qm p*
d | Toggle functionality on/off for Duel Requests | *\/qol qm d*
on | Turn functionality *on* for all requests | *\/qol qm on*
off | Turn functionality *off* for all requests | *\/qol qm off*

<h2 id='smn'>Summoning Mounts & Battle Pets</h2>

Pretty much exactly what the title says: allows you to summon Mounts and Battle Pets.  
Battle Pet summoning is based soley on whether you are choosing to summon favorited pets.  
Mount summoning is based on current location and riding skill, and whether you are choosing to summon a favorited mount:  
- Only ground mounts will be summoned in places you **cannot** fly, even if you have leanred the flying skill.  
	- Special mounts like the Heirloom Chauffeur and Qiriaji Battle Tanks will be summoned as well when their respective conditions are met.  
- Only flying mounts will be summoned in places you **can** fly, only when you have learned the flying skill.  
- Water mounts will be summoned when in/under water.  
	- WoW doesn't have a native way to detect when you are at the surface of the water, and what I came up with works, but is a *little* finicky, so if you want a non-water mount when you come up but are still in water, all you have to do is jump once or twice.  

> *If the favorites option is turned on, you must have a qualifying mount set as favorite or no mount will be summoned.*  

Current state of summoning is reported at player logon and on reload.  
> The logon/reload report is turned **off** by default.  
> Battle Pet summoning being restricted to favorites is turned **off** by default.  
> Mount summoning being restricted to favorites is turned **off** by default.  

<h3 id='smn-usage'>Usage & Output</h3>

Command Format: **\/qol smn**  
Executing this command will summon a random battle pet, and cause you to dismount or mount.  
Executing this command with certain optional arguments will only summon a mount, or a battle pet, or toggle the *favorite* restriction.  
Commands that toggle the *favorite* setting have output printed to the chat window.  

Example Command:  
> \/qol smn m on  

Example Output:  
> Only appropriate and favorited mounts will be summoned.  

Additionally, a message is printed to the chat window when trying to summon a favorite mount and no qualifying favorite mount is available.  
For example, if you tried to summon a favorite flying mount with no flying mount favorited you would see the message:  
> No favorited mount available for flying.

<h3 id='smn-arguments'>Command Arguments</h3>

All *Summoning* slash commands begin with ***\/qol smn***.  
Additional command arguments are separated by whitespace.

Command Format: \/qol smn \[***optional:*** *summonType* \[***optional:*** *state*\]\]
> *Optional argument* ***state*** *is only used when preceded by the optional arguement* ***summonType***.  
> **Running the command with NO optional arguments summons both a Battle Pet and a Mount.**  
> Running the command with the optional argument *summonType*, but without the optional argument *state*, summons only the specified type.

### Optional Arguments

Argument: *summonType* | Argument: *state* | Description | Example Command
:---: | :---: | --- | ---
p | f | Toggles the *favorites* setting on/off for Battle Pets | *\/qol smn p f*
p | on | Turns the *favorites* setting for summoning Battle Pets *on* | *\/qol smn p on*
p | off | Turns the *favorites* setting for summoning Battle Pets *off* | *\/qol smn p off*
p | - | Summons a random Battle Pet. If *favorites* is turned on, only a favorite Battle Pet will be summoned | *\/qol smn p*
m | f | Toggles the *favorites* setting on/off for Mounts | *\/qol smn m f*
m | on | Turns the *favorites* setting for summoning Mounts *on* | *\/qol smn m on*
m | off | Turns the *favorites* setting for summoning Mounts *off* | *\/qol smn m off*
m | - | Summons a random Mount. If *favorites* is turned on, only a favorite Mount will be summoned | *\/qol smn m*
\- | - | Summons both a random Battle Pet and Mount, respective of each types' *favorites* status. | *\/qol smn*

<h2 id='vc'>Volume Cycler</h2>

Allows you to cycle the master volume of the game through a list of preset values.  
> *The default values are 80%, 20%, and 5%.*  
> No limit is set on the number of preset values you can enter, but it is suggested you keep the list small to allow for quicker cycling

Also allows you to quickly set the master volume of the game to any percentage from 0 through 100.  

<h3 id='vc-usage'>Usage & Output</h3>

Command Format: **\/qol vc**
Executing this command will set the in-game master volume to the next preset in the list.  
If the last preset is reached, *Volume Cycler* will begin again at the start of the list.  
The new volume setting is reported via the chat window.
> Master Volume set to 20%.

<h3 id='vc-arguments'>Command Arguemnts</h3>

If you want to change the in-game volume to a level not currently in the configurable preset list, you can execute the command **\/qol vc** with the optional argument.  
The slash command for *Volume Cycler* only looks for the first available optional argument. Any additional arguments are ignored.  

Command Format
> \/qol vc *\<custom volume percentage\>*

Example Command
> \/qol vc 46

Example Output
> Master Volume set to 46%.