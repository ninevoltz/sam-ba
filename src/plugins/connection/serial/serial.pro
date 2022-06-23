TEMPLATE = lib
CONFIG += plugin
QT += core serialport qml quick

unix:android:{
QT += androidextras
}

TARGET = samba_conn_serial

DESTPATH = /qml/SAMBA/Connection/Serial

SOURCES += sambaconnectionserialhelper.cpp
HEADERS += sambaconnectionserialhelper.h

unix:android:{
SOURCES += \
    sambajni.cpp
HEADERS += \
    sambajni.h
}

INCLUDEPATH += $$PWD/../xmodem
DEPENDPATH += $$PWD/../xmodem

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../xmodem/release -lsamba_conn_xmodem
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../xmodem/debug -lsamba_conn_xmodem
else:unix:!android: LIBS += -L$$OUT_PWD/../xmodem -lsamba_conn_xmodem
else:unix:android: LIBS += -L$$OUT_PWD/../xmodem -lsamba_conn_xmodem_$$ANDROID_ABIS

# set RPATH on Linux
unix:!mac:{
    QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN/../../../../lib\''
    QMAKE_RPATH =
}

qml.files = \
	qmldir \
	SerialConnection.qml

metadata.files = \
	connection_serial.json

# install
target.path = $$DESTPATH
qml.path = $$DESTPATH
metadata.path = /metadata
INSTALLS *= target qml metadata

OTHER_FILES += \
    $$qml.files \
    module_samba_connection_serial.qdoc

DISTFILES += \
    usb-serial-for-android/CdcAcmSerialDriver.java \
    usb-serial-for-android/Ch34xSerialDriver.java \
    usb-serial-for-android/CommonUsbSerialPort.java \
    usb-serial-for-android/FtdiSerialDriver.java \
    usb-serial-for-android/MonotonicClock.java \
    usb-serial-for-android/ProbeTable.java \
    usb-serial-for-android/ProlificSerialDriver.java \
    usb-serial-for-android/SerialInputOutputManager.java \
    usb-serial-for-android/SerialTimeoutException.java \
    usb-serial-for-android/UsbId.java \
    usb-serial-for-android/UsbSerialDriver.java \
    usb-serial-for-android/UsbSerialPort.java \
    usb-serial-for-android/UsbSerialProber.java
