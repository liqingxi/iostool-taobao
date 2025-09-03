TARGET := iphone:clang:latest:14.0
THEOS_DEVICE_IP=iphone
THEOS_DEVICE_PORT=2222
THEOS_PACKAGE_SCHEME=roothide

include $(THEOS)/makefiles/common.mk

TOOL_NAME = tbauto

tbauto_FILES = main.m
tbauto_FILES += tool/BAAppTool.m
tbauto_CFLAGS = -fobjc-arc
tbauto_CODESIGN_FLAGS = -Sentitlements.plist
tbauto_INSTALL_PATH = /usr/local/bin

include $(THEOS_MAKE_PATH)/tool.mk
