//
//  IMMessageViewController.m
//  IMDemo
//
//  Created by 倪望龙 on 2017/2/22.
//  Copyright © 2017年 XunYiJia. All rights reserved.
//

#import "IMMessageViewController.h"
#import "IMClientManage.h"
#import "UIButton+BackgroundColor.h"
@interface IMMessageViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageToSendInput;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMessage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRecieve;

@end

@implementation IMMessageViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MVSetUpSubviews];
    [self MVMessageNotice];
    // Do any additional setup after loading the view from its nib.
}

-(void)MVMessageNotice{
    // subscribe to the destination
    [[IMClientManage shareMannager] subscribeTo:@"/queue/myqueue"
                headers:@{@"selector": @"color = 'red'"}
         messageHandler:^(STOMPMessage *message) {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 // callback when the client receive a message
                 // for the /queue/myqueue destination
                 
                 NSLog(@"got message %@", message.body); // => "Hello, iOS"
                 [_textFieldRecieve setText:message.body];
                 
             });
             
         }];
}

-(void)MVSetUpSubviews{
    _messageToSendInput.layer.cornerRadius = 5.0f;
    _messageToSendInput.layer.borderColor = HEXCOLOR(0xeeeeee).CGColor;
    _messageToSendInput.layer.borderWidth = 1.0f;
    _messageToSendInput.layer.masksToBounds = YES;
    
    _textFieldRecieve.layer.cornerRadius = 5.0f;
    _textFieldRecieve.layer.borderColor = HEXCOLOR(0xeeeeee).CGColor;
    _textFieldRecieve.layer.borderWidth = 1.0f;
    _textFieldRecieve.layer.masksToBounds = YES;
    
    
    _btnSendMessage.layer.cornerRadius = 5.0f;
    _btnSendMessage.layer.masksToBounds = YES;
    [_btnSendMessage setBackgroundColor:HEXCOLOR(0x00dddd) forState:UIControlStateNormal];
    [_btnSendMessage setBackgroundColor:HEXCOLOR(0xeeeeee) forState:UIControlStateHighlighted];
    [_btnSendMessage addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 点击发送
-(void)sendMessage{
    NSString *sendMsg = _messageToSendInput.text;
    // send a message
    [[IMClientManage shareMannager] sendTo:@"/queue/myqueue" body:sendMsg];
    // and disconnect
//    [[IMClientManage shareMannager] disconnect];
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
