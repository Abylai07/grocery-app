get:
	flutter pub get

clean:
	flutter clean

cleanget:
	make clean
	make get

generate:
	flutter pub run build_runner build --delete-conflicting-outputs

intl:
	flutter pub run intl_utils:generate

# Android
releaseApk:
	flutter build apk --release

releaseAab:
	make cleanget
	flutter build appbundle --release

# iOS
releaseIos:
	flutter build ios --release

releaseIpa:
	make cleanget
	flutter build ipa --release

xcode:
	open ios/Runner.xcworkspace

removeCache:
	rm -R ~/Library/Developer/CoreSimulator/Caches
