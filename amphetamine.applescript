#!/usr/bin/osascript

# Required:
# @raycast.schemaVersion 1
# @raycast.title Toggle Session
# @raycast.mode silent
#
# Optional:
# @raycast.packageName Amphetamine
# @raycast.icon images/amphetamine.png
# @raycast.argument1 { "type": "text", "placeholder": "Duration", "optional": true}
# @raycast.description Toggle Amphetamine Session
# @raycast.author Andrey Lubovskiy
# @raycast.authorURL https://github.com/lubovskiy

on run argv
	set durationRaw to item 1 of argv
	if not durationRaw = "" then
		set isValid to "0" = (do shell script "RE_DUR=\"^[[:space:]]*(([0-9]+h){0,1})[[:space:]]*(([0-9]+m){0,1})[[:space:]]*$\"; [[ " & quoted form of durationRaw & " =~ $RE_DUR ]]; echo $?")
		if not isValid then
			log "Can't parse duration"
			return
		else
			set h to (do shell script "echo " & durationRaw & " | sed -ne 's/^\\(.*\\)h.*$/\\1/p' | sed -E 's/.*[^0-9]+([0-9]+)/\\1/g' ") as number
			set m to (do shell script "echo " & durationRaw & " | sed -ne 's/^\\(.*\\)m.*$/\\1/p' | sed -E 's/.*[^0-9]+([0-9]+)/\\1/g' ") as number
			set d to h * 60 + m
			tell application "Amphetamine"
				start new session with options {duration:d, interval:minutes, displaySleepAllowed:false}
			end tell
			set msg to "Started for"
			if h is not 0 then
				set msg to msg & " " & h & "h"
			end if
			if m is not 0 then
				set msg to msg & " " & m & "m"
			end if
			log msg
		end if
	else
		tell application "Amphetamine"
			set isSessionActive to session is active
			if not isSessionActive then
				start new session
				log "Started"
			else
				end session
				log "Stopped"
			end if
		end tell
	end if
end run
