# pioneer_vsx_remote_control

A Flutter project to build a Pioneer VSX-924 android remote control app

## Getting Started

To configure the Pioneer VSX-924 endpoints, you need to update the `assets/config.json` file.

Each button has a name and an endpoint.

You can then map it in the `remote_control.dart` file.

## build

To build the apk you need to install flutter and run the following command:

```bash
flutter build apk
```

I never tryed to build it for ios or windows..

## Learn More

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
