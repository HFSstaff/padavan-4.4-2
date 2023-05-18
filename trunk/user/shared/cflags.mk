
##################################################################
# Linux kernel .config related params
##################################################################

CFLAGS += $(if $(CONFIG_SMP),-DUSE_SMP,)
CFLAGS += $(if $(CONFIG_IPV6),-DUSE_IPV6,)
CFLAGS += $(if $(CONFIG_XFRM),-DUSE_XFRM,)
CFLAGS += $(if $(CONFIG_RTL8367_MCM_WAN_PORT),-DUSE_GMAC2_TO_GSW,)
CFLAGS += $(if $(CONFIG_GE2_INTERNAL_GPHY_P0)$(CONFIG_GE2_INTERNAL_GPHY_P4)$(CONFIG_GE2_RGMII_AN),-DUSE_GMAC2_TO_GPHY,)
CFLAGS += $(if $(CONFIG_RT2860V2_AP),-DUSE_RT2860V2_AP,)
CFLAGS += $(if $(CONFIG_RT3090_AP),-DUSE_RT3090_AP,)
CFLAGS += $(if $(CONFIG_RT5392_AP),-DUSE_RT5392_AP,)
CFLAGS += $(if $(CONFIG_RT5592_AP),-DUSE_RT5592_AP,)
CFLAGS += $(if $(CONFIG_RT3593_AP),-DUSE_RT3593_AP,)
CFLAGS += $(if $(CONFIG_MT7610_AP),-DUSE_MT7610_AP,)
CFLAGS += $(if $(CONFIG_MT76X2_AP),-DUSE_MT76X2_AP,)
CFLAGS += $(if $(CONFIG_MT76X3_AP),-DUSE_MT76X3_AP,)
CFLAGS += $(if $(CONFIG_MT7615_AP),-DUSE_MT7615_AP,)
CFLAGS += $(if $(CONFIG_MT7915_AP),-DUSE_MT7915_AP,)
CFLAGS += $(if $(CONFIG_MT7628_AP),-DUSE_MT7628_AP,)
CFLAGS += $(if $(CONFIG_RT3352_INIC_MII),-DUSE_RT3352_MII,)
CFLAGS += $(if $(CONFIG_RT_WSC),-DUSE_WSC_WPS,)
CFLAGS += $(if $(CONFIG_RT_IGMP_SNOOP),-DUSE_IGMP_SNOOP,)
CFLAGS += $(if $(CONFIG_IGMP_SNOOP_SUPPORT),-DUSE_IGMP_SNOOP,)
CFLAGS += -DUSE_HW_NAT
CFLAGS += -DUSE_IPV6_HW_NAT
CFLAGS += $(if $(CONFIG_RA_HW_NAT_PCI),-DUSE_WWAN_HW_NAT,)
CFLAGS += $(if $(CONFIG_HNAT_V2),-DUSE_HW_NAT_V2,)
CFLAGS += $(if $(CONFIG_MTD_NAND_MTK)$(CONFIG_MTD_NAND_RALINK),-DUSE_NAND_FLASH,)
CFLAGS += $(if $(CONFIG_NETFILTER_XT_MATCH_CONNTRACK),-DUSE_MATCH_CONNTRACK,)
CFLAGS += $(if $(CONFIG_USB_XHCI_HCD),-DUSE_USB_XHCI,)
CFLAGS += $(if $(CONFIG_MMC_MT7621),-DUSE_MTK_MMC,)

ifdef CONFIG_RALINK_MT7621
CFLAGS += -DCONFIG_RALINK_MT7621
endif

ifdef CONFIG_RAETH
CFLAGS += -DUSE_MTK_GSW
endif

ifndef CONFIG_FIRST_IF_NONE
ifdef CONFIG_DBDC_MODE
ifdef CONFIG_FIRST_IF_MT7615E
CFLAGS += -DUSE_WID_2G=7615
CFLAGS += -DUSE_WID_5G=7615
else
ifdef CONFIG_FIRST_IF_MT7915
CFLAGS += -DUSE_WID_2G=7915
CFLAGS += -DUSE_WID_5G=7915
endif # CONFIG_FIRST_IF_MT7915
endif # CONFIG_FIRST_IF_MT7615E
else # ! CONFIG_DBDC_MODE
CFLAGS += -DUSE_WID_2G=$(CONFIG_RT_FIRST_CARD)
CFLAGS += -DUSE_WID_5G=$(CONFIG_RT_SECOND_CARD)
endif # CONFIG_DBDC_MODE
endif # CONFIG_FIRST_IF_NONE

##################################################################
# Project .config related params
##################################################################

CFLAGS += $(if $(FIRMWARE_BUILDS_VER),-DFWBLDSTR=\"$(FIRMWARE_BUILDS_VER)\",)
CFLAGS += $(if $(FIRMWARE_BUILDS_REV),-DFWREVSTR=\"$(FIRMWARE_BUILDS_REV)\",)

ifdef CONFIG_MMC_BLOCK
CFLAGS += -DUSE_MMC_SUPPORT
endif

ifdef CONFIG_ATA
CFLAGS += -DUSE_ATA_SUPPORT
endif

ifdef CONFIG_BLK_DEV_SD
CFLAGS += -DUSE_BLK_DEV_SD
ifeq ($(CONFIG_FIRMWARE_INCLUDE_HDPARM),y)
CFLAGS += -DUTL_HDPARM
endif
endif

ifeq ($(STORAGE_ENABLED),y)
CFLAGS += -DUSE_STORAGE
ifeq ($(CONFIG_FIRMWARE_INCLUDE_FTPD),y)
CFLAGS += -DAPP_FTPD
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMBD),y)
CFLAGS += -DAPP_SMBD
CFLAGS += -DAPP_SMBD36
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_NFSD),y)
CFLAGS += -DAPP_NFSD
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_MINIDLNA),y)
CFLAGS += -DAPP_MINIDLNA
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_FIREFLY),y)
CFLAGS += -DAPP_FIREFLY
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_TRANSMISSION),y)
CFLAGS += -DAPP_TRMD
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_ARIA),y)
CFLAGS += -DAPP_ARIA
endif
endif

ifneq ($(BOARD_NUM_USB_PORTS),0)
CFLAGS += -DUSE_USB_SUPPORT
ifeq ($(CONFIG_FIRMWARE_INCLUDE_LPRD),y)
CFLAGS += -DSRV_LPRD
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_U2EC),y)
CFLAGS += -DSRV_U2EC
endif
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_WINS),y)
CFLAGS += -DAPP_NMBD
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_OPENVPN),y)
CFLAGS += -DAPP_OPENVPN
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SSWAN),y)
CFLAGS += -DAPP_SSWAN
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_XUPNPD),y)
CFLAGS += -DAPP_XUPNPD
endif

ifneq ($(CONFIG_FIRMWARE_INCLUDE_OPENSSH),y)
ifeq ($(CONFIG_FIRMWARE_INCLUDE_DROPBEAR),y)
CFLAGS += -DAPP_SSHD
endif
else
CFLAGS += -DAPP_SSHD
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_RPL2TP),y)
CFLAGS += -DAPP_RPL2TP
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_FTPD_SSL),y)
CFLAGS += -DSUPPORT_FTPD_SSL
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_EAP_PEAP),y)
CFLAGS += -DSUPPORT_PEAP_SSL
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_HTTPS),y)
CFLAGS += -DSUPPORT_HTTPS
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SCUTCLIENT),y)
CFLAGS += -DAPP_SCUT
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_MENTOHUST),y)
CFLAGS += -DAPP_MENTOHUST
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_TTYD),y)
CFLAGS += -DAPP_TTYD
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_VLMCSD),y)
CFLAGS += -DAPP_VLMCSD
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_DNSFORWARDER),y)
CFLAGS += -DAPP_DNSFORWARDER
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS),y)
CFLAGS += -DAPP_SHADOWSOCKS
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMARTDNS),y)
CFLAGS += -DAPP_SMARTDNS
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_ALIDDNS),y)
CFLAGS += -DAPP_ALIDDNS
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_ADBYBY),y)
CFLAGS += -DAPP_ADBYBY
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_ADGUARDHOME),y)
CFLAGS += -DAPP_ADGUARDHOME
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_ZEROTIER),y)
CFLAGS += -DAPP_ZEROTIER
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_DDNSTO),y)
CFLAGS += -DAPP_DDNSTO
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_WIREGUARD),y)
CFLAGS += -DAPP_WIREGUARD
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SMARTDNS),y)
CFLAGS += -DAPP_SMARTDNS
endif

ifneq ($(CONFIG_FIRMWARE_INCLUDE_FRPC),y)
ifeq ($(CONFIG_FIRMWARE_INCLUDE_FRPS),y)
CFLAGS += -DAPP_FRP
endif
else
CFLAGS += -DAPP_FRP
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SQM),y)
CFLAGS += -DAPP_SQM
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_ALDRIVER),y)
CFLAGS += -DAPP_ALDRIVER
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_xTUN),y)
CFLAGS += -DAPP_XTUN
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_SERVER),y)
CFLAGS += -DAPP_VPNSVR
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SOFTETHERVPN_CLIENT),y)
CFLAGS += -DAPP_VPNCLI
endif

ifeq ($(CONFIG_WITHOUT_KERNEL),y)
CFLAGS += -DWITHOUT_KERNEL
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_SFE),y)
CFLAGS += -DUSE_SFE
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_IPSET),y)
CFLAGS += -DUSE_IPSET
endif

ifeq ($(CONFIG_FIRMWARE_INCLUDE_OPENSSL_EC),y)
CFLAGS += -DSUPPORT_OPENSSL_EC
endif

ifeq ($(CONFIG_32M_REBOOT_FIXUP),y)
CFLAGS += -DMTD_FLASH_32M_REBOOT_BUG
endif
