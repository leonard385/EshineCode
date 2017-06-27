//
//  WFPhotosViewController.h
//  WFPhotoPicker
//
//  Created by 赚发2 on 16/9/2.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WFPhotosViewControllerTailoredImageBlock)(UIImage *imgae);

@interface WFPhotosViewController : UIViewController

@property (nonatomic, copy) WFPhotosViewControllerTailoredImageBlock tailoredImage;

@end
