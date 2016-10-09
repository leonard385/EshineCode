//
//  ZHCMessage+ServiceModel.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "ZHCMessage.h"
#import "ZHUseFDModel.h"
@interface ZHCMessage (ServiceModel)
+(ZHCMessage *)UIModelFromZHUseFDModel:(ZHUseFDModel *)Model;
@end
