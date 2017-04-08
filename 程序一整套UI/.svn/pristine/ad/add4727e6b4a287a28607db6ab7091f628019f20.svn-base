//
//  MMExamTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamCollectionCell.h"
#import "MMExamContentCell.h"
#import "MMExamAnalysisCell.h"
#import "MMExamContentHeadCell.h"
#import "MMExamContentChooseCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NSString+MMUtil.h"
@interface MMExamCollectionCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@end
@implementation MMExamCollectionCell
-(UITableView *)tableView{
    if(_tableView == nil){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[MMExamContentHeadCell class] forCellReuseIdentifier:@"MMExamContentHeadCell"];
        [self.tableView registerClass:[MMExamContentChooseCell class] forCellReuseIdentifier:@"MMExamContentChooseCell"];
        [self.tableView registerClass:[MMExamAnalysisCell class] forCellReuseIdentifier:@"MMExamAnalysisCell"];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self ECSetUpSubview];
    }
    return self;
}

-(void)ECSetUpSubview{
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return _cellModel.content.chooses.count + 1;
        }
            break;
        case 1:{
            return 1.0f;
        }
            break;
            
        default:{
            return 0;
        }
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
             MMExamContentModel *contentModel = _cellModel.content;
            if(indexPath.row == 0){
            CGFloat cell1H =   [tableView fd_heightForCellWithIdentifier:@"MMExamContentHeadCell" configuration:^(MMExamContentHeadCell* cell) {
                [cell setType:[contentModel.classType unsignedIntegerValue] examTitle:contentModel.title];
                cell.fd_enforceFrameLayout = YES;
            }];
            return  cell1H;
            }else{
                CGFloat cell2H = [tableView fd_heightForCellWithIdentifier:@"MMExamContentChooseCell" configuration:^(MMExamContentChooseCell* cell) {
                    [cell setChooseStr:[[NSString new]getEnglishLettersAtIdex:indexPath.row - 1]ChooseContent:contentModel.chooses[indexPath.row - 1]];
                    cell.fd_enforceFrameLayout = YES;
                }];
                return  cell2H;
            }
        }
            break;
        case 1:{
            return [tableView fd_heightForCellWithIdentifier:@"MMExamAnalysisCell" configuration:^(MMExamAnalysisCell* cell) {
                [cell setCellModel:_cellModel.anlysis];
            }];
        }
            break;
        default:{
            return 0.0f;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MMExamContentModel *contentModel = _cellModel.content;
            if(indexPath.row == 0){
                MMExamContentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMExamContentHeadCell"];
                if(cell == nil){
                    cell = [[MMExamContentHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMExamContentHeadCell"];
                }
                [cell setType:[contentModel.classType unsignedIntegerValue] examTitle:contentModel.title];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
                return cell;
            }else{
                MMExamContentChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMExamContentChooseCell"];
                if(cell == nil){
                    cell = [[MMExamContentChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMExamContentChooseCell"];
                }
                [cell setChooseStr:[[NSString new]getEnglishLettersAtIdex:indexPath.row - 1]ChooseContent:contentModel.chooses[indexPath.row - 1]];
                return cell;

            }
        }
            break;
        case 1:{
            MMExamAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMExamAnalysisCell"];
            if(cell == nil){
                cell = [[MMExamAnalysisCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMExamAnalysisCell"];
            }
            [cell setCellModel:_cellModel.anlysis];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)setCellModel:(MMExamModel *)cellModel{
    _cellModel = cellModel;
    [_tableView reloadData];
}

@end
