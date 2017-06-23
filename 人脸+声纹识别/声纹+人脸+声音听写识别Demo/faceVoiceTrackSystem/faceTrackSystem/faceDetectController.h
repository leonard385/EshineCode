//
//  ViewController.h
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^getFacePicture)(UIImage *faceImage);
@interface faceDetectController : UIViewController
@property(nonatomic,copy)getFacePicture getFacePictureBlock;
-(void)setGetFacePictureBlock:(getFacePicture)getFacePictureBlock;
@end

