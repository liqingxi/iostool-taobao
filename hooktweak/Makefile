TARGET := iphone:clang:latest:14.0
THEOS_DEVICE_IP=iphone
THEOS_DEVICE_PORT=2222
THEOS_PACKAGE_SCHEME=roothide

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = testtweak

ARCHS = arm64

# testtweak_FILES = Tweak.x
testtweak_FILES = Tweak.m

testtweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
