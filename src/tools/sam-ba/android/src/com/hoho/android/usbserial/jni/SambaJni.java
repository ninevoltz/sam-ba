package com.hoho.android.usbserial.jni;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbDeviceConnection;
import android.hardware.usb.UsbManager;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;

import com.hoho.android.usbserial.driver.UsbSerialDriver;
import com.hoho.android.usbserial.driver.UsbSerialPort;
import com.hoho.android.usbserial.driver.UsbSerialProber;
import com.hoho.android.usbserial.util.SerialInputOutputManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import java.io.IOException;
import java.util.Arrays;
import java.util.EnumSet;
import java.util.List;

public class SambaJni {

    private static native void callFromJava(String message);

    //private static final String INTENT_ACTION_GRANT_USB = BuildConfig.APPLICATION_ID + ".GRANT_USB";
    private static final int WRITE_WAIT_MILLIS = 2000;
    private static final int READ_WAIT_MILLIS = 2000;

    public SambaJni() {}

    public static UsbManager manager = null;
    public static UsbSerialPort port = null;
    public static UsbDeviceConnection connection = null;
    public static UsbSerialDriver driver = null;
    public static boolean connected = false;
    private enum UsbPermission { Unknown, Requested, Granted, Denied }
    private UsbPermission usbPermission = UsbPermission.Unknown;

    public void printFromJava(String message) {
        System.out.println("This is printed from JAVA, message is: " + message);
        callFromJava("Successfully called Qt function from Java JNI!");
    }

    public void connect(Context context) {
        // Find all available drivers from attached devices.
        manager = (UsbManager) context.getSystemService(Context.USB_SERVICE);
        List<UsbSerialDriver> availableDrivers = UsbSerialProber.getDefaultProber().findAllDrivers(manager);
        if (availableDrivers.isEmpty()) {
            return;
        }

        // Open a connection to the first available driver.
        driver = availableDrivers.get(0);
        connection = manager.openDevice(driver.getDevice());
        if (connection == null) {
            usbPermission = UsbPermission.Requested;
            PendingIntent usbPermissionIntent = PendingIntent.getBroadcast(context, 0, new Intent("com.atmel.samba.GRANT_USB"), 0);
            manager.requestPermission(driver.getDevice(), usbPermissionIntent);
            callFromJava("got null connection.");
            return;
        }

        port = driver.getPorts().get(0); // Most devices have just one port (port 0)
        try {
            port.open(connection);
            port.setParameters(921600, 8, UsbSerialPort.STOPBITS_1, UsbSerialPort.PARITY_NONE);
            connected = true;
            callFromJava("connection successful.");
        } catch (Exception e) {
            callFromJava("connection failed: " + e.getMessage());
            //disconnect();
        }
    }

    public int read(byte[] buffer) {
        int len = 0;
        try {
            len = port.read(buffer, READ_WAIT_MILLIS);
        } catch (Exception e) {
            callFromJava("read failed: " + e.getMessage());
        }
        return len;
    }

    public void write(byte[] buffer, int len) {
        try {
            port.write(buffer, WRITE_WAIT_MILLIS);
        } catch (Exception e) {
            callFromJava("read failed: " + e.getMessage());
        }
    }

    public void disconnect() {
        connected = false;
        if(manager != null) {
            //manager.setListener(null);
            //manager.stop();
        }
        manager = null;
        if(port != null) {
            try {
                port.close();
            } catch (IOException ignored) {}
        }
        port = null;
    }

    public List<UsbSerialPort> availablePorts() {
        return driver.getPorts();
    }
}

