TEMPLATE = app
CONFIG += console
CONFIG -= app_bundle
QT += core qml quick gui widgets

unix:android:{
QT += androidextras
}

TARGET = sam-ba

VERSION = 3.3
EXTRAVERSION =
DEFINES += SAMBA_VERSION=\\\"$$VERSION$$EXTRAVERSION\\\"

SOURCES += \
    main.cpp \
    sambacomponent.cpp \
    sambaengine.cpp \
    sambametadata.cpp \
    sambatool.cpp

HEADERS += \
    sambacomponent.h \
    sambaengine.h \
    sambametadata.h \
    sambatool.h \
    sambatoolcontext.h

FORMS += \
    samba_ui.ui

# set RPATH on Linux
unix:!mac:{
    QMAKE_LFLAGS += '-Wl,-rpath-link,$$[QT_INSTALL_LIBS]'
    QMAKE_LFLAGS += '-Wl,-rpath,\'\$$ORIGIN/lib\''
    QMAKE_RPATH =
}

qml.files = \
	qmldir \
	AppletCommandHandler.qml \
	MonitorCommandHandler.qml \
	ScriptProxy.qml
qml.path = /qml/SAMBA/Tool

# install executable
target.path = /
INSTALLS += target qml

DISTFILES += \
    android/AndroidManifest.xml \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/build.gradle \
    android/gradle.properties \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew \
    android/gradlew.bat \
    android/gradlew.bat \
    android/res/values/libs.xml \
    android/res/values/libs.xml \
    android/src/androidTest/AndroidManifest.xml \
    android/src/androidTest/java/com/hoho/android/usbserial/CrossoverTest.java \
    android/src/androidTest/java/com/hoho/android/usbserial/DeviceTest.java \
    android/src/androidTest/java/com/hoho/android/usbserial/driver/CommonUsbSerialPortWrapper.java \
    android/src/androidTest/java/com/hoho/android/usbserial/driver/ProlificSerialPortWrapper.java \
    android/src/androidTest/java/com/hoho/android/usbserial/util/TelnetWrapper.java \
    android/src/androidTest/java/com/hoho/android/usbserial/util/TestBuffer.java \
    android/src/androidTest/java/com/hoho/android/usbserial/util/UsbWrapper.java \
    android/src/com/hoho/android/usbserial/driver/CdcAcmSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/Ch34xSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/CommonUsbSerialPort.java \
    android/src/com/hoho/android/usbserial/driver/Cp21xxSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/FtdiSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/ProbeTable.java \
    android/src/com/hoho/android/usbserial/driver/ProlificSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/SerialTimeoutException.java \
    android/src/com/hoho/android/usbserial/driver/UsbId.java \
    android/src/com/hoho/android/usbserial/driver/UsbSerialDriver.java \
    android/src/com/hoho/android/usbserial/driver/UsbSerialPort.java \
    android/src/com/hoho/android/usbserial/driver/UsbSerialProber.java \
    android/src/com/hoho/android/usbserial/jni/SambaJni.java \
    android/src/com/hoho/android/usbserial/util/MonotonicClock.java \
    android/src/com/hoho/android/usbserial/util/SerialInputOutputManager.java \
    android/src/main/AndroidManifest.xml \
    android/src/main/java/com/hoho/android/usbserial/driver/CdcAcmSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/Ch34xSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/CommonUsbSerialPort.java \
    android/src/main/java/com/hoho/android/usbserial/driver/Cp21xxSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/FtdiSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/ProbeTable.java \
    android/src/main/java/com/hoho/android/usbserial/driver/ProlificSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/SerialTimeoutException.java \
    android/src/main/java/com/hoho/android/usbserial/driver/UsbId.java \
    android/src/main/java/com/hoho/android/usbserial/driver/UsbSerialDriver.java \
    android/src/main/java/com/hoho/android/usbserial/driver/UsbSerialPort.java \
    android/src/main/java/com/hoho/android/usbserial/driver/UsbSerialProber.java \
    android/src/main/java/com/hoho/android/usbserial/util/MonotonicClock.java \
    android/src/main/java/com/hoho/android/usbserial/util/SerialInputOutputManager.java \
    android/src/test/java/com/hoho/android/usbserial/driver/FtdiSerialDriverTest.java

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
