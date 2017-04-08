//
//  MMfilterTableView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMfilterTableView.h"
#import "MMfilterTableCell.h"
#import "MMfilterSectionHead.h"
#import "MMFilterFriendModel.h"
#import "MMFilterGroupModel.h"
@interface MMfilterTableView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *confirmBtn;
@property(nonatomic,strong)UIButton *resetBtn;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UITapGestureRecognizer *tap;

@end
@implementation MMfilterTableView

-(UITapGestureRecognizer *)tap{
    if(_tap == nil){
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        _tap.numberOfTapsRequired = 1.0f;
    }
    return _tap;
}
-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.rowHeight = 44.0f;
        _tableView.sectionHeaderHeight = 50.0f;
        [_tableView registerClass:[MMfilterSectionHead class] forHeaderFooterViewReuseIdentifier:@"MMfilterSectionHead"];
        [_tableView registerClass:[MMfilterTableCell class] forCellReuseIdentifier:@"MMfilterTableCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIButton *)confirmBtn{
    if(_confirmBtn == nil){
        _confirmBtn = [UIButton new];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

-(UIButton *)resetBtn{
    if(_resetBtn == nil){
        _resetBtn = [UIButton new];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_resetBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_resetBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isOpen = NO;
        [self FTSetUpSubViews];
    }
    return self;
}

-(void)FTSetUpSubViews{
    self.backgroundColor = [UIColor clearColor];
//    [self addGestureRecognizer:self.tap];
    [self addSubview:self.tableView];
    [self addSubview:self.resetBtn];
    [self addSubview:self.line];
    [self addSubview:self.confirmBtn];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(0, 90.0f, 44.0f, 0.0f));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_tableView);
        make.height.mas_equalTo(0.5f);
        make.top.mas_equalTo(_tableView.mas_bottom);
    }];
    
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tableView);
        make.height.mas_equalTo(44.0f);
        make.top.mas_equalTo(_line.mas_bottom);
        make.width.mas_equalTo(_confirmBtn);
    }];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_resetBtn.mas_right);
        make.height.mas_equalTo(44.0f);
        make.top.mas_equalTo(_line.mas_bottom);
        make.right.mas_equalTo(_tableView);
        make.width.mas_equalTo(_resetBtn);
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MMFilterGroupModel *model = self.array[section];
    if(model.isDrop){
        return model.friends.count;
    }else{
        return 0.0f;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MMfilterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMfilterTableCell"];
    if(cell== nil){
        cell = [[MMfilterTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMfilterTableCell"];
    }
    MMFilterGroupModel *model = self.array[indexPath.section];
    MMFilterFriendModel *cellModel = model.friends[indexPath.row];
    [cell setCellModel:cellModel];
    [cell setSelectBtnClickBlock:^(BOOL state) {
        cellModel.isSelected = YES;
    }];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeakSelf();
    MMfilterSectionHead *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MMfilterSectionHead"];
    if(view == nil){
        view = [[MMfilterSectionHead alloc]initWithReuseIdentifier:@"MMfilterSectionHead"];
    }
    MMFilterGroupModel *model = self.array[section];
    [view setSectionClickBlock:^(BOOL state) {
        model.isDrop = state;
        [weakself.tableView reloadData];
    }];
    [view setSectionSeletedClickBlock:^(BOOL state) {
        model.isSelected = state;
        [model.friends enumerateObjectsUsingBlock:^(MMFilterFriendModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = state;
        }];
        [weakself.tableView reloadData];
    }];
    [view setViewModel:model];
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 50;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 确定点击
-(void)confirmBtnClick{
  
}

#pragma mark - 重置点击
-(void)resetBtnClick{
    [self.array enumerateObjectsUsingBlock:^(MMFilterGroupModel*  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.isSelected = NO;
        [model.friends enumerateObjectsUsingBlock:^(MMFilterFriendModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = NO;
        }];
        [self.tableView reloadData];
    }];
}

-(void)open{
    if (_isOpen == YES) {
        return;
    }
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.frame;
        frame.origin.x = 0.0f;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2f animations:^{
           self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        }];
        _isOpen = YES;
    }];
}

-(void)close{
    if (_isOpen == NO) {
        return;
    }
    [UIView animateWithDuration:0.2f animations:^{
       self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = kScreenWidth;
            self.frame = frame;
        }completion:^(BOOL finished) {
            _isOpen = NO;
        }];
    }];
    
}

-(void)toggle{
    if(_isOpen == NO){
        [self open];
    }else{
        [self close];
    }
}

//-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if ([hitView isKindOfClass:[UITableView class]]||[hitView isKindOfClass:[UIButton class]]||[hitView isKindOfClass:[UITableViewCell class]]) {
//        return hitView;
//    }else{
//        return nil;
//    }
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
