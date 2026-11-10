# TikTokTok

A Flutter social app demo with a validated login, profile and friends grid,
scrollable posts, and post comments.

## Run

```shell
flutter pub get
flutter run
```

Any non-empty username and password will open the profile. Post images are
bundled in `assets/`.

## Test

```shell
flutter analyze
flutter test
```

The app entry point is `lib/main.dart`. Models, login, and view components are
organized into separate directories under `lib/`.
