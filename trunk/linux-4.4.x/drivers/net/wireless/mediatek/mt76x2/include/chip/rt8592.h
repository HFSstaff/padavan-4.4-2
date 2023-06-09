/****************************************************************************
 * Ralink Tech Inc.
 * 4F, No. 2 Technology 5th Rd.
 * Science-based Industrial Park
 * Hsin-chu, Taiwan, R.O.C.
 * (c) Copyright 2002, Ralink Technology, Inc.
 *
 * All rights reserved. Ralink's source code is an unpublished work and the
 * use of a copyright notice does not imply otherwise. This source code
 * contains confidential trade secret material of Ralink Tech. Any attemp
 * or participation in deciphering, decoding, reverse engineering or in any
 * way altering the source code is stricitly prohibited, unless the prior
 * written consent of Ralink Technology, Inc. is obtained.
 ****************************************************************************

    Module Name:
	rt8592.h

    Abstract:

    Revision History:
    Who          When          What
    ---------    ----------    ----------------------------------------------
 */

#ifndef __RT8592_H__
#define __RT8592_H__

struct _RTMP_ADAPTER;


/* 
 * Frequency plan item  for RT85592 
 * N: R9[4], R8[7:0]
 * K: R7[7], R9[3:0]
 * mod: R9[7:5], R11[3:2] (eg. mod=8 => 0x0, mod=10 => 0x2)
 * R: R11[1:0] (eg. R=1 => 0x0, R=3 => 0x2)
 */
typedef struct _RT8592_FREQ_ITEM {
	UINT8 Channel;
	UINT16 N;
	UINT8 K;
	UINT8 mod;
	UINT8 R;
} RT8592_FREQ_ITEM;


#ifdef RT8592
VOID RT85592_Init(struct _RTMP_ADAPTER *pAd);
INT RT85592_DisableTxRx(struct _RTMP_ADAPTER *pAd, UCHAR Level);
VOID RT85592ReadTxPwrPerRate(struct _RTMP_ADAPTER *pAd);
INT RT85592_ReadChannelPwr(struct _RTMP_ADAPTER *pAd);


#ifdef RTMP_TEMPERATURE_COMPENSATION
INT rx_temp_compensation(struct _RTMP_ADAPTER *pAd);
#endif /* RTMP_TEMPERATURE_COMPENSATION */

INT bw_filter_cal(struct _RTMP_ADAPTER *pAd);

INT rt85592_lna_gain_adjust(struct _RTMP_ADAPTER *pAd, CHAR gain);
#ifndef WFA_VHT_PF
INT rt85592_cca_adjust(struct _RTMP_ADAPTER *pAd);
#endif /* WFA_VHT_PF */

#endif /* RT8592 */

#endif /* __RT8592_H__ */

