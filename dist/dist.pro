TEMPLATE = subdirs

# map Qt version to ICU versions
equals(QT_MAJOR_VERSION, 5) {
	equals(QT_MINOR_VERSION, 15): ICU_VERSION = 56
}
isEmpty(ICU_VERSION) {
	error(Unknown QT version)
}

# for Windows targets, copy AT91 USB driver
win32:SUBDIRS += driver

# copy documents at root of package
rootdocs.path = /
rootdocs.files = README.txt LICENSE.txt CHANGELOG.txt
unix:contains(QT_ARCH, arm):rootdocs.files += README.armv7.txt
INSTALLS += rootdocs

# copy qt.conf
qtconf.path = /
qtconf.files = qt.conf
INSTALLS += qtconf

# copy Qt libs
unix:!android:{
	qtlibs.path = /lib
	qtlibs.files = \
		$$[QT_INSTALL_LIBS]/libQt5Core.so.5 \
		$$[QT_INSTALL_LIBS]/libQt5Gui.so.5 \
		$$[QT_INSTALL_LIBS]/libQt5Network.so.5 \
		$$[QT_INSTALL_LIBS]/libQt5Qml.so.5 \
		$$[QT_INSTALL_LIBS]/libQt5Quick.so.5 \
		$$[QT_INSTALL_LIBS]/libQt5SerialPort.so.5
	INSTALLS += qtlibs

	otherlibs.path = /lib
	otherlibs.files = \
		$$[QT_INSTALL_LIBS]/libicudata.so.$$ICU_VERSION \
		$$[QT_INSTALL_LIBS]/libicui18n.so.$$ICU_VERSION \
		$$[QT_INSTALL_LIBS]/libicuuc.so.$$ICU_VERSION
	INSTALLS += otherlibs

	qmlmodules.path = /qml
	qmlmodules.files = $$[QT_INSTALL_QML]/QtQuick.2
	INSTALLS += qmlmodules
}
else:win32:{

	qtlibs.path = /
	CONFIG(debug, debug|release):{
		qtlibs.files = \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Cored.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Guid.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Networkd.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Qmld.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5QmlModelsd.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5QmlWorkerScriptd.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Quickd.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5SerialPortd.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5Widgetsd.dll
	}
	else:{
		qtlibs.files = \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Core.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Gui.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Network.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Qml.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5QmlModelsd.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5QmlWorkerScriptd.dll \
			$$[QT_INSTALL_LIBS]/../bin/Qt5Quick.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5SerialPort.dll \
                        $$[QT_INSTALL_LIBS]/../bin/Qt5Widgetsd.dll

	}
	INSTALLS += qtlibs

        platformlibs.path = /plugins/platforms
        platformlibs.files = \
            $$[QT_INSTALL_LIBS]/../plugins/platforms/*.dll



	otherlibs.path = /
	otherlibs.files = \
		$$[QT_INSTALL_LIBS]/../bin/libwinpthread-1.dll \
		$$[QT_INSTALL_LIBS]/../bin/libgcc_s_dw2-1.dll \
		$$[QT_INSTALL_LIBS]/../bin/libstdc++-6.dll \
	otherlibs.CONFIG += no_check_exist
        INSTALLS += platformlibs otherlibs

        qmlmodules.path = qml
        qmlmodules.files = \
            $$[QT_INSTALL_QML]/QtQuick.2 \
            $$PWD/qml/*

        metadata.path = metadata
        metadata.files = $$PWD/metadata/*

        INSTALLS += target metadata qmlmodules
}

unix:android:{
        qtlibs.path = /lib
        qtlibs.files = \
                $$[QT_INSTALL_LIBS]/libQt5Core_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5Gui_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5Network_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5Qml_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5Quick_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5SerialPort_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5QmlModels_$$ANDROID_ABIS.so \
                $$[QT_INSTALL_LIBS]/libQt5QmlWorkerScript_$$ANDROID_ABIS.so

        INSTALLS += qtlibs

        qmlmodules.path = /assets/qml
        qmlmodules.files = \
            $$[QT_INSTALL_QML]/QtQuick.2 \
            $$[QT_INSTALL_QML]/SAMBA

        metadata.path = /assets/metadata
        metadata.files = $$PWD/metadata/*

        INSTALLS += target metadata qmlmodules

}

# copy multi_sam-ba.py
script.path = /
script.files = multi_sam-ba.py

post_script.path = /
unix:!android:post_script.extra = cd $(INSTALL_ROOT)/; chmod 755 $$script.files

INSTALLS += script post_script
