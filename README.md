# RedbeardsUtilities
WoW addon for minor quality of life changes
1. [Announce Target](#at)
	- [Usage](#at-usage)
	- [Slash Commands](#at-slash)
	- [Destinations](#at-destinations)
	- [SubDestinations](#at-subdestinations)
2. [Auto Confirm](#ac)
	- [Usage](#ac-usage)
	- [Slash Command](#ac-slash)
3. [Middle Marker](#mm)
	- [Usage](#mm-usage)
	- [Slash Command](#mm-slash)

## Announce Target {#at}
Sends your current target's life percentage and location to the designated chat.

### Usage & Output {#at-usage}
Example Usage: **\/ru at w**  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Will announce the targets life and location through a whisper to yourself.  
Output Format:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\<target name\> \[\<target life percentage\>\] near \(\<player coords\>\) \<map pin\>  
Example Output:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vyragosa \[53%\] near \(51\.4, 70\.8\) \[Map Pin Location\]

### Slash Commands {#at-slash}
All *Announce Target* slash commands begin with ***\/ru at***.  
Additional command arguments are separated by whitespace.  
  *subDestination is ****only available after**** specifying a destination*.

Command Format: \/ru at \[***optional:*** *destination*\] \[***optional:*** *subDestination*\]
> *Running the comand with* ***no*** *optional arguments sends the target information to the first available chat channel.*
> *The command* ***\/ru at*** *is equivalent to **\/ru at c 1**.*

### Destinations and Meaning {#at-destinations}
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

### SubDestinations {#at-subdestinations}
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

## Auto Confirm {#ac}
Automatically clicks the confirmation button on the popup that shows when attempting to equip items that are still Refundable or Tradeable.  
Functionality can be toggled on or off.  
> Functionality is turned **off** by default.

### Usage & Output {#ac-usage}
### Slash Command {#ac-slash}
Command Format: **\/ru ac**

## Middle Marker {#mm}
Creates lines 

### Slash Command {#mm-slash}