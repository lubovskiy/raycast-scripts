#!/usr/bin/osascript

# Required:
# @raycast.schemaVersion 1
# @raycast.title Toggle Connection
# @raycast.mode silent
#
# Optional:
# @raycast.packageName Viscosity
# @raycast.icon images/viscosity.png
# @raycast.argument1 { "type": "text", "placeholder": "Profile", "optional": true}
# @raycast.description Toggle Viscosity VPN connection
# @raycast.author Andrey Lubovskiy
# @raycast.authorURL https://github.com/lubovskiy

on run argv
	set n to item 1 of argv
	if not n = "" then
		tell application "Viscosity"
			connect n
			if (the state of the first connection is not "Connected") and (the state of the first connection is not "Connecting") then
				log "Profile " & n & " not found"
				--else
				--	log "Connected to " & n
			end if
		end tell
	else
		tell application "Viscosity"
			if the state of the first connection is not "Connected" then
				set n to the name of the first connection
				connect n
				if (the state of the first connection is not "Connected") and (the state of the first connection is not "Connecting") then
					log "Something went wrong"
					--else
					--	log "Connected to " & n
				end if
			else
				disconnectall
				--log "Disconnected"
			end if
		end tell
	end if
end run