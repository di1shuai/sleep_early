package main

import (
	platform_device_id "github.com/BestBurning/platform_device_id/go"
	shutdown_platform "github.com/BestBurning/shutdown_platform/go"
	"github.com/go-flutter-desktop/go-flutter"
	"github.com/go-flutter-desktop/plugins/shared_preferences"
	"github.com/go-flutter-desktop/plugins/url_launcher"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(480, 660),
	flutter.AddPlugin(&shutdown_platform.ShutdownPlatformPlugin{}),
	flutter.AddPlugin(&platform_device_id.PlatformDeviceIdPlugin{}),
	flutter.AddPlugin(&shared_preferences.SharedPreferencesPlugin{
		VendorName:      "di1shuai",
		ApplicationName: "SleepEarly",
	}),
	flutter.AddPlugin(&url_launcher.UrlLauncherPlugin{}),
}
