package com.example.sleep_early;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.PowerManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import java.lang.reflect.Method;


public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "heartbeat.fritz.ai/native";

  @RequiresApi(api = VERSION_CODES.M)
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
        .setMethodCallHandler((call, result) -> {
          if (call.method.equals("powerManage")) {
            boolean deviceStatus = getDeviceStatus();

            String myMessage = Boolean.toString(deviceStatus);
            result.success(myMessage);

          }
        });
  }

  @RequiresApi(api = VERSION_CODES.M)
  private boolean getDeviceStatus() {
    boolean deviceStatus = false;
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      PowerManager powerManager = (PowerManager) getSystemService(POWER_SERVICE);
      deviceStatus = powerManager.isDeviceIdleMode();
      // powerManager.reboot(" ");
      try {
		                 
        //获得ServiceManager类
        Class<?> ServiceManager = Class
           .forName("android.os.ServiceManager");
        
        //获得ServiceManager的getService方法
        Method getService = ServiceManager.getMethod("getService", java.lang.String.class);
        
        //调用getService获取RemoteService
        Object oRemoteService = getService.invoke(null, Context.POWER_SERVICE);
        
        //获得IPowerManager.Stub类
        Class<?> cStub = Class
           .forName("android.os.IPowerManager$Stub");
        //获得asInterface方法
        Method asInterface = cStub.getMethod("asInterface", android.os.IBinder.class);
        //调用asInterface方法获取IPowerManager对象
        Object oIPowerManager = asInterface.invoke(null, oRemoteService);
        //获得shutdown()方法
        Method shutdown = oIPowerManager.getClass().getMethod("shutdown",boolean.class,boolean.class);
        //调用shutdown()方法
        shutdown.invoke(oIPowerManager,false,true);           
  
      } catch (Exception e) {         
        Log.e("error",e.toString());
      }

    }

    return deviceStatus;

  }

}
