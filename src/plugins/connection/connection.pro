TEMPLATE = subdirs

SUBDIRS = xmodem serial secure 

unix:android:{
SUBDIRS += sambajni
}

exists($${JLINKSDKPATH}/Inc/JLinkARMDLL.h):SUBDIRS += jlink
exists($${JLINKSDKPATH}/Samples_Inc/JLinkARMDLL.h):SUBDIRS += jlink
