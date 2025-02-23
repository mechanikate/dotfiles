#!/bin/bash
systemctl --user import-environment DISPLAY XAUTHORITY
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment DISPLAY XAUTHORITY
fi
if (("$(date "+%H")">="19"))
then
	feh --bg-scale ~/wallpaper/nightmode.png
else 
	feh --bg-scale ~/wallpaper/sylveon.jpg
fi
