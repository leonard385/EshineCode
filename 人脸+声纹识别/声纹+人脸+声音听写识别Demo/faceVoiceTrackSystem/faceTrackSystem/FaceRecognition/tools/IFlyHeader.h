//
//  IFlyHeader.h
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#ifndef IFlyHeader_h
#define IFlyHeader_h
#define MAX_IMAGEPIX_WIDTH 800.0f          // max pix 400.0px
#define MAX_IMAGEPIX_HEIGHT 600.0f          // max pix 400.0px
#define MAX_IMAGEDATA_LEN 30000.0f   // max data length 30K


#define PWDT_FIXED_CODE  1     //固定密码
#define PWDT_NUM_CODE    3     //数字密码

#pragma  key of isv
#define  KEY_PTXT           @"ptxt"
#define  KEY_RGN            @"rgn"
#define  KEY_TSD            @"tsd"
#define  KEY_SUB            @"sub"
#define  KEY_PWDT           @"pwdt"
#define  KEY_TAIL           @"vad_speech_tail"
#define  KEY_AUTHID         @"auth_id"
#define  KEY_SST            @"sst"
#define  KEY_KEYTIMEOUT     @"key_speech_timeout"
#define  KEY_VADTIMEOUT     @"vad_timeout"

#pragma mark value of key
#define  TRAIN_SST          @"train"
#define  VERIFY_SST         @"verify"


#pragma mark del or query
#define  DEL                @"del"
#define  QUERY              @"que"

#endif /* IFlyHeader_h */
