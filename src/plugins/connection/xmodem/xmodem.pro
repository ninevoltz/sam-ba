TEMPLATE = lib
CONFIG += dll
QT += core serialport

unix:android:{
QT += androidextras
}

TARGET = samba_conn_xmodem

win32: DESTPATH = /
else:unix: DESTPATH = /lib

unix:android: LIBS += -L$$OUT_PWD/../sambajni -lsambajni_$$ANDROID_ABIS

SOURCES += xmodemhelper.cpp
HEADERS += xmodemhelper.h

# set RPATH on Linux
unix:!mac:{
    QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN\''
    QMAKE_RPATH =
}

# install
target.path = $$DESTPATH
INSTALLS *= target
