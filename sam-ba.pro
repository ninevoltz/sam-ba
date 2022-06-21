TEMPLATE = subdirs

SUBDIRS = src examples dist doc

unix:android:{
QT += androidextras
}

no_doc:SUBDIRS -= doc
