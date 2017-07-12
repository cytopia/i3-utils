# i3-utils

A few tools for a minimalistic [i3](https://github.com/i3/i3) setup.


## Integration

#### Install

This will add binaries to `/usr/local/bin/` as well as systemd files to `/usr/lib/systemd/`.

```bash
$ ./configure
$ sudo make install
```

#### Uninstall

This will remove binaries from `/usr/local/bin/` as well as systemd files from `/usr/lib/systemd/`.

```bash
$ sudo make uninstall
```


## Systemd

| Tool | Target | Description |
|------|--------|-------------|
| [70-close_lid.conf](systemd/logind.conf.d/70-close_lid.conf) | `/usr/lib/systemd/logind.conf.d/` | Systemd login configuration to handle notebook lid close. Will put the computer to sleep when the lid closes.<br/><br/><strong>Only going to sleep when:</strong><br/><ul><li>No power or docking station is connected</li><li>No external monitor is connected</li><li>No graphical desktop environment already handles lid close actions and prevents systemd via low-level inhibitor lock.</li></ul> |
| [suspend.service](systemd/system/suspend.service) | `/usr/lib/systemd/system/` | Suspend addition to lock the screen before going to sleep with the bundled tool [xlock](bin/xlock). |


## Tools

#### System tools

| Tool | Description |
|------|-------------|
| [system-hibernate](bin/system-hibernate) | Wrapper script to hibternate as user. |
| [system-reboot](bin/system-reboot)       | Wrapper script to reboot as user.     |
| [system-shutdown](bin/system-shutdown)   | Wrapper script to shutdown as user.   |
| [system-suspend](bin/system-suspend)     | Wrapper script to suspend as user.    |

#### Hardware tools

| Tool | Description |
|------|-------------|
| [xf86-audio](bin/xf86-audio)             | Adjust your screens backlight. Supports notifications. |
| [xf86-backlight](bin/xf86-backlight)     | Increase, decrease and mut currently enabled audio device. Supports notifications. |

#### X tools

| Tool | Description |
|------|-------------|
| [xcolorpick](bin/xcolorpick) | Zenity based RGB color picker for any pixel on your screen. |
| [xlock](bin/xlock)           | Wrapper for `i3lock` with blurred screenshot and optional custom overlay which will also suspend any notifications during lock and can be run in the background without locking the script itself, so that you can run another script afterwards (such as [system-suspend](bin/system-suspend)). |
| [xscreenshot](bin/xscreenshot) | Wrapper for `scrot`. |

#### Example usage for i3

```bash
###
### System
###

set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (p) poweroff
mode "$mode_system" {
	bindsym l exec --no-startup-id system-lock, mode "default"
	bindsym e exec --no-startup-id i3-msg exit, mode "default"
	bindsym s exec --no-startup-id "system-lock -b; system-suspend",   mode "default"
	bindsym h exec --no-startup-id "system-lock -b; system-hibernate", mode "default"
	bindsym r exec --no-startup-id system-reboot,    mode "default"
	bindsym p exec --no-startup-id system-shutdown,  mode "default"

	# Back to normal: Enter or Escape
	bindsym Return mode "default"
	bindsym Escape mode "default"
}


###
### Hardware
###

# Sreen Backlight brightness
bindsym XF86MonBrightnessUp   exec xf86-backlight -c up
bindsym XF86MonBrightnessDown exec xf86-backlight -c down

# Audio Volume
bindsym XF86AudioRaiseVolume  exec xf86-audio -D pulse -c up
bindsym XF86AudioLowerVolume  exec xf86-audio -D pulse -c down
bindsym XF86AudioMute         exec xf86-audio -D pulse -c toggle


###
### X Tools
###

# Screenshot (with multi monitors)
bindsym Print exec "xscreenshot -m multi"

# Screenshot (select rectangle)
bindsym $mod+Sys_Req exec "xscreenshot -m selection"

# Screenshot (active window)
bindsym $mod+Shift+Sys_Req exec "xscreenshot -m window"
```
