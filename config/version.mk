# Copyright (C) 2018-20 Project dotOS
# Copyright (C) 2021 Project dotOS-FE (Fan Edition)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#dotOS Fan Edition Versioning :
DOTFE_MOD_VERSION = v1.1

ifndef DOTFE_BUILD_TYPE
    DOTFE_BUILD_TYPE := Community
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

DOTFE_BUILD_DATE_UTC := $(shell date -u '+%Y%m%d-%H%M')

ifeq ($(DOTFE_OFFICIAL), true)
   LIST = $(shell cat vendor/dotfe/dotfe.devices)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      DOTFE_BUILD_TYPE := OFFICIAL
      ifeq ($(WITH_GAPPS), true)
	DOTFE_BUILD_TYPE := GAPPS
      endif
    endif
    ifneq ($(IS_OFFICIAL), true)
       DOTFE_BUILD_TYPE := Community
       ifeq ($(WITH_GAPPS), true)
	 DOTFE_BUILD_TYPE := Community_GAPPS
       endif
       $(error Device is not official "$(FOUND)")
    endif

endif

TARGET_PRODUCT_SHORT := $(subst dotfe_,,$(DOTFE_BUILD))

DOTFE_VERSION := dotOS-FanEdition-R-$(DOTFE_MOD_VERSION)-$(CURRENT_DEVICE)-$(DOTFE_BUILD_TYPE)-$(DOTFE_BUILD_DATE_UTC)

DOTFE_FINGERPRINT := dotOS-FanEdition/$(DOTFE_MOD_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(DOTFE_BUILD_DATE_UTC)

PRODUCT_GENERIC_PROPERTIES += \
  ro.dotfe.version=$(DOTFE_VERSION) \
  ro.dotfe.releasetype=$(DOTFE_BUILD_TYPE) \
  ro.modversion=$(DOTFE_MOD_VERSION)

DOTFE_DISPLAY_VERSION := DotOS-FanEditon-$(DOTFE_MOD_VERSION)-$(DOTFE_BUILD_TYPE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.dotfe.display.version=$(DOTFE_DISPLAY_VERSION)\
  ro.dotfe.fingerprint=$(DOTFE_FINGERPRINT)
