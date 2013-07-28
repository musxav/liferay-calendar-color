liferay-calendar-color
======================

Extended Liferay calendar portlet.

This featuring add a extra configuration in prefences of calendar portlet to 
modify or add types events and color presentation.

THANKS to the Gran Teatre Del Liceu, this project is a part of developing the Intranet 
for administrative offices.

The main featuring to adding a calendar is color events, the initial system in calendar is a 
fixed configuration in portal properties for number and name events, but you may needed a 
more than one calendar, is logic need different types and color.

Features

Modify event types or add new types for global o particular preferences in calendar. 
Defining color text and background for type. 
Adding a hidden hours in day presentation.

Default Configuration

Key calendar.event.types.color in portal.properties define the default types and color, the 
format for this parameter is "name :: color ink :: color background" and the colors in rgb html 
format, the separator is "::". 
Example: calendar.event.types.color=Call::#FFFFFF::#000000::Aniversary::#000000::#FFFFFF 
Default of this parameter is "*" this value forces a create the key with the default types 
in Liferay (key calendar.event.types) and color text #000000 and background #FFFFFF.

Preferences Configuration

Two new pages in configuration, "Events types" and "Additional day". 
In "Events types" you may add or modify type event with color, the field of colors in the 
format parameter is open to modify directly, the normal value set of color is with the visuals 
colors controls. 
For "Additional day" may set the initial and end hour hide in day page and the 
default (hidden or display) for this control.



