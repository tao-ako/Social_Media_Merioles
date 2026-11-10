# TikTokTok

A Flutter social app demo with a validated login, profile and friends grid,
efficiently scrolling posts, and locally saved post comments.

## Run

```shell
flutter pub get
flutter run
```

Any non-empty username and password will open the profile. Post images are
bundled in `assets/`. New comments are saved on the device and remain available
after closing and reopening the app.

## Test

```shell
flutter analyze
flutter test
```

The app entry point is `lib/main.dart`. Models, login, and view components are
organized into separate directories under `lib/`.
