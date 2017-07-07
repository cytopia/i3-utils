# Configuration
SHELL = /bin/sh
MKDIR_P = mkdir -p

all:
	@echo "Type 'make install' or 'make uninstall'"
	@echo
	@echo "Both, 'make install' and 'make uninstal' require root/sudo privileges"
	@echo
	@echo "'make install' will copy all files from bin/ to /usr/local/bin/"
	@echo "'make uninstall' will remove those files from /usr/local/bin/"

install:
	# Create dir
	${MKDIR_P} /usr/local/bin/
	# Copy files
	install -m 0755 bin/system-hibernate /usr/local/bin/system-hibernate
	install -m 0755 bin/system-reboot    /usr/local/bin/system-reboot
	install -m 0755 bin/system-shutdown  /usr/local/bin/system-shutdown
	install -m 0755 bin/system-suspend   /usr/local/bin/system-suspend
	install -m 0755 bin/xcolorpick       /usr/local/bin/xcolorpick
	install -m 0755 bin/xlock            /usr/local/bin/xlock
	install -m 0755 bin/xscreenshot      /usr/local/bin/xscreenshot

uninstall:
	# Remove files
	rm -f /usr/local/bin/system-hibernate
	rm -f /usr/local/bin/system-reboot
	rm -f /usr/local/bin/system-shutdown
	rm -f /usr/local/bin/system-suspend
	rm -f /usr/local/bin/xcolorpick
	rm -f /usr/local/bin/xlock
	rm -f /usr/local/bin/xscreenshot

