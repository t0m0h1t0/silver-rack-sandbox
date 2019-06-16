# my_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Run the app

1. Check that an Android device or iPhone is runnning. If you do not have the device, you should start the emulator of Android device or iPhone with followig command.

```
$ ~/Library/Android/sdk/tools/emulator @Pixel_3_API_25 # start the emulator of Pixel3
$ open -a Simulator # start the emulator of iPhone
$ flutter devices
1 connected device:

iPhone 8 Plus • 326F6D91-4246-4640-9D4B-550F327FD2D8 • ios • com.apple.CoreSimulator.SimRuntime.iOS-12-2 (simulator)
```

2. Run the app with the following command.

```
$ flutter run
```

## Tips

### Get packages

1. Update ``pubspec.yaml`` by adding packages you want to import, as shown below:
```
dependencies:
    flutter:
      sdk: flutter

    cupertino_icons: ^0.1.2
    english_words: ^3.1.0       // Add this line.
```

2. By typing the following in the command line, you can add packages.
```
$ flutter packages get
```


### Syntax highlight dart for vim

1. Add following in ``.vimrc``

```
NeoBundle 'dart-lang/dart-vim-plugin'
au BufNewFile,BufRead *.dart :set filetype=dart
```

Notice whether you have installed NeoBundle which is the plugin for vim or not.

## Visible widget

Scaffold widget provides default app bar and the property which keeps widget tree for home screen.
Create a Scaffold widget:
```
Scaffold(
    appBar: AppBar(
        title; Text('hoge'),
    ),
    body; Center(
        child: Text('hoge'),
    ),
)
```

Create a Text widget:
```
Text('Hello World'),
```

Create an Image widget:
```
Image.asset(
    'images/hoge.png',
    fit: BoxFit.cover,
),
```

Create an Icon widget:
```
Icon(
    Icons.star,
    color: Colors.red[500],
),
```


## Term list

- Container
    - Container is a widget class that allows you to customize its child widget. Use a Container when you want to add padding, margins, borders, or background color, to name some of its capabilities.
