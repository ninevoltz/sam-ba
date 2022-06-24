/****************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the QtAndroidExtras module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include "sambajni.h"

SambaJni *SambaJni::m_instance = nullptr;

static void callFromJava(JNIEnv *env, jobject /*thiz*/, jstring value) {
    emit SambaJni::instance()->messageFromJava(env->GetStringUTFChars(value, nullptr));
}

SambaJni::SambaJni(QObject *parent) : QObject(parent) {
    m_instance = this;

    JNINativeMethod methods[] {{"callFromJava", "(Ljava/lang/String;)V", reinterpret_cast<void *>(callFromJava)}};

    activity = QtAndroid::androidActivity();
    context = activity.callObjectMethod("getApplicationContext", "()Landroid/content/Context;");

    javaClass = new QAndroidJniObject("com/hoho/android/usbserial/jni/SambaJni");

    jclass objectClass = env->GetObjectClass(javaClass->object<jobject>());
    env->RegisterNatives(objectClass, methods, sizeof(methods) / sizeof(methods[0]));
    env->DeleteLocalRef(objectClass);
}

void SambaJni::printFromJava(const QString &message) {
    QAndroidJniObject javaMessage = QAndroidJniObject::fromString(message);
    javaClass->callMethod<void>("printFromJava", "(Ljava/lang/String;)V", javaMessage.object<jstring>());
}

bool SambaJni::open(int mode) {
    javaClass->callMethod<void>("connect", "(Landroid/content/Context;)V", context.object());
    connected = true;
    return true;
}

int SambaJni::read(const char* buffer, int len) {
    javaClass->callMethod<void>("read", "([B)I", buffer);
}

QByteArray SambaJni::read(int len) {
    QByteArray buffer;
    buffer.resize(len);
    char jbuff[len];
    javaClass->callMethod<void>("read", "([B)I", jbuff);
    for (int i = 0; i < len; i++) {
        buffer[i] = jbuff[i];
    }
}

int SambaJni::write(const char *buffer, int len) {
    javaClass->callMethod<void>("write", "([B,I)V", buffer, len);
    return len;
}

bool SambaJni::putChar(char c) {
    javaClass->callMethod<void>("write", "([B,I)V", c, 1);
    return true;
}

void SambaJni::close(void) {
    javaClass->callMethod<void>("disconnect");
    connected = false;
}

void SambaJni::waitForBytesWritten(int delay){

}

bool SambaJni::waitForReadyRead(int delay){

}

int SambaJni::bytesAvailable(){

}

bool SambaJni::isOpen() {
    return connected;
}

QStringList SambaJni::availablePorts(void) {

}

QString SambaJni::errorString(){

}
