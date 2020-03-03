import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class MediaNotification {
  static const MethodChannel _channel = const MethodChannel('media_notification');
  static Map<String, Function> _listeners = new Map();
  
  static Future<dynamic> _myUtilsHandler(MethodCall methodCall) async {
    /// Calling the event listener
    _listeners.forEach((event, callback) {
      if (methodCall.method == event) {
        callback();
        return true;
      }
      return false;
    });
  }

  static Uint8List byteDatatoList(ByteData data) {
    final buffer = data.buffer;

    return buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }

  ///  params @BitmapImage a list of bytes representing an image, has less priority when @image is present
  static Future show({
    @required title,
    @required author,
    play = true,
    String image,
    List<int> bitmapImage,
    Color bgColor,
    Color titleColor,
    Color subtitleColor,
    Color iconColor,
    Icon previousIcon}) async {

    /// Switching the image from a URI to a byteArray for Android with offset and length;
    ByteData bytesImage = await rootBundle.load('assets/images/icon.png');
    List<int> imagebytes = byteDatatoList(bytesImage);

    final Map<String, dynamic> params = <String, dynamic> {
      'title': title,
      'author': author,
      'play': play,
      'image': (imagebytes != null) ? imagebytes : bitmapImage,
      'length': (imagebytes != null) ? imagebytes.length : ((bitmapImage != null) ? bitmapImage.length: 0),
      'offset': 0,

      'bgColor': (bgColor != null)
          ? '#${bgColor.value.toRadixString(16)}'
          : '#${Colors.white.value.toRadixString(16)}',

      'titleColor': (titleColor != null) ?
          '#${titleColor.value.toRadixString(16)}' : '#${Colors.black.value.toRadixString(16)}',

      'subtitleColor': (subtitleColor != null) ?
          '#${subtitleColor.value.toRadixString(16)}' : '#838383',

      /// This color is arbitrary and can be changed but it keeps a good look
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