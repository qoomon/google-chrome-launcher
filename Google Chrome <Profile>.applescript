set appName to name of (info for (path to me))

set profile to do shell script "echo \"" & appName & "\" | sed \"s|Google Chrome \\(.*\\)\\.app|\\1|\""

do shell script "
PROFILE='" & profile & "'
if [ \"$PROFILE\" = 'Default' ]; then
	PROFILE_DIR=\"$HOME/Library/Application Support/Google/Chrome\"
else if [ \"$PROFILE\" = 'Fresh' ]; then
	PROFILE_DIR=\"$(mktemp -d -t '.com.google.Chrome')\"
else 
	PROFILE_DIR=\"$HOME/Library/Application Support/Google/Chrome $PROFILE\"
fi

open -na 'Google Chrome' --args \"--user-data-dir=$PROFILE_DIR\"
"
