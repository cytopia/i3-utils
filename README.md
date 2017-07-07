# i3-utils


## Installation

```
$ sudo make install
```

## Removal

```
$ sudo make uninstall
```

## Tools

### System tools

#### [system-hibernate](bin/system-hibernate)

Wrapper script to hibternate as user.

#### [system-reboot](bin/system-reboot)

Wrapper script to reboot as user.

#### [system-shutdown](bin/system-shutdown)

Wrapper script to shutdown as user.

#### [system-suspend](bin/system-suspend)

Wrapper script to suspend as user.


### X tools

#### [xcolorpick](bin/xcolorpick)

Zenity based RGB color picker for any pixel on your screen.

#### [xlock](bin/xlock)

Wrapper for `i3lock` with blurred screenshot and optional custom overlay which will also suspend any notifications during lock and can be run in the background without locking the script itself, so that you can run another script afterwards (such as [system-suspend](bin/system-suspend)).

```
set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (p) poweroff
mode "$mode_system" {
	bindsym l exec --no-startup-id system-lock, mode "default"
	bindsym e exec --no-startup-id i3-msg exit, mode "default"
	bindsym s exec --no-startup-id "system-lock -b; system-suspend",   mode "default"
	bindsym h exec --no-startup-id "system-lock -b; system-hibernate", mode "default"
	bindsym r exec --no-startup-id system-reboot,    mode "default"
	bindsym p exec --no-startup-id system-shutdown,  mode "default"

	# back to normal: Enter or Escape
	bindsym Return mode "default"
	bindsym Escape mode "default"
}
```

#### [xscreenshot](bin/xscreenshot)

Wrapper for `scrot`.
