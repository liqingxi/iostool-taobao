TARGET := iphone:clang:16.5:14.0
THEOS_DEVICE_IP=iphone
THEOS_DEVICE_PORT=2222
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME=roothide


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = springboardhook

springboardhook_FILES = Tweak.x
springboardhook_CFLAGS = -fobjc-arc
springboardhook_PRIVATE_FRAMEWORKS = SpringBoard

include $(THEOS_MAKE_PATH)/tweak.mk
