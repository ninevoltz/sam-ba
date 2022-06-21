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
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
