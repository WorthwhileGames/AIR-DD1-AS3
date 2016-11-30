AIR-DD1-AS3
===========

Dungeons & Dragons #1 © 1977-2014 Richard Garriott

Ported to AIR/AS3 by Andrew Rapo (andrew@worthwhilegames.org)
@andrewrapo
Raptoron

This port of DND #1 is for fun, being ineligible for the for the contest because it is written in AS3.

This project is ready to run in Adobe Flashbuilder and if with a valid Apple certificate and a  provisioning
profile it can be installed on iPad.  There are two parts:

AIR-DD1-AS3 - the code
AIR-DD1-FLA - the assets including bg art, sounds, and an embedded font

The AS3 port employs a main game loop that simulates BASIC’s blocking input.  There are classes for
managing Input, Output, the Map, Monsters, Items, Inventory, Spells, and a virtual keyboard (for iPad).
