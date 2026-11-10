# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

USER_HOME ?= $(if $(SUDO_USER),$(shell getent passwd "$(SUDO_USER)" | cut -d: -f6),$(HOME))

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: dwm

.c.o:
	${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	cp config.def.h $@

dwm: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	rm -f dwm ${OBJ} *.orig *.rej

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -Dm755 dwm ${DESTDIR}${PREFIX}/bin/dwm
	install -Dm644 dwm.desktop ${DESTDIR}${XSESSIONSDIR}/dwm.desktop
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

	test -f "$(USER_HOME)/.xinitrc" || install -Dm644 .xinitrc "$(USER_HOME)/.xinitrc"
	test -f "$(USER_HOME)/.Xresources" || install -Dm644 .Xresources "$(USER_HOME)/.Xresources"
	test -e "$(USER_HOME)/.config/dwm/autostart.sh" || install -Dm755 config/autostart/autostart.sh "$(USER_HOME)/.config/dwm/autostart.sh"
	install -Dm644 .bashrc "$(USER_HOME)/.bashrc"

	install -d "$(USER_HOME)/.local/share/dwm-wattox/polybar"

	if [ "$$(realpath polybar)" != "$$(realpath "$(USER_HOME)/.local/share/dwm-wattox/polybar")" ]; then \
		cp -rf polybar/. "$(USER_HOME)/.local/share/dwm-wattox/polybar/"; \
	fi

	install -Dm755 polybar/launch.sh "$(USER_HOME)/.config/polybar/launch.sh"

	if [ -d "$(USER_HOME)/.local/share/dwm-wattox/polybar/scripts" ]; then \
		chmod +x "$(USER_HOME)/.local/share/dwm-wattox/polybar/scripts/"*; \
	fi

	install -Dm644 config/systemd/user/lid-inhibit.service "${DESTDIR}${SYSTEMDUSERDIR}/lid-inhibit.service"

	mkdir -p ${DESTDIR}${PREFIX}/bin
	install -Dm755 scripts/* ${DESTDIR}${PREFIX}/bin/

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm \
		${DESTDIR}${PREFIX}/bin/dwm-session \
		${DESTDIR}${PREFIX}/bin/lidmode \
		${DESTDIR}${PREFIX}/bin/lidstatus \
		${DESTDIR}${PREFIX}/bin/nightshift \
		${DESTDIR}${PREFIX}/bin/nightstatus \
		${DESTDIR}${XSESSIONSDIR}/dwm.desktop \
		${DESTDIR}${MANPREFIX}/man1/dwm.1 \
		${DESTDIR}${SYSTEMDUSERDIR}/lid-inhibit.service \
		"$(USER_HOME)/.config/polybar/launch.sh"

release: dwm
	mkdir -p release
	cp -f dwm release/
	cp -f dwm.desktop release/
	cp -f .xinitrc release/
	cp -f .Xresources release/
	cp -rf polybar release/
	cp -rf scripts release/
	cp -rf config/autostart release/
	tar -czf release/Omitus-${VERSION}.tar.gz -C release dwm dwm.desktop .xinitrc .Xresources polybar scripts config/autostart

.PHONY: all clean install uninstall release
