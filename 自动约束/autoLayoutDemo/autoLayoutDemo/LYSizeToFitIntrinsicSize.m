//
//  LYSizeToFitIntrinsicSize.m
//  autoLayoutDemo
//
//  Created by leo on 2018/1/22.
//  Copyright © 2018年 倪望龙. All rights reserved.
//

#import "LYSizeToFitIntrinsicSize.h"
#import "WLAutoSizeTableView.h"
@interface LYSizeToFitIntrinsicSize()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)WLAutoSizeTableView *tableView;
@end
@implementation LYSizeToFitIntrinsicSize

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(WLAutoSizeTableView *)tableView{
    if(_tableView == nil){
        _tableView = [[WLAutoSizeTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.rowHeight = 44.0f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self STSetUpSubviews];
    }
    return self;
}


-(void)STSetUpSubviews{
    [self addSubview:self.tableView];
    [_tableView setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
    [_tableView setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(!CGSizeEqualToSize(self.bounds.size, self.intrinsicContentSize)){
        [self invalidateIntrinsicContentSize];
    }
}

-(CGSize)intrinsicContentSize{
    return UILayoutFittingCompressedSize;
}

-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    return size;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld行",indexPath.row];
    return cell;
}
@end
