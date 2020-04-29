# mahjong matching app

A app to find or recruit Mahjong friends.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## How to build

### ios
0. you should fork this repository

1. clone
    ```
    $ git clone git@github.com:{your_account_name}/silver-rack-sandbox.git
    or
    $ git clone https://github.com/{your_accout_name}/silver-rack-sandbox.git
    ```

2. change directory
    ```
    $ cd silver-rack-sandbox/mahjong-matching-app/mahjong_matching_app_project
      ```

3. download and set `GoogleServiceInfo.plist` to use firebase

    0. you should choose ENV(dev/qas/prd) you want to set.
    1. access firebase https://firebase.google.com/
    2. login using account of silver-rack and choose firebase project
        - Notice: firebase projects are divided due to staging
        - ex.) If ENV is dev, you should choose `mahjong-app-dev`
    3. open Settings of app named `mahjong matching app` in project you choose.
    4. download `GoogleService-Info.plist` as `GoogleService-Ingo-{ENV}.plist`
        - ex.) If ENV is dev, you should name `GoogleServiceInfo-dev.plist`
    5. move `GoogleService-Ingo-{ENV}.plist` to `ios/Runner/`
        ```
        ios/Runner
          └── GoogleService-Info-dev.plist
        ```

4. deploy
    ```
    $ ./deploy_ios.sh ${BUILD_TYPE} ${ENV}
    ```

    For example, if you execute bellow command,
        ```
        $ ./deploy_ios.sh debug dev
        ```

    you can deploy mahjong matching app to dev staging using debug mode.

    (default value of BUILD_TYPE and ENV are "debug" and "dev", respectively.)

5. execute

    Notice: It is necessary to start up the simulator or real iOS device.
    ```
    $ flutter run
    ```

### android
0. you should fork this repository

1. clone
    ```
    $ git clone git@github.com:{your_account_name}/silver-rack-sandbox.git
    or
    $ git clone https://github.com/{your_accout_name}/silver-rack-sandbox.git
    ```

2. change directory
    ```
    $ cd silver-rack-sandbox/mahjong-matching-app/mahjong_matching_app_project
      ```

3. download and set `google-services.json` to use firebase
    0. you should choose ENV(dev/qas/prd) you want to set.
    1. access firebase https://firebase.google.com/
    2. login using account of silver-rack and choose firebase project
        - Notice: firebase projects are divided due to staging
        - ex.) If ENV is dev, you should choose `mahjong-app-dev`
    3. open Settings of app named `mahjong matching app` in project you choose.
    4. download `google-services.json`
    5. move `google-services.json` to `android/app/src/{ENV}`
    6. place keystore in android/keystore
    7. place config files in android/app/signingConfigs
        - NOTICE: Not released on github due to confidential information
        ```
        android
        ├── app
        │   ├── signingConfigs
        │   │   ├── develop.gradle
        │   │   └── release.gradle
        │   └── src
        │       ├── dev
        │       │   └── google-services.json
        │       └── qas
        │           └── google-services.json
        └── keystore
             ├── debug.keystore
             └── release.keystore
        ```
    8. deploy
        ```
        $ ./deploy_android.sh ${BUILD_TYPE} ${ENV}
        ```

        For example, if you execute bellow command,
            ```
            $ ./deploy_android.sh debug dev
            ```

        you can deploy mahjong matching app to dev staging using debug mode.

        (default value of BUILD_TYPE and ENV are "debug" and "dev", respectively.)

    9. execute
        ```
        $ flutter run --flavor {ENV}
        ```

### Correspondence table of BUILD_TYPE and ENV
| BUILD_TYPE | ENV | Prepared |
| --- | --- | --- |
| debug | dev | already |
| release | qas | not yet |
| release | prd | not yet |
