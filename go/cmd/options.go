package main

import (
	shutdown_platform "github.com/BestBurning/shutdown_platform/go"
	"github.com/go-flutter-desktop/go-flutter"
)

var options = []flutter.Option{
	flutter.WindowInitialDimensions(480, 660),
	flutter.AddPlugin(&shutdown_platform.ShutdownPlatformPlugin),
}
