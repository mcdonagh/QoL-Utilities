# QoL Utilities Change Log
1. [Future Plans](#fp)
1. [Latest Release (2022-11-02)](#c005)
1. [Previous Release (2021-07-26)](#c004)
1. [Older](#c003)

<h2 id='fp'>Future Plans</h2>

> *No dates available for any planned features. I work on this project in my spare time and will get to them when I get to them.*

- Add ability to ignore specific mounts when summoning random mounts
	- Possibly add same ignore ability for summoning random pets; need to research if it's at all possible for pets
- Add *Auto Quest* feature to automatically accept/complete quests
	- Lots of addons already do this, but I want one that is my own
		- I currently use a modified version of **[Get to the Point](https://www.curseforge.com/wow/addons/get-to-the-point)** for my personal use
	- This feature will be disabled by default; I don't want it interfering with peoples' existing auto questing addons
- Add the option to screen requests for *Quiet Mode* to allow the option for different level of requests to come through
	- Such as allowing requests from guildies only, or requests from guildies and people on your friends list

#### Leave a Suggestion
If there's anything you'd like to see added or changed, please leave a [feature request on GitHub](https://github.com/mcdonagh/QoL-Utilities/issues)!  
> *Not all suggestions will be implemented, but they all will be taken into consideration.*

<h2 id='c005'>Version 4.1.1 | 2022-11-02</h2>

- Updating API calls for Dragonflight

<h2 id='c004'>Version 4.1.0 | 2021-07-26</h2>

- Reworked appearance of in-game configuration screen
	- Toon specific checkbox now at the top of the configuration screen
	- Account specific and Toon specific settings now share configuration items (checkboxes, editboxes, etc.)
- Added ability to enabled/disable each feature to prevent potential conflicts with other addons and avoid unwanted behavior
- Added color configuration to *Middle Marker*
- Backend changes to account level stored variables
- Minor fix to *Quiet Mode* and *Auto Confirm*'s \"toggle all\" functionality
- Minor fix to *Quiet Mode*'s Party Invite decline functionality
	- Added API call to *DeclineGroup()*. Hiding the popup only declines the party invite in specific circumstances
- Minor fixes to *Summon*'s mount summoning
	- Added a \"shuffle\" to the generated valid mount list to increase the variety of summoned mounts
	- Added \"in combat\" and \"empty list\" checks to prevent some system error messages

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
	- Added API call to *CancelDuel()*. Thought it worked the same as party invites where just hiding the window also declines. Nope, need the API call

<h2 id='c001'>Version 3.0.0 | 2021-06-24</h2>

- Initial public release