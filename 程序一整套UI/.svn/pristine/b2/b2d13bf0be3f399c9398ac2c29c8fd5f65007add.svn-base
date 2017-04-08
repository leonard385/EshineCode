//
//  MMWorkCreateContentCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkCreateContentCell.h"
#import "MMSImageShowView.h"
@interface MMWorkCreateContentCell()<UITextViewDelegate>
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UITextView *textViewContent;
@property(nonatomic,strong)MMSImageShowView *imageSelectView;
@end

@implementation MMWorkCreateContentCell

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"工作内容";
    }
    return _lableTitle;
}

-(UITextView *)textViewContent{
    if(_textViewContent == nil){
        _textViewContent = [UITextView new];
        [_textViewContent setFont:[UIFont systemFontOfSize:15.0f weight:22.0f]];
        [_textViewContent setTextColor:HEXCOLOR(0x999999)];
        [_textViewContent setScrollEnabled:NO];
        _textViewContent.delegate = self;
    }
    return _textViewContent;
}

-(MMSImageShowView *)imageSelectView{
    if(_imageSelectView == nil){
        _imageSelectView = [MMSImageShowView new];
        [_imageSelectView setPhotoLimitCount:9.0f];
    }
    return _imageSelectView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self WCSetUpSubviews];
    }
    return self;
}

-(void)WCSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.textViewContent];
    [self.contentView addSubview:self.imageSelectView];
    [self.contentView addSubview:self.lineView];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.mas_equalTo(_lineView.mas_bottom);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(_lableTitle.mas_bottom);
        make.left.right.mas_equalTo(_lableTitle);
        make.height.mas_greaterThanOrEqualTo(30.0f);
    }];
    
    [_imageSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_textViewContent);
        make.top.mas_equalTo(_textViewContent.mas_bottom).with.offset(12.0f);
        make.height.mas_greaterThanOrEqualTo(80.0f);
        make.bottom.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_imageSelectView setISOpenPhotoLibBlock:^{
        
    }];
    [_imageSelectView setISViewHightChangeBlock:^(CGFloat height) {
        
    }];
    [_imageSelectView setDeletePhotoAtIndexBlock:^(NSInteger idx) {
        
    }];
}


-(void)textViewDidChange:(UITextView *)textView{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
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
