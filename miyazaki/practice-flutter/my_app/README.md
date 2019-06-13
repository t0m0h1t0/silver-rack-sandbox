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

### Syntax highlight dart for vim

1. Add following in ``.vimrc``

```
NeoBundle 'dart-lang/dart-vim-plugin'
au BufNewFile,BufRead *.dart :set filetype=dart
```

Notice whether you have installed NeoBundle which is the plugin for vim or not.
