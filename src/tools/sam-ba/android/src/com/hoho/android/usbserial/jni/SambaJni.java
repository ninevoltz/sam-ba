package com.hoho.android.usbserial.jni;

public class SambaJni
{
    private static native void callFromJava(String message);

    public SambaJni() {}

    public static void printFromJava(String message)
    {
        System.out.println("This is printed from JAVA, message is: " + message);
        callFromJava("Hours wasted with overly complex software!");
    }
}

