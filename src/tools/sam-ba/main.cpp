/*
 * Copyright (c) 2015-2016, Atmel Corporation.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 */

#include "sambatool.h"
#include <QApplication>

QTextEdit * s_qml_text_edit = 0;

void myMessageOutput(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
    static int first = 0;
    if (s_qml_text_edit)
    {
        QString temp = msg;
        if (msg.contains("Erased")) {
            if (first == 1) {
                s_qml_text_edit->setFocus();
                QTextCursor storeCursorPos = s_qml_text_edit->textCursor();
                s_qml_text_edit->moveCursor(QTextCursor::End, QTextCursor::MoveAnchor);
                s_qml_text_edit->moveCursor(QTextCursor::StartOfLine, QTextCursor::MoveAnchor);
                s_qml_text_edit->moveCursor(QTextCursor::End, QTextCursor::KeepAnchor);
                s_qml_text_edit->textCursor().removeSelectedText();
                s_qml_text_edit->textCursor().deletePreviousChar();
                s_qml_text_edit->setTextCursor(storeCursorPos);
            }
            first = 1;
        }
        s_qml_text_edit->append(temp);

        QCoreApplication::processEvents();
    }
}

int main(int argc, char *argv[])
{
    QLoggingCategory::setFilterRules("*.debug=false\n"
            "qml.debug=true");
	qSetMessagePattern("%{message}");
    qInstallMessageHandler(myMessageOutput);
    SambaTool a(argc, argv);
    s_qml_text_edit = a.ui.MessageText;

    return a.exec();
}
