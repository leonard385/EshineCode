//
//  MMTaskEditViewController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTaskEditViewController.h"

@interface MMTaskEditViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITextView *textViewContent;
@property(nonatomic,strong)UILabel *lableLimit;
@end

@implementation MMTaskEditViewController

-(UIView *)contentView{
    if(_contentView == nil){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UITextView *)textViewContent{
    if(_textViewContent == nil){
        _textViewContent = [UITextView new];
        [_textViewContent setFont:[UIFont systemFontOfSize:15.0f weight:22.0f]];
        [_textViewContent setTextColor:HEXCOLOR(0x999999)];
        _textViewContent.delegate = self;
    }
    return _textViewContent;
}

-(UILabel *)lableLimit{
    if(_lableLimit == nil){
        _lableLimit = [UILabel new];
        _lableLimit.font = [UIFont systemFontOfSize:16.0f];
        _lableLimit.textColor = HEXCOLOR(0x999999);
        _lableLimit.text = @"16/99";
        _lableLimit.textAlignment = NSTextAlignmentRight;
    }
    return _lableLimit;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self TESetUpNavItem];
    [self TESetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)TESetUpNavItem{
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(TEcompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
}


-(void)TESetUpSubviews{
    self.view.backgroundColor = HEXCOLOR(0xefeff4);
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.textViewContent];
    [self.contentView addSubview:self.lableLimit];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(12.0f);
        make.height.mas_equalTo(118.0f);
    }];
    
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_contentView).with.offset(12.0f);
        make.left.mas_equalTo(_contentView).with.offset(12.0f);
        make.right.mas_equalTo(_contentView).with.offset(-12.0f);
        make.height.mas_equalTo(73.0f);
    }];
    
    [_lableLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_textViewContent);
        make.height.mas_equalTo(21.0f);
        make.top.mas_equalTo(_textViewContent.mas_bottom);
    }];
}

#pragma mark - 设置导航标题
-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.title = navTitle;
}

#pragma mark - 完成按钮点击
-(void)TEcompleteBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
    _textViewTextBlock?_textViewTextBlock(_textViewContent.text):nil;
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
