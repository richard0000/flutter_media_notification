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

  /**
   *  params @BitmapImage a list of bytes representing an image, has less priority when @image is present
   */
  static Future show(
      {@required title, @required author, play = true, String image = "", Color bgColor, Color titleColor, Color subtitleColor, Color iconColor, Icon previousIcon}) async {



    final Map<String, dynamic> params = <String, dynamic>{
      'title': title,
      'author': author,
      'play': play,
      'offset': 0,
      'bgColor': bgColor != null
          ? '#${bgColor.value.toRadixString(16)}'
          : '#${Colors.white.value.toRadixString(16)}',
      'titleColor': titleColor != null ? '#${titleColor.value.toRadixString(
          16)}' : '#${Colors.black.value.toRadixString(16)}',
      'subtitleColor': subtitleColor != null ? '#${subtitleColor.value
          .toRadixString(16)}' : '#838383',
      // this color is arbitrary and can be changed but it keeps a good look
      'iconColor': iconColor != null
          ? '#${iconColor.value.toRadixString(16)}'
          : '#${Colors.black.value.toRadixString(16)}',
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
