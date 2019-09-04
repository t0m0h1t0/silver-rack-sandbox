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

6. Solve the problem about android licenses.
    ```
    $ flutter doctor --android-licenses
     :
    Accept? (y/N): y
    All SDK package licenses accepted
    ````

7. Solve else problem.
    ```
    $ flutter doctor
     :
    [!] iOS toolchain - develop for iOS devices (Xcode 9.3.1)
    ✗ libimobiledevice and ideviceinstaller are not installed. To install, run:
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
        For more info, see https://flutter.io/platform-plugins
      To install:
        brew install cocoapods
        pod setup
     :
    ```
    ```
    $ brew install --HEAD usbmuxd
    $ brew link usbmuxd
    $ brew install --HEAD libimobiledevice
    $ brew install ideviceinstaller
    $ brew install ios-deploy
    $ brew install cocoapods
    $ pod setup
    ```

8. Install Android Studio, Flutter and Dart.

    Install Android Studio from [here](https://developer.android.com/studio/index.html).

    Install Flutter and Dart plugin in Android Stduio.

    ``Preference.. > Plugins > Brouwse repositories..`` in ``Android Studio``.

9. Ignore VS Code and Connected device.

    ```
    $ flutter doctor
     :
    [!] VS Code (version 1.29.1)
    ✗ Flutter extension not installed; install from
      https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
    [!] Connected device
    ! No devices available
    ```

    I do not use VS Code and Device because I will use simulator of Android and iOS.

10. Create Virtual Device in Android Studio.

    1. ``Tools > AVD Manager`` in Android Studio.
    2. Select ``Create New Virtual Device``.
    3. Select anything device.
    4. Downlod anything system image. (ex. Nougat Download)

11. Operation Check

    - android device

    ```
    $ ~/Library/Android/sdk/tools/emulator -list-avds
    Pixel_3_API_25
    $ ~/Library/Android/sdk/tools/emulator @Pixel_3_API_25
    ```

    - iOS device
    ```
    $ open -a Simulator
    ```

    We can choose the series of iPhone.
    ``Hardware > Device`` on menu bar of xCode.

12. Success!

    ![pixel3](https://github.com/tsutarou10/silver-rack-sandbox/blob/feature/practice-flutter/miyazaki/practice-flutter/img/pixel3.png?raw=true)
