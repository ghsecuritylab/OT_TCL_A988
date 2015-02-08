##### CLEAR VARS

DRV_CFLAGS =
DRV_WPA_CFLAGS =
DRV_AP_CFLAGS =
DRV_OBJS =
DRV_WPA_OBJS =
DRV_AP_OBJS =
DRV_LIBS =
DRV_WPA_LIBS =
DRV_AP_LIBS =

##### COMMON DRIVERS
ifdef CONFIG_DRIVER_AR6003
DRV_CFLAGS += -DCONFIG_DRIVER_AR6003
DRV_OBJS +=  src/drivers/driver_ar6003.c
CONFIG_L2_PACKET=linux
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
CONFIG_WIRELESS_EXTENSION=y
endif

ifdef CONFIG_DRIVER_HOSTAP
DRV_CFLAGS += -DCONFIG_DRIVER_HOSTAP
DRV_OBJS += src/drivers/driver_hostap.c
CONFIG_WIRELESS_EXTENSION=y
NEED_AP_MLME=y
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
endif

ifdef CONFIG_DRIVER_WIRED
DRV_CFLAGS += -DCONFIG_DRIVER_WIRED
DRV_OBJS += src/drivers/driver_wired.c
endif

ifdef CONFIG_DRIVER_MADWIFI
DRV_CFLAGS += -DCONFIG_DRIVER_MADWIFI
DRV_OBJS += src/drivers/driver_madwifi.c
CONFIG_WIRELESS_EXTENSION=y
CONFIG_L2_PACKET=linux
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
endif

ifdef CONFIG_DRIVER_NL80211
DRV_CFLAGS += -DCONFIG_DRIVER_NL80211
DRV_OBJS += src/drivers/driver_nl80211.c
DRV_OBJS += src/utils/radiotap.c
NEED_SME=y
NEED_AP_MLME=y
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
NEED_RFKILL=y
ifdef CONFIG_LIBNL_TINY
DRV_LIBS += -lnl-tiny
else
DRV_LIBS += -lnl
endif

ifdef CONFIG_LIBNL20
DRV_LIBS += -lnl-genl
DRV_CFLAGS += -DCONFIG_LIBNL20
endif
endif

ifdef CONFIG_DRIVER_BSD
ifndef CONFIG_L2_PACKET
CONFIG_L2_PACKET=freebsd
endif
DRV_CFLAGS += -DCONFIG_DRIVER_BSD
DRV_OBJS += src/drivers/driver_bsd.c
CONFIG_L2_FREEBSD=y
CONFIG_DNET_PCAP=y
endif

ifdef CONFIG_DRIVER_TEST
DRV_CFLAGS += -DCONFIG_DRIVER_TEST
DRV_OBJS += src/drivers/driver_test.c
NEED_AP_MLME=y
endif

ifdef CONFIG_DRIVER_NONE
DRV_CFLAGS += -DCONFIG_DRIVER_NONE
DRV_OBJS += src/drivers/driver_none.c
endif

##### PURE AP DRIVERS

ifdef CONFIG_DRIVER_ATHEROS
DRV_AP_CFLAGS += -DCONFIG_DRIVER_ATHEROS
DRV_AP_OBJS += src/drivers/driver_atheros.c
CONFIG_L2_PACKET=linux
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
endif

##### PURE CLIENT DRIVERS

ifdef CONFIG_DRIVER_WEXT
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_WEXT
CONFIG_WIRELESS_EXTENSION=y
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
NEED_RFKILL=y
endif

ifdef CONFIG_DRIVER_RALINK
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_RALINK
DRV_WPA_OBJS += src/drivers/driver_ralink.c
NEED_NETLINK=y
NEED_LINUX_IOCTL=y
endif

ifdef CONFIG_DRIVER_BROADCOM
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_BROADCOM
DRV_WPA_OBJS += src/drivers/driver_broadcom.c
endif

ifdef CONFIG_DRIVER_NDIS
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_NDIS
DRV_WPA_OBJS += src/drivers/driver_ndis.c
ifdef CONFIG_NDIS_EVENTS_INTEGRATED
DRV_WPA_OBJS += src/drivers/driver_ndis_.c
endif
ifndef CONFIG_L2_PACKET
CONFIG_L2_PACKET=pcap
endif
CONFIG_WINPCAP=y
ifdef CONFIG_USE_NDISUIO
DRV_WPA_CFLAGS += -DCONFIG_USE_NDISUIO
endif
endif

ifdef CONFIG_DRIVER_OSX
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_OSX
DRV_WPA_OBJS += src/drivers/driver_osx.c
DRV_WPA_LDFLAGS += -framework CoreFoundation
DRV_WPA_LDFLAGS += -F/System/Library/PrivateFrameworks -framework Apple80211
endif

ifdef CONFIG_DRIVER_IPHONE
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_IPHONE
DRV_WPA_OBJS += src/drivers/driver_iphone.c
DRV_WPA_OBJS += src/drivers/MobileApple80211.c
DRV_WPA_LDFLAGS += -framework CoreFoundation
endif

ifdef CONFIG_DRIVER_ROBOSWITCH
DRV_WPA_CFLAGS += -DCONFIG_DRIVER_ROBOSWITCH
DRV_WPA_OBJS += src/drivers/driver_roboswitch.c
endif

ifdef CONFIG_WIRELESS_EXTENSION
DRV_WPA_CFLAGS += -DCONFIG_WIRELESS_EXTENSION
DRV_WPA_OBJS += src/drivers/driver_wext.c
NEED_RFKILL=y
endif

ifdef NEED_NETLINK
DRV_OBJS += src/drivers/netlink.c
endif

ifdef NEED_LINUX_IOCTL
DRV_OBJS += src/drivers/linux_ioctl.c
endif

ifdef NEED_RFKILL
DRV_OBJS += src/drivers/rfkill.c
endif

ifdef CONFIG_DRIVER_CUSTOM
DRV_CFLAGS += -DCONFIG_DRIVER_CUSTOM
endif

##### COMMON VARS
DRV_BOTH_CFLAGS := $(DRV_CFLAGS) $(DRV_WPA_CFLAGS) $(DRV_AP_CFLAGS)
DRV_WPA_CFLAGS += $(DRV_CFLAGS)
DRV_AP_CFLAGS += $(DRV_CFLAGS)

DRV_BOTH_LIBS := $(DRV_LIBS) $(DRV_WPA_LIBS) $(DRV_AP_LIBS)
DRV_WPA_LIBS += $(DRV_LIBS)
DRV_AP_LIBS += $(DRV_LIBS)

DRV_BOTH_OBJS := $(DRV_OBJS) $(DRV_WPA_OBJS) $(DRV_AP_OBJS)
DRV_WPA_OBJS += $(DRV_OBJS)
DRV_AP_OBJS += $(DRV_OBJS)

DRV_BOTH_LDFLAGS := $(DRV_LDFLAGS) $(DRV_WPA_LDFLAGS) $(DRV_AP_LDFLAGS)
DRV_WPA_LDFLAGS += $(DRV_LDFLAGS)
DRV_AP_LDFLAGS += $(DRV_LDFLAGS)