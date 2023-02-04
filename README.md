# Little Help Book Flutter App

This is a new cross-platform application built with Flutter. The purpose of this project is to share free and affordable resources in the Eugene-Springfield metropolitan and Lane County areas for underserved populations. The collection of services and service providers has been maintained by [White Bird Clinic](white_bird_clinic).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Tools

### Build Runner

Incremental code generation supports clean development of classes and union types through [Freezed](freezed), as well as facilitates the [Riverpod](riverpod) annotations for state providers.

```sh
flutter pub run build_runner build --delete-conflicting-outputs
```

### Dependency Sorter

Run this command after making any changes to the `pubspec.yaml` file to maintain consitency and organization by sorting the packages.

```sh
flutter pub run pubspec_dependency_sorter
```

[freezed]: https://pub.dev/packages/freezed
[riverpod]: https://docs-v2.riverpod.dev/docs/introduction
[white_bird_clinic]: https://whitebirdclinic.org/
