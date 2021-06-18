# RedbeardsUtilities
WoW addon for minor quality of life changes
1. [Announce Target](#at)
	- [Usage](#at-usage)
	- [Slash Commands](#at-arguments)
	- [Destinations](#at-destinations)
	- [SubDestinations](#at-subdestinations)
2. [Auto Confirm](#ac)
	- [Usage](#ac-usage)
3. [Middle Marker](#mm)
	- [Usage](#mm-usage)
4. [Quiet Mode](#qm)
	- [Usage](#qm-usage)

<h2 id='at'>Announce Target</h2>

Sends your current target's life percentage and location to the designated chat.

<h3 id='at-usage'>Usage & Output</h3>

Example Usage: **\/ru at w**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will announce the targets life and location through a whisper to yourself.  
Output Format:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<target name\> \[\<target life percentage\>\] near \(\<player coords\>\) \<map pin\>  
Example Output:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vyragosa \[53%\] near \(51\.4, 70\.8\) \[Map Pin Location\]

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
  
Number | Default Channel
--- | ---
1 | General
2 | Trade
3 | Local Defense
4 | LFG

<h2 id='ac'>Auto Confirm</h2>

Automatically clicks the confirmation button on the popup that shows when attempting to equip items that are still Refundable or Tradeable.  
Functionality can be toggled on or off.  
Current state of functionality is reported at player login and on reload.
> Functionality is turned **off** by default.

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