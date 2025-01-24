# cinemapedia

A movie finder mobile application.

## For developers
1. Copy the `.env.template` file, add your own variables and then rename it to `.env`.
2. Whenever making changes on any entity (which should be annotated as a `@collection`), run the following command:

```bash
flutter pub run build_runner build
```

