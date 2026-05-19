# Windows Voice Input Push-to-Talk script

Short AutoHotkey v2 script to make `F9` act as a push-to-talk (PTT) button for Windows Voice Input.

Hold `F9` to activate your system's voice input (push-to-talk), release `F9` to stop. Useful when using Windows Voice Typing or Voice Access and you need/prefer a physical PTT key.

**Requirements**
- Windows 10/11
- AutoHotkey v2 (https://www.autohotkey.com/)

**Installation**
1. Install AutoHotkey v2 from the [official site](https://www.autohotkey.com/).
2. Place `msVoiceInputPushToTalk.ahk` (this repo) somewhere convenient.
3. Double-click the `.ahk` file to run it. To run automatically at login, put a shortcut into your Startup folder (`shell:startup`).

**Usage**
- Hold `F9` to send the configured shortcut to Windows voice input; release `F9` to send it again.
- By default the script sends `Alt+Shift+B` (AutoHotkey: `Send "!+b"`). If your voice-input shortcut differs (for example, Windows Voice Typing default is `Win+H`), edit the `Send` line in `msVoiceInputPushToTalk.ahk`.

- Note: The Windows Voice Input overlay (for example, Voice Typing or Voice Access) must be open/running for the push-to-talk shortcut to be received. The script simply sends the configured shortcut; Windows will only act on it when its voice input UI is active.

Modifier shorthand in AutoHotkey:
- `!` = Alt
- `+` = Shift
- `^` = Ctrl
- `#` = Win (Windows key)

Example: to use `Win+H` instead of `Alt+Shift+B`, change the line:

```
Send "!+b"
```

to:

```
Send "#h"
```

**How it works**
- The script uses a boolean `pttKeyIsDown` to avoid duplicate sends. On `F9` down it sets the flag and sends the shortcut; on `F9` up it clears the flag and sends the shortcut again, effectively toggling voice listening while the key is held.

**Contributing**
- Contributions welcome! Feel free to open issues or pull requests with improvements or bug fixes.
