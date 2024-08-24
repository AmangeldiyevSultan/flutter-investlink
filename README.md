# Investlink

InvestLink project.

## Getting Started

## InvestLink initialization

Do the following to initialize a project:

```sh
fvm use <flutter_version>
make codegen
```

If FVM is not installed, check [FVM workflow](#fvm-workflow).

4. Specify the Flutter version used in the project [here](#flutter-and-dart-fvm-versions-of-the-project).

### Settings

Project line length: 100 characters.

### Dependencies

Run this command to get up-to-date versions of dependencies:

````sh
fvm flutter pub get --enforce-lockfile

## Flutter Version Management (FVM)

### Flutter and Dart FVM versions of the project

> [!IMPORTANT]
> Change Flutter and Dart versions below and delete this alert.

Flutter: **_3.24.0_** / Dart SDK: **_3.5.0_**

### FVM workflow

The project uses [FVM](https://fvm.app/) for Flutter version management.
Installation and IDE configuration for working with FVM are described [here](https://fvm.app/docs/getting_started/installation/) and [here](https://fvm.app/docs/getting_started/configuration).

For installation the project version of Flutter, run the command:

```sh
fvm install
````

For VSCode IDE you can also run the script [`fvm_vscode.sh`](scripts/fvm_vscode.sh):

```sh
sh scripts/fvm_vscode.sh
```

You need to use `fvm flutter ...` everywhere instead of just `flutter ...` when working with the project.

## Code generation

Basic command for code generation:

```sh
fvm flutter pub run build_runner build --delete-conflicting-outputs
```

## Project scripts

All scripts are located in the [scripts](scripts) folder and described [here](docs/scripts.md).

### Flavors

The project has two flavors: `dev` and `prod`. The `dev` flavor is used by default.
The guide to adding flavors can be found [here](docs/flavors.md).

There are cases when you need to add different functionality for `dev` and `qa` mode. For example, if you need different logging or feature-toggle options. Then you can add the `qa` mode to the `enum BuildType` and create a `main_qa.dart` file with the `main()` function in the `lib/` folder. For example:

```dart
void main() {
  run(const Environment(buildType: BuildType.dev));
}
```

## DI

[Provider](https://pub.dev/packages/provider).

Dependencies are grouped into container entities with an interface describing a set of dependencies supplied. This entity is, in turn, supplied to a functionality with a [DiScope](./lib/features/common/widgets/di_scope/di_scope.dart) widget, which is used as a wrapper for a corresponding functionality.

For example, [AppScope](./lib/features/app/di/app_scope.dart) is the base entity for the entire app. It contains dependencies that function through the entire lifecycle of the app. We wrap the whole app in the DiScope and pass a factory that returns the AppScope.
If a functionality needs some dependencies specific to it only, they are isolated into a separate entity, which is to be wrapped around the functionality.
