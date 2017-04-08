//
//  TagsTableViewController.m
//  WrapViewWithAutolayout
//
//  Created by Shaokang Zhao on 15/1/12.
//  Copyright (c) 2015年 shiweifu. All rights reserved.
//

#import "TagsTableViewController.h"
#import "TagsTableCell.h"
#import "SKTagView.h"
#import "YYFPSLabel.h"
#import <HexColors/HexColors.h>

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

//Reuse identifier
static NSString *const kTagsTableCellReuseIdentifier = @"TagsTableCell";

@interface UIImage (SKTagView)
+ (UIImage *)imageWithColor: (UIColor *)color;
@end

@interface TagsTableViewController ()
@property (nonatomic, strong) NSArray *colors;
@end

@implementation TagsTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[@"#7ecef4", @"#84ccc9", @"#88abda", @"#7dc1dd", @"#b6b8de"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    YYFPSLabel *pfsLable = [[YYFPSLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    self.navigationItem.titleView = pfsLable;
}

#pragma mark - Private

- (void)configureCell: (TagsTableCell *)cell atIndexPath: (NSIndexPath *)indexPath {
    cell.tagView.preferredMaxLayoutWidth = SCREEN_WIDTH;
    cell.tagView.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    cell.tagView.interitemSpacing = 15;
    cell.tagView.lineSpacing = 10;
    
    [cell.tagView removeAllTags];
    
    //Add Tags
    [@[@"Python", @"Javascript", @"Swift", @"Go", @"Objective-C",@"C", @"PHP",@"Python", @"Javascript", @"Swift", @"Go", @"Objective-C",@"C", @"PHP",@"Python", @"Javascript", @"Swift", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKTag *tag = [SKTag tagWithText:obj];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        tag.bgImg = [UIImage imageWithColor: [UIColor hx_colorWithHexString: self.colors[idx % self.colors.count]]];
        tag.cornerRadius = 5;
        tag.enable = NO;
        
        [cell.tagView addTag:tag];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TagsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier forIndexPath:indexPath];
    [self configureCell: cell atIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView: (UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    static TagsTableCell *cell = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier: kTagsTableCellReuseIdentifier];
    });
    [self configureCell: cell atIndexPath: indexPath];
    return [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize].height + 1;
}

- (void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath: indexPath animated:YES];
}

#pragma mark - IBActions

- (void)handleBtn:(id)sender {
    NSLog(@"Tap");
}

@end

@implementation UIImage (SKTagView)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
