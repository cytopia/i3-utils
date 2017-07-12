# Configuration
SHELL = /bin/sh
MKDIR_P = mkdir -p
SYSTEMCTL = systemctl

# Check if './configure' has been run
CONFIGURED = 0
ifneq ("$(wildcard build/70-close_lid.conf)","")
  ifneq ("$(wildcard build/suspend.service)","")
    CONFIGURED = 1
  endif
endif

all:
	@echo "Type 'make install' or 'make uninstall'"
	@echo
	@echo "Both, 'make install' and 'make uninstal' require root/sudo privileges"
	@echo
	@echo "'make install' will copy all files from bin/ to /usr/local/bin/"
	@echo "'make uninstall' will remove those files from /usr/local/bin/"

install:
ifeq ($(CONFIGURED),0)
  $(error Not configured, run ./configure)
endif

	@###
	@### BINARIES
	@###

	@# Create dir
	${MKDIR_P} /usr/local/bin/
	@# Copy files
	install -m 0755 bin/system-hibernate /usr/local/bin/system-hibernate
	install -m 0755 bin/system-reboot    /usr/local/bin/system-reboot
	install -m 0755 bin/system-shutdown  /usr/local/bin/system-shutdown
	install -m 0755 bin/system-suspend   /usr/local/bin/system-suspend
	install -m 0755 bin/xcolorpick       /usr/local/bin/xcolorpick
	install -m 0755 bin/xf86-audio       /usr/local/bin/xf86-audio
	install -m 0755 bin/xf86-backlight   /usr/local/bin/xf86-backlight
	install -m 0755 bin/xlock            /usr/local/bin/xlock
	install -m 0755 bin/xscreenshot      /usr/local/bin/xscreenshot


	@###
	@### SYSTEMD
	@###

	@# Create dir
	${MKDIR_P} /usr/lib/systemd/system
	${MKDIR_P} /usr/lib/systemd/logind.conf.d/
	@# Copy files
	install -m 0644 build/suspend.service   /usr/lib/systemd/system/suspend.service
	install -m 0644 build/70-close_lid.conf /usr/lib/systemd/logind.conf.d/70-close_lid.conf

	${SYSTEMCTL} enable suspend.service
	${SYSTEMCTL} daemon-reload

uninstall:
	@# Remove files
	rm -f /usr/local/bin/system-hibernate
	rm -f /usr/local/bin/system-reboot
	rm -f /usr/local/bin/system-shutdown
	rm -f /usr/local/bin/system-suspend
	rm -f /usr/local/bin/xcolorpick
	rm -f /usr/local/bin/xf86-audio
	rm -f /usr/local/bin/xf86-backlight
	rm -f /usr/local/bin/xlock
	rm -f /usr/local/bin/xscreenshot

	${SYSTEMCTL} disable suspend.service
	rm -f /usr/lib/systemd/system/suspend.service
	rm -f /usr/lib/systemd/logind.conf.d/70-close_lid.conf
	${SYSTEMCTL} daemon-reload


