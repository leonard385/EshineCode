//
//  MMAttentionTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/7.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMAttentionTableViewCell.h"
#import "MMAttionCollectionViewCell.h"
@interface MMAttentionTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;
@end

@implementation MMAttentionTableViewCell

-(UICollectionViewFlowLayout *)flowLayout{
    if(_flowLayout == nil){
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.itemSize = CGSizeMake(160.0f, 194.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 10.0f, 0, 10.0f);
        _flowLayout.minimumLineSpacing = 10.0f;
        _flowLayout.minimumInteritemSpacing = 10.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}
-(UICollectionView *)collectView{
    if(_collectView == nil){
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 13.0f, kScreenWidth,200.0f) collectionViewLayout:self.flowLayout];
        [_collectView registerClass:[MMAttionCollectionViewCell class] forCellWithReuseIdentifier:@"MMAttionCollectionViewCell"];
        _collectView.showsHorizontalScrollIndicator = NO;
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self ATSetUpSubviews];
    }
    return self;
}

-(void)ATSetUpSubviews{
    [self.contentView addSubview:self.collectView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0f;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10.0f;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MMAttionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMAttionCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
