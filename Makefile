THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
ARCHS = armv7 arm64
TARGET = iphone:14.5:8.0  # 明确SDK版本

BUNDLE_NAME = com.swiftyper.wechatredenvelop
com.swiftyper.wechatredenvelop_INSTALL_PATH = /Library/MobileSubstrate/DynamicLibraries

include $(THEOS)/makefiles/common.mk
include $(THEOS)/makefiles/bundle.mk

SRC = $(wildcard src/*.m)

TWEAK_NAME = WeChatRedEnvelop
WeChatRedEnvelop_FILES = $(wildcard src/*.m) src/Tweak.xm
WeChatRedEnvelop_FRAMEWORKS = UIKit Foundation CoreGraphics  # 补充常用框架
# 如需私有框架，添加以下行（示例）：
# WeChatRedEnvelop_PRIVATE_FRAMEWORKS = ChatKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
