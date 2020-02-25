import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class MediaNotification {
  static const MethodChannel _channel = const MethodChannel('media_notification');
  static Map<String, Function> _listeners = new Map();
  
  static Future<dynamic> _myUtilsHandler(MethodCall methodCall) async {
    // Вызываем слушателя события
    _listeners.forEach((event, callback) {
      if (methodCall.method == event) {
        callback();
        return true;
      }
    });
  }

  static Future show(
      {@required title, @required author, play = true, String image = ""}) async {
    //switching the image from a URI to a byteArray for Android with offset and length;
    List<int> imagebytes;
    if (image != null) {
      File imgFile = File(image);
      if (imgFile != null) {
        imagebytes = imgFile.readAsBytesSync();
      }
    }


    final Map<String, dynamic> params = <String, dynamic>{
      'title': title,
      'author': author,
      'play': play,
      'image': imagebytes,
      'length': imagebytes != null ? imagebytes.length : 0,
      'offset': 0
    };
    await _channel.invokeMethod('show', params);

    _channel.setMethodCallHandler(_myUtilsHandler);
  }

  static Future hide() async {
    await _channel.invokeMethod('hide');
  }

  static setListener(String event, Function callback) {
    _listeners.addAll({event: callback});
  } 
}
