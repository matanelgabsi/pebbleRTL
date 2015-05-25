THEOS_PLATFORM_SDK_ROOT = /Applications/Xcode.app/Contents/Developer
SDKVERSION = 8.3
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 7.0
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = PebbleRTL
PebbleRTL_FILES = Tweak.xm bidi.mm logging.mm
PebbleRTL_FRAMEWORKS = UIKit CoreBluetooth CoreFoundation Foundation
PebbleRTL_LIBRARIES = icucore
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "launchctl stop com.apple.BTLEServer; sleep 5; killall -9 BTLEServer; launchctl start com.apple.BTLEServer"
	#install.exec "reboot"
