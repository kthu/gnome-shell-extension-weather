AC_PREREQ(2.63)
dnl be carefull, the version needs to be in sync with your gnome shell version
AC_INIT([gnome-shell-extension-weather],[1.1],[https://github.com/canek-pelaez/gnome-shell-extension-weather/issues])

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([config])

AM_INIT_AUTOMAKE([1.10 dist-xz])

m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

AC_PROG_SED

GETTEXT_PACKAGE=gnome-shell-extension-weather
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE, "$GETTEXT_PACKAGE",
                   [The prefix for our gettext translation domains.])
IT_PROG_INTLTOOL(0.26)

PKG_PROG_PKG_CONFIG([0.22])

GLIB_GSETTINGS

AC_ARG_WITH([local-install],
	     [AS_HELP_STRING([--with-local-install],
			     [install schemas and translations in a subdir of the extension (default is no)])],
	     [use_local_install=$withval],
	     [use_local_install=no])

AC_SUBST(use_local_install)
AM_CONDITIONAL(LOCAL_INSTALL, test "x${use_local_install}" == "xyes")

extensiontopdir=${datadir}/gnome-shell/extensions/weather@gnome-shell-extensions.gnome.org

dnl This is beyond ugly. Suggestions accepted.
if test "x${use_local_install}" == "xyes"; then
   AC_SUBST(gsettingsschemadir, [${extensiontopdir}/schemas])
   AC_SUBST(LOCALEDIR, [${extensiontopdir}/locale])
else
   AC_SUBST(LOCALEDIR, [${datadir}/locale])
fi

dnl Please keep this sorted alphabetically.
AC_CONFIG_FILES([
  Makefile
  data/Makefile
  po/Makefile.in
  src/Makefile
])
AC_OUTPUT

dnl 'Fugly hack' doesn't get close to describe this. I don't know how else
dnl to change the directory for translations.
if test "x${use_local_install}" == "xyes"; then
   ${SED} -i -e "s%itlocaledir = .*%itlocaledir = ${extensiontopdir}/locale%g" po/Makefile
fi

if test "x$use_local_install" == "xyes"; then
   echo
   echo "The schemas and translations will be installed in subdirectories of the extension."
   echo
fi
