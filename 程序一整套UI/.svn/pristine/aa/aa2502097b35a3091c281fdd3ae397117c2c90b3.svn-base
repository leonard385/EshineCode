//
//  MMExamContentCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamContentCell.h"
#import "MMExamContentHeadCell.h"
#import "MMExamContentChooseCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NSString+MMUtil.h"
@interface MMExamContentCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *chooseArray;
@end

@implementation MMExamContentCell

-(UITableView *)tableView{
    if(_tableView == nil){
        self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.tableView registerClass:[MMExamContentHeadCell class] forCellReuseIdentifier:@"MMExamContentHeadCell"];
        [self.tableView registerClass:[MMExamContentChooseCell class] forCellReuseIdentifier:@"MMExamContentChooseCell"];
        [self.tableView setBounces:NO];
//        [self.tableView setScrollEnabled:NO];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self ECSetUpSubviews];
    }
    return self;
}

-(void)updateConstraints{
    CGFloat tableViewContentH = _tableView.contentSize.height;
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(tableViewContentH);
        make.bottom.mas_equalTo(self.contentView).with.offset(-15.0f);
    }];
    [super updateConstraints];
}

-(void)ECSetUpSubviews{
    [self.contentView addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1.0f;
           }
            break;
        case 1:{
            return _chooseArray.count;
        }
            break;
        default:{
            return 0.0f;
        }
            break;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            CGFloat cell1H =   [tableView fd_heightForCellWithIdentifier:@"MMExamContentHeadCell" configuration:^(MMExamContentHeadCell* cell) {
                [cell setType:[_cellModel.classType unsignedIntegerValue] examTitle:_cellModel.title];
                cell.fd_enforceFrameLayout = YES;
            }];
            return  cell1H;
        }
            break;
        case 1:{
            CGFloat cell2H = [tableView fd_heightForCellWithIdentifier:@"MMExamContentChooseCell" configuration:^(MMExamContentChooseCell* cell) {
                [cell setChooseStr:[[NSString new]getEnglishLettersAtIdex:indexPath.row]ChooseContent:_chooseArray[indexPath.row]];
                 cell.fd_enforceFrameLayout = YES;
            }];
            return  cell2H;
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
            MMExamContentHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMExamContentHeadCell"];
            if(cell == nil){
                cell = [[MMExamContentHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMExamContentHeadCell"];
            }
             [cell setType:[_cellModel.classType unsignedIntegerValue] examTitle:_cellModel.title];
            
            return cell;
        }
           break;
        case 1:{
            MMExamContentChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MMExamContentChooseCell"];
            if(cell == nil){
                cell = [[MMExamContentChooseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MMExamContentChooseCell"];
            }
            [cell setChooseStr:[[NSString new]getEnglishLettersAtIdex:indexPath.row]ChooseContent:_chooseArray[indexPath.row]];
            return cell;
        }
            break;
        default:{
            return nil;
        }
            break;
    }
}


-(void)setCellModel:(MMExamContentModel *)cellModel{
    _cellModel = cellModel;
    _chooseArray = _cellModel.chooses;
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
