# practice-flutter
This directory is for practice of flutter.

## How to Install
1. Dounload the following URL to get the latest stable release of the Flutter SDK.

[flutter_macos_v1.5.4-hotfix.2-stable.zip](https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.5.4-hotfix.2-stable.zip)

2. Extract the file in the desired location, for example
```
$ cd practice-flutter
$ unzip ~/Downloads/flutter_macos_v1.5.4-hotfix.2-stable.zip
```

3. Parmently add the ``flutter`` tool to the path.
```
$ echo "export PATH=\"$PATH:`pwd`/flutter/bin\"" >> ~/.bash_profile
```

4. Optionally, pre-download development binarie
```
$ flutter precache
```

5. Run flutter doctor
```
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, v1.5.4-hotfix.2, on Mac OS X 10.14.5 18F132, locale ja-JP)
[✗] Android toolchain - develop for Android devices
    ✗ Unable to locate Android SDK.
      Install Android Studio from: https://developer.android.com/studio/index.html
      On first launch it will assist you in installing the Android SDK components.
      (or visit https://flutter.dev/setup/#android-setup for detailed instructions).
      If the Android SDK has been installed to a custom location, set ANDROID_HOME to that location.
      You may also want to add it to your PATH environment variable.

[!] iOS toolchain - develop for iOS devices (Xcode 10.2.1)
    ✗ libimobiledevice and ideviceinstaller are not installed. To install with Brew, run:
        brew update
        brew install --HEAD usbmuxd
        brew link usbmuxd
        brew install --HEAD libimobiledevice
        brew install ideviceinstaller
    ✗ ios-deploy not installed. To install:
        brew install ios-deploy
    ✗ CocoaPods not installed.
        CocoaPods is used to retrieve the iOS platform side's plugin code that responds to your plugin usage on the Dart side.
        Without resolving iOS dependencies with CocoaPods, plugins will not work on iOS.
        For more info, see https://flutter.dev/platform-plugins
      To install:
        brew install cocoapods
        pod setup
[!] Android Studio (version 3.4)
    ✗ Flutter plugin not installed; this adds Flutter specific functionality.
    ✗ Dart plugin not installed; this adds Dart specific functionality.
[!] VS Code (version 1.35.0)
    ✗ Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[!] Connected device
    ! No devices available

! Doctor found issues in 5 categories.

```

6. Solve the problem about Android toolchain

You can get the ``Android Studio`` from [here](https://developer.android.com/studio/index.html).

