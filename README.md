# media_notification

Media notification for flutter, on android (IOs Not implemented)

## Usage


### Calling
You can call the show method to show the media controls like follow :

```dart
ByteData image = await rootBundle.load('assets/icon/icon.png');

try {
      await MediaNotification.show(
        title: title, // the title of the track
        subtitle: subtitle, // a subtitle, usually the artist
        imageUrl: image, // an image, as a ByteData Object
        bgColor: Colors.deepPurple, // the background Color of the notification panel
        iconColor: Colors.blue, // The control icons colors
        subtitleColor: Colors.deepOrange, // The subtitle color
        titleColor: Colors.orange // the title color
      );
} on PlatformException catch(e) {
      print("Error: ${e.message}")
}
```

You can call the hide method to hide the Media controls like follow :

```dart
MediaNotification.hide();
```


### Screenshots

|                                           |                                           |
| ----------------------------------------- | ----------------------------------------- |
| <img src="screenshots/scrs.png" width="250"> | <img src="screenshots/scrs2.png" width="250"> |

## Getting Started With the development

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/platform-plugins/#edit-code).
