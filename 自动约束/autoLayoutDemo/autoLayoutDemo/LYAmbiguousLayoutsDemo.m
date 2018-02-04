//
//  LYAmbiguousLayoutsDemo.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/28.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYAmbiguousLayoutsDemo.h"

@interface LYAmbiguousLayoutsDemo ()
@property (weak, nonatomic) IBOutlet UIView *viewGreen;
@property (weak, nonatomic) IBOutlet UIView *viewPurle;
@property (weak, nonatomic) IBOutlet UIView *viewRed;

@end

@implementation LYAmbiguousLayoutsDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self DetectAmbigousLayout];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(exerciseAmbiguityInLayoutDemo) withObject:nil afterDelay:2.0f];
}

- (void)DetectAmbigousLayout{
    // It returns YES if the view’s frame is ambiguous. Otherwise, it returns NO.
    BOOL state = [self.viewGreen hasAmbiguousLayout];
    NSLog(@"viewGreen hasAmbiguousLayout = %d",state);
    
    //It returns an array of all the constraints affecting that view along the specified axis.
    NSArray *horizontalArray = [self.viewGreen constraintsAffectingLayoutForAxis:UILayoutConstraintAxisHorizontal];
    NSLog(@"viewGreen Horizontal constraints %@",horizontalArray);
    NSArray *verticalArray = [self.viewGreen constraintsAffectingLayoutForAxis:UILayoutConstraintAxisVertical];
    NSLog(@"viewGreen Vertical constraints %@",verticalArray);
    
    self.view.restorationIdentifier = @"";
    
}

- (void)exerciseAmbiguityInLayoutDemo{
    //Call this method on a view with ambiguous layout. This will toggle the system between the possible valid solutions.
    [self.viewRed exerciseAmbiguityInLayout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
