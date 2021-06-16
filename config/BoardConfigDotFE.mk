include vendor/dotfe/config/BoardConfigKernel.mk

ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
include vendor/dotfe/config/BoardConfigQcom.mk
endif

# Gapps
ifeq ($(WITH_GAPPS),true)
include vendor/gms/products/board.mk
endif

include vendor/dotfe/config/BoardConfigSoong.mk
