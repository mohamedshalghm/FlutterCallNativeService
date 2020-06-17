package com.example.callnativeservice;

import android.content.Intent;
import android.view.View;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/start_music";
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("startMyService")) {
                                startMyService();
                                result.success(result);
                            } else if (call.method.equals("stopMyService")) {
                                stopMyService();
                                result.success(result);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
    public void startMyService() {
        startService(new Intent(this, MusicService.class));
    }
    public void stopMyService() {
        stopService(new Intent(this, MusicService.class));
    }
}
