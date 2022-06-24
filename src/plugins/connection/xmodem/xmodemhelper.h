#ifndef XMODEMHELPER_H
#define XMODEMHELPER_H

#include <QByteArray>
#include <QElapsedTimer>
#include <QSerialPort>

#ifdef Q_OS_ANDROID
#include "../sambajni/sambajni.h"
#endif

class Q_DECL_EXPORT XmodemHelper
{
public:

#ifdef Q_OS_ANDROID
    XmodemHelper(SambaJni* serial);
#else
    XmodemHelper(QSerialPort& serial);
#endif

	QByteArray receive(int length);
	bool send(const QByteArray &data);

private:
	void updateCRC(uint16_t &crc, const uint8_t data);
	bool readData(uint8_t* data, int length);
	bool readByte(uint8_t* data);
	bool writeData(uint8_t* data, int length);
	bool writeByte(uint8_t data);
	int putPacket(const char* data, int offset, int length, uint8_t seqno);
	QByteArray getPacket(int length, uint8_t seqno);

private:
#ifdef Q_OS_ANDROID
    SambaJni *m_serial;
#else
    QSerialPort *m_serial;
#endif

};

#endif // XMODEMHELPER_H
