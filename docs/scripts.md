# Scripts

To run scripts, we use a Makefile. To execute a script in the project's root directory, open your terminal and enter the command.

For example, the command `make all` will display a list of available commands to run.

```shell
make all

# Available tasks:
# - init_app: flutter clean, clean_ios, pub get, pub run build_runner, dart format -l 120
# - clean_ios: Clears local dependencies for iOS.
# - fvm_vscode: The script creates (or overwrites, if it already exists) a settings file for Visual Studio Code with a specific set of FVM parameters.
# - version: Installing the desired version of fvm and run pub get
# - codegen: build_runner build & dart format
```

## init_app.sh

It starts before the first start. Does:

- flutter clean
- clean_ios
- flutter pub get
- flutter pub run build_runner
- dart format -l 120 lib test

## clean_ios.sh

Clears local dependencies for iOS.

## fvm_vscode.sh

The script creates (or overwrites, if it already exists) a settings file for Visual Studio Code with
a specific set of FVM parameters.

## build_runner.sh

build_runner build & dart format
