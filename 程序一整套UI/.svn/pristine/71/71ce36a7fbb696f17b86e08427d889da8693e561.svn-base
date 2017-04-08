//
//  MMSDropMenu.m
//  MSS
//
//  Created by 逸信Mac on 16/1/20.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "MMSDropMenu.h"
#import "MMSDropCell.h"

#define KBgColor [UIColor clearColor]

@interface MMSDropMenu()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *BgGroundView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,assign)BOOL IsShow;
@end

@implementation MMSDropMenu
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self MMSDMSetUpSubViews];
        
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self MMSDMSetUpSubViews];
    }
    return self;
}

-(void)MMSDMSetUpSubViews
{
    _IsShow = NO;

    //tableView init
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
    _tableView.rowHeight = 44;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[MMSDropCell class] forCellReuseIdentifier:@"MMSDropCell"];
    
    //background init and tapped
    _BgGroundView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    _BgGroundView.backgroundColor = KBgColor;//[UIColor colorWithWhite:0.0 alpha:0.0];
    _BgGroundView.opaque = NO;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DpBackgroundTapped:)];
    [_BgGroundView addGestureRecognizer:gesture];
}

-(void)setTitleArray:(NSArray *)TitleArray
{
    _TitleArray = TitleArray;
    [self.tableView reloadData];
}

/**
 *  点击事件接口
 *
 */
-(void)DpOpenMenu
{
    //收起tableview
    [self animateBackground:self.BgGroundView
                  tableView:self.tableView
                    forward:YES
                  complecte:^{
                      _IsShow = YES;
                  }];
}

-(void)DpCloseMenu
{
    //收起tableview
    [self animateBackground:self.BgGroundView
                  tableView:self.tableView
                    forward:NO
                  complecte:^{
                      _IsShow = NO;
                  }];
}

#pragma mark - 背景点击事件
- (void)DpBackgroundTapped:(UITapGestureRecognizer *)paramSender
{

    //收起tableview
    [self animateBackground:self.BgGroundView
                  tableView:self.tableView
                    forward:NO
                  complecte:^{
                      _IsShow = NO;
                  }];
    
    if(_DMBackGroundClickBlock){
        _DMBackGroundClickBlock();
    }

}

#pragma mark - 动画
- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            if(finished){
                [view removeFromSuperview];
            }
        }];
    }
    complete();
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)())complete {
    if (show) {//显示
        tableView.bounces = NO;
        tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > 3) ? (3 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                              _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
                         } completion:nil];
    } else {
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                            _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
                         } completion:^(BOOL finished) {
                             if(finished){
                                 [tableView removeFromSuperview];
                             }
                         }];
    }
    complete();
}

- (void)animateBackground:(UIView *)background tableView:(UITableView *)tableView forward:(BOOL)forward complecte:(void(^)())complete{
    
              //背景
            [self animateBackGroundView:background show:forward complete:^{
                //tableView
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];

    complete();
}




#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.TitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakself = self;
    static NSString *identifier = @"MMSDropCell";
    MMSDropCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MMSDropCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMSDropCell"];
    }
     NSString *title =  self.TitleArray[indexPath.row];
    cell.LableTitle.text =  title;
    [cell setDeleteClickBlock:^{
        //
        NSMutableArray *array = [self.TitleArray mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        self.TitleArray = [array copy];
        [self.tableView reloadData];
        
        if(weakself.DMDelectBlock){
            weakself.DMDelectBlock(title);
        }
    }];
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *TitleName = self.TitleArray[indexPath.row];
    if(_DMSelectBlock){
        _DMSelectBlock(TitleName);
    }
}

-(void)setSelectBlock:(DMSelect)DMSelectBlock DelectBlock:(DMDelect)DMDelectBlock BackGroundClickBlock:(DMBackGroundClick)DMBackGroundClickBlock
{
    _DMSelectBlock = DMSelectBlock;
    _DMDelectBlock = DMDelectBlock;
    _DMBackGroundClickBlock = DMBackGroundClickBlock;
}






@end
