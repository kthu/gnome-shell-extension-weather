#!/bin/sh

POT=gnome-shell-extension-weather.pot
SCH_IN=../data/org.gnome.shell.extensions.weather.gschema.xml.in
SCH_H=../data/org.gnome.shell.extensions.weather.gschema.xml.in.h
MSG=messages.po
TMP=merged.po

# update pot
make ${POT}
echo '' > ${MSG}
intltool-extract --type=gettext/xml "${SCH_IN}"
xgettext -c --from-code UTF-8 -o ${MSG} -L python -j --keyword=_ ../src/*.js
xgettext -c --from-code UTF-8 -o ${MSG} -L glade  -j --keyword=_ ../data/*.xml
xgettext --no-location --from-code UTF-8 -o ${MSG} -L C -j --keyword=N_ ${SCH_H}
msgmerge -N ${POT} ${MSG} > ${TMP}
mv -f ${TMP} ${POT}
rm -f ${MSG} ${SCH_H}

# update po's
for po in $(cat LINGUAS); do
    echo -n "Updating ${po}: "
    msgmerge -U "${po}.po" gnome-shell-extension-weather.pot;
done
