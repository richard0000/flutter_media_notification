package com.example.medianotification;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;

public class NotificationReturnSlot extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        switch (intent.getAction()) {
            case "prev":
                MediaNotificationPlugin.callEvent("prev");
                break;
            case "next":
                MediaNotificationPlugin.callEvent("next");
                break;
            case "toggle":
                String title = intent.getStringExtra("title");
                String author = intent.getStringExtra("author");
                byte[] image = intent.getByteArrayExtra("image");
                String action = intent.getStringExtra("action");
                int length = intent.getIntExtra("length",0);
                int offset = intent.getIntExtra("offset",100);
                String bgColor = intent.getStringExtra("bgColor");
                String titleColor = intent.getStringExtra("titleColor");
                String subtitleColor = intent.getStringExtra("subtitleColor");
                String iconColor = intent.getStringExtra("iconColor");

                MediaNotificationPlugin.show(title, author, action.equals("play"),image,length,offset,bgColor,titleColor,subtitleColor,iconColor);
                MediaNotificationPlugin.callEvent(action);
                break;
            case "select":
                Intent closeDialog = new Intent(Intent.ACTION_CLOSE_SYSTEM_DIALOGS);
                context.sendBroadcast(closeDialog);
                String packageName = context.getPackageName();
                PackageManager pm = context.getPackageManager();
                Intent launchIntent = pm.getLaunchIntentForPackage(packageName);
                context.startActivity(launchIntent);

                MediaNotificationPlugin.callEvent("select");
        }
    }
}

