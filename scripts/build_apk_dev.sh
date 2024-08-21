#!/usr/bin/env bash

if [ "$(basename "$PWD")" = 'scripts' ]; then cd ..; fi

fvm flutter clean && 
fvm flutter pub get && 
fvm flutter build apk --release --target lib/main_dev.dart