//
//  QJVersionUpdateVIew.m
//  QJVersionUpdateView
//
//  Created by Justin on 16/3/8.
//  Copyright © 2016年 Justin. All rights reserved.
//

#import "QJVersionUpdateVIew.h"
#import "Masonry.h"


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#define WIDTH  Screen_Width * 580/2/375
#define HEIGHT Screen_Height * 627/2/667
#define SPACE  Screen_Height * 50/667
#define TITLEFONT 24*Screen_Height/667
#define VERSIONFONT 15*Screen_Height/667
#define WIDTHSPACE Screen_Width * 15/375
// 屏幕宽高
#define Screen_Width    ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height   ([UIScreen mainScreen].bounds.size.height)
#define WindowView      [[UIApplication sharedApplication] keyWindow]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define NavigationBarColor UIColorFromRGB(0x60689f)
#define SYSTEMVERSION [[[UIDevice currentDevice] systemVersion] floatValue]



@interface QJVersionUpdateVIew()<UITableViewDataSource,UITableViewDelegate>

/**
 *  标题
 */
@property(nonatomic, strong)UILabel *titleLabel;

/**
 *  版本
 */
@property(nonatomic, strong)UILabel *VersionLabel;


/**
 *  描述tableView
 */
@property(nonatomic, strong)UITableView *describeTableView;

/**
 *  描述内容
 */
@property(nonatomic, strong)NSArray *DescribeArr;

/**
 *  稍后提醒
 */
@property(nonatomic, strong)UIButton *laterBt;

/**
 *  立即更新
 */
@property(nonatomic, strong)UIButton *rightNowBt;

/**
 *  蒙版
 */
@property(nonatomic, strong)UIView *backView;

@end

@implementation QJVersionUpdateVIew


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWith:(NSString *)version Describe:(NSArray *)describeArr
{
    self = [super init];
    if (self) {
        self.frame = [self getViewFrame];
        self.backgroundColor = [UIColor whiteColor];
        [self loadData:version];
        [self show];
        self.DescribeArr = describeArr;
        self.layer.cornerRadius = 10;
        [self addSubview:self.titleLable];
        [self addSubview:self.VersionLable];
        [self addSubview:self.describeTableView];
        [self addSubview:self.rightNowBt];
        [self addSubview:self.laterBt];
        [WindowView addSubview:self.backView];
        [WindowView bringSubviewToFront:self];
    }
    return self;
}

-(void)layoutSubviews
{
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
    }];
    [self.VersionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLable.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 20));
    }];
    [self.describeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.VersionLabel.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-SPACE);
        make.width.equalTo(self.mas_width);
    }];
    [self.laterBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(WIDTHSPACE);
        make.top.equalTo(self.describeTableView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 3*WIDTHSPACE)/2, SPACE/1.3));
    }];
    [self.rightNowBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.laterBt.mas_right).offset(WIDTHSPACE);
        make.top.equalTo(self.describeTableView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake((WIDTH - 3*WIDTHSPACE)/2, SPACE/1.3));
    }];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(WindowView);
    }];
    
}

-(CGRect)getViewFrame
{
    CGRect frame = CGRectZero;
    frame.size.height = HEIGHT;
    frame.size.width = WIDTH;
    frame.origin.x = (Screen_Width - WIDTH)/2;
    frame.origin.y = -HEIGHT;
    return frame;
}

- (void)loadData:(NSString *)versionStr
{
    self.titleLable.text = @"软件更新提示";
    self.VersionLable.text = versionStr;
}
-(UILabel *)titleLable
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:TITLEFONT];
        _titleLabel.textColor = UIColorFromRGB(0x3c3c3c);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


-(UILabel *)VersionLable
{
    if (_VersionLabel == nil) {
        _VersionLabel = [[UILabel alloc] init];
        _VersionLabel.font = [UIFont systemFontOfSize:VERSIONFONT];
        _VersionLabel.textColor = UIColorFromRGB(0xaeaeae);
        _VersionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _VersionLabel;
}

-(UITableView *)describeTableView
{
    if (_describeTableView == nil) {
        _describeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _describeTableView.delegate = self;
        _describeTableView.dataSource = self;
        _describeTableView.showsHorizontalScrollIndicator = NO;
        _describeTableView.showsVerticalScrollIndicator = NO;
        _describeTableView.scrollEnabled = [self IfScrollEnabled];
        _describeTableView.layer.cornerRadius = 10;
        _describeTableView.backgroundColor = [UIColor whiteColor];
        _describeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _describeTableView;
}

-(UIButton *)laterBt
{
    if (_laterBt == nil) {
        _laterBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_laterBt setTitle:@"稍后提醒" forState:UIControlStateNormal];
        [_laterBt setTitleColor:UIColorFromRGB(0xaeaeae) forState:UIControlStateNormal];
        [_laterBt setTitleColor:UIColorFromRGB(0xd4d4d4) forState:UIControlStateHighlighted];
        _laterBt.layer.borderColor = UIColorFromRGB(0xaeaeae).CGColor;
        _laterBt.layer.borderWidth = 0.5;
        _laterBt.layer.cornerRadius = 5;
        _laterBt.titleLabel.font = [UIFont systemFontOfSize:VERSIONFONT + 2];
        [_laterBt addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _laterBt;
}

-(UIButton *)rightNowBt
{
    if (_rightNowBt == nil) {
        _rightNowBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightNowBt setTitle:@"立即更新" forState:UIControlStateNormal];
        [_rightNowBt setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [_rightNowBt setTitleColor:UIColorFromRGB(0x716fd7) forState:UIControlStateHighlighted];
        _rightNowBt.titleLabel.font = [UIFont systemFontOfSize:VERSIONFONT + 2];
        _rightNowBt.backgroundColor = NavigationBarColor;
        _rightNowBt.layer.cornerRadius = 5;
        [_rightNowBt addTarget:self action:@selector(goToAppStore) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNowBt;
}

- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.5f;
        _backView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _backView;
}

- (void)show
{
    [WindowView addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.frame = CGRectMake((Screen_Width - WIDTH)/2, (Screen_Height - HEIGHT)/2 - SPACE, WIDTH, HEIGHT);
    }];
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    [animation setDelegate:self];
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.5;
    [animation setKeyPath:@"transform.rotation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.layer addAnimation:animation forKey:@"shake"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.DescribeArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHight = [self calculateSizeWithWidth:WIDTH - 40 font:[UIFont systemFontOfSize:VERSIONFONT] content:self.DescribeArr[indexPath.row]];
    return rowHight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"statusCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self configCellSubViews:cell Index:indexPath.row];
    return cell;
}

/**
 *  计算高度
 *
 *  @param width   label width
 *  @param font    label font
 *  @param content label content
 *
 *  @return hight
 */
- (float)calculateSizeWithWidth:(float)width font:(UIFont *)font content:(NSString *)content
{
    if(SYSTEMVERSION >= 7.0){
        CGSize maximumSize =CGSizeMake(width,9999);
        NSDictionary *textDic = @{NSFontAttributeName : font};
        CGSize contentSize = [content boundingRectWithSize:maximumSize options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:textDic context:nil].size;
        CGSize oneLineSize = [@"test" boundingRectWithSize:CGSizeMake(MAXFLOAT,MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:textDic context:nil].size;
        return (contentSize.height/oneLineSize.height) * 10 + contentSize.height;
    }
    else{
        CGSize contentsize = [content sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        CGSize oneLineSize = [@"test" sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        return (contentsize.height/oneLineSize.height ) * 10 + contentsize.height;
    }
}

- (void)configCellSubViews:(UITableViewCell *)cell Index:(NSInteger)index
{
    NSString *contentStr = self.DescribeArr[index];
    UILabel *DescribeLabel = [[UILabel alloc] init];
    DescribeLabel.font = [UIFont systemFontOfSize:VERSIONFONT];
    DescribeLabel.textAlignment = NSTextAlignmentLeft;
    DescribeLabel.numberOfLines = 0;
    DescribeLabel.text = contentStr;
    DescribeLabel.textColor = UIColorFromRGB(0x3c3c3c);
    [cell.contentView addSubview:DescribeLabel];
    
    CGFloat rowHight = [self calculateSizeWithWidth:WIDTH - 40 font:[UIFont systemFontOfSize:VERSIONFONT] content:contentStr];
    [DescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.contentView);
        make.height.mas_equalTo(rowHight);
        make.left.equalTo(cell.contentView).offset(20);
        make.right.equalTo(cell.contentView).offset(-20);
    }];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contentStr length])];
    
    [DescribeLabel setAttributedText:attributedString];
    
}

-(BOOL)IfScrollEnabled
{
    BOOL ee;
    float height;
    height = [self returnRowHight:0 Index:0];
    ee = height < HEIGHT - 80 - SPACE || height == HEIGHT - 80 - SPACE ? NO : YES;
    return ee;
}

- (float)returnRowHight:(float)height Index:(NSInteger)index
{
    if (index > self.DescribeArr.count - 1) {
        return height;
    }else{
        height = height + [self calculateSizeWithWidth:WIDTH - 40 font:[UIFont systemFontOfSize:VERSIONFONT] content:self.DescribeArr[index]];
        index ++;
        return [self returnRowHight:height Index:index];
    }
    return 0;
}

- (void)removeView
{
    [UIView animateWithDuration:0.25 animations:^{
        [self setFrame:CGRectMake((Screen_Width - WIDTH)/2, Screen_Height, WIDTH, HEIGHT)];
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        self.backView = nil;
        [self removeFromSuperview];
        if (self.removeUpdateViewBlock) {
            self.removeUpdateViewBlock();
        }
    }];
    
}

- (void)goToAppStore
{
    if (self.GoTOAppstoreBlock) {
        self.GoTOAppstoreBlock();
    }
}


@end
