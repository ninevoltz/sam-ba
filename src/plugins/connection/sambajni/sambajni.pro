TEMPLATE = lib
CONFIG += plugin
QT += core quick androidextras

TARGET = sambajni

DESTPATH = /qml/SAMBA/Connection/Serial

SOURCES += sambajni.cpp
HEADERS += sambajni.h

# set RPATH on Linux
unix:!mac:{
    QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN/../../../../lib\''
    QMAKE_RPATH =
}


# install
target.path = $$DESTPATH

INSTALLS *= target 

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
