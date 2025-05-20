# Ctrl-a	Go to the beginning of the line you are currently typing on
# Ctrl-e	Go to the end of the line you are currently typing on
# Ctrl-y	Paste previously cut text
# Ctrl-t	Swap the last two characters before the cursor
# Esc-t 	Swap the last two words before the cursor
# Alt-d 	delete to end of word starting at cursor (whole word if cursor is at the beginning of word)
# Alt-c 	capitalize to end of word starting at cursor (whole word if cursor is at the beginning of word)
# Alt-u 	make uppercase from cursor to end of word
# Alt-l 	make lowercase from cursor to end of word
# Alt-t 	swap current word with previous
# Ctrl-f	move forward one character
# Ctrl-b	move backward one character
# Ctrl-d	delete character under the cursor
# Ctrl-h	delete character before the cursor
# Ctrl-g	escape from history searching mode
# Ctrl-p	previous command in history (i.e. walk back through the command history)
# Ctrl-n	next command in history (i.e. walk forward through the command history)
# Alt-. 	use the last word of the previous command
# Ctrl-l	Clears the Screen, similar to the clear command
# Ctrl-s	stops the output to the screen (for long running verbose command)
# Ctrl-q	allow output to the screen (if previously stopped using command above)
# Ctrl-x	start emacs style command, e.g.: C-x C-x	alternate the cursor with its old position
sudo mount -o remount,size=55G,noatime /tmp
cat /proc/self/mounts
findmnt --target /tmp
#useradd -m -d /tmp/downloads/testu -G audio,http,wheel testu
#passwd testu
#userdel -rf testu
kquitapp5 plasmashell && kstart5 plasmashell
#pkill -15 appname
#killall -9 appname
#find ./ -type f \( -name "*.sh" -o -name "*.txt" -o -name "*.c" \)
#grep -rni -e "a" -e "b" ./
#rename -nv "8." "7.2." 8.*
ls f[1-30a]* # match everything that starts with f1, f2, f3, f0, fa (NOT f4...f30)
ls f[!1-30a]* # match everything that doesn't start with f1, f2, f3, f0, fa
ls f{5,9-12,14,abc}* # match everything that starts with f5, f9-12 (NOT f9...f12), f14, fabc
< /dev/urandom tr -dc "_A-Z-a-z-0-9" | head -c32
< /dev/urandom tr -dc "0-1" | head -c1
ffmpeg -f video4linux2 -s 1280x720 -i /dev/video0 -ss 0:0:2 -frames 1 /tmp/downloads/webcam_1.jpg
journalctl -r -n 1000 -o short-iso-precise --no-hostname
git log --graph --pretty=format:"%C(yellow)%h %C(cyan)%ai%Creset %s %C(red)%d%Creset" -n 20
