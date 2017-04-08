//
//  MMEmployInfoInputController.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployInfoInputController.h"

@interface MMEmployInfoInputController ()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UITextField *textFieldInput;
@end

@implementation MMEmployInfoInputController

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.edgesForExtendedLayout = UIRectEdgeNone;
         self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

-(UIView *)contentView{
    if(_contentView == nil){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UITextField *)textFieldInput{
    if(_textFieldInput == nil){
        _textFieldInput = [[UITextField alloc]init];
        [_textFieldInput setFont:[UIFont systemFontOfSize:15.0f]];
        [_textFieldInput setBorderStyle:UITextBorderStyleNone];
        [_textFieldInput setClearButtonMode:UITextFieldViewModeWhileEditing];
//        _textFieldInput.delegate = self;
    }
    return _textFieldInput;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self IISetUpNavItem];
    [self IISetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [_textFieldInput setPlaceholder:[NSString stringWithFormat:@"请输入%@",self.navTitle]];
}

-(void)IISetUpNavItem{
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    completeBtn.frame = CGRectMake(0, 0, 40, 20);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
    [completeBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(IIcompleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *completeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
    self.navigationItem.rightBarButtonItem = completeBtnItem;
}

-(void)IISetUpSubviews{
    self.view.backgroundColor = HEXCOLOR(0xefeff4);
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.textFieldInput];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).with.offset(12.0f);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_textFieldInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_contentView).with.insets(UIEdgeInsetsMake(0, 12.0f, 0.0f, 12.0f));
    }];
    
}

-(void)IIcompleteBtnClick{
    _returnInputBlock ? _returnInputBlock(_textFieldInput.text):nil;
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setNavTitle:(NSString *)navTitle{
    _navTitle = navTitle;
    self.title = navTitle;
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
