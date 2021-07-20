# QoL Utilities Change Log
1. [Future Plans](#fp)
1. [Latest Release (2021-07-06)](#c003)
1. [Previous Release (2021-07-01)](#c002)
1. [Older](#c001)

<h2 id='fp'>Future Plans</h2>

> *No dates available for any planned features. I work on this project in my spare time and will get to them when I get to them.*

- Add ability to turn off features completely via in-game config screen.
- Add the option to screen requests for *Quiet Mode* to allow the option for different level of requests to come through.
	- Such as allowing requests from guildies only, or requests from guildies and people on your friends list.
- Add color configuration to *Middle Marker* instead of having it hardcoded to red.

#### Leave a Suggestion
If there's anything you'd like to see added or changed, please leave a [feature request on GitHub](https://github.com/mcdonagh/QoL-Utilities/issues)!  
> *Not all suggestions will be implemented, but they all will be taken into consideration.*

<h2 id='c003'>Version 4.0.0 | 2021-07-06</h2>

- Added ability to summon battle pets
	- Will summon either any battle pet or any favorited battle pet
- Added ability to summon mounts based on current ability and location
	- Will summon any qualifying mount, or only *favorited* qualifying mounts
	- Only summons ground mounts where you **cannot** fly
	- Only summons flying mounts where you **can** fly
	- Only summons underwater mounts when submerged
	- Special mounts like the heirloom Chauffeur mounts will be summoned when you are under leveled or have not yet trained the riding skill
	- Special mounts Qiraji Battle Tanks will be summoned when you are in the Temple of Ahn'Qiraj
- Added configuration options for summoning only favorite or summoning any pets and mounts
- Backend changes to the code base for easier maintenance and cleaner division of functionality

<h2 id='c002'>Version 3.1.0 | 2021-07-01</h2>

- Configuration update:
	- Added functionality for *per character* settings
	- Added functionality for configuring the ability to toggle on/off specific *Quiet Mode* and *Auto Confirm* features
	- Added functionality for configuring on/off the status report for *Quiet Mode* and *Auto Confirm* at player logon/reload
- Added *Auto Confirm* functionality for "Bind on Equip" items
- Minor fix to *Quiet Mode*'s decline duel
	- Added the api call to *CancelDuel()*. Thought it worked the same as party invites where just hiding the window also declines. Nope, need the api call.

<h2 id='c001'>Version 3.0.0 | 2021-06-24</h2>

Initial public release.
