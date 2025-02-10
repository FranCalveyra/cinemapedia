# cinemapedia

A movie finder mobile application.

## For developers
1. Copy the `.env.template` file, add your own variables and then rename it to `.env`.
2. Whenever making changes on any entity (which should be annotated as a `@collection`), run the following command:

```bash
flutter pub run build_runner build
```

## For Production
Change the app name for both platforms:
```bash
dart run change_app_package_name:main com.new.package.name
```

Only for Android:
```bash
dart run change_app_package_name:main com.new.package.name --android
```

And only for iOS:
```bash
dart run change_app_package_name:main com.new.package.name --ios
```
