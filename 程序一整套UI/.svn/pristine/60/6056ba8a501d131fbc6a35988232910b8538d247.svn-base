//
//  MMExamCardDropView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamCardDropView.h"
#import "MMExamCardCollectionCell.h"

@interface MMExamCardDropView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UIView *backGroundView;
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UIGestureRecognizer *bgTap;
@property(nonatomic,strong)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic,assign)BOOL isShow;
@end
@implementation MMExamCardDropView

-(UICollectionViewFlowLayout *)flowLayout{
    if(_flowLayout == nil){
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.itemSize = CGSizeMake(48.0f,48.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(12.0, 12.0f, 12.0f, 12.0f);
        _flowLayout.minimumLineSpacing = 13.0f;
        _flowLayout.minimumInteritemSpacing = 10.0f;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}
-(UICollectionView *)collectView{
    if(_collectView == nil){
        _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,352.0f) collectionViewLayout:self.flowLayout];
        [_collectView registerClass:[MMExamCardCollectionCell class] forCellWithReuseIdentifier:@"MMExamCardCollectionCell"];
        _collectView.showsVerticalScrollIndicator = NO;
        _collectView.backgroundColor = [UIColor whiteColor];
        _collectView.pagingEnabled = YES;
        _collectView.delegate = self;
        _collectView.dataSource = self;
    }
    return _collectView;
}

-(UIGestureRecognizer *)bgTap{
    if(_bgTap == nil){
      _bgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped)];
    }
    return _bgTap;
}

-(UIView *)backGroundView{
    if(_backGroundView == nil){
        _backGroundView = [UIView new];
        _backGroundView.backgroundColor = [UIColor clearColor];
        _backGroundView.opaque = NO;
        _backGroundView.layer.masksToBounds = YES;
        [_backGroundView addGestureRecognizer:self.bgTap];
    }
    return _backGroundView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _isShow = NO;
    }
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0f;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10.0f;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MMExamCardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MMExamCardCollectionCell" forIndexPath:indexPath];
    [cell setTitle:[NSString stringWithFormat:@"%lu",indexPath.row]];
    NSUInteger row = indexPath.row;
    if(row % 2 == 0){
        [cell setCellType:0];
    }else if(row % 3 == 0){
      [cell setCellType:1];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    _didSelectItemAtIndex?_didSelectItemAtIndex(indexPath.row):nil;
}

#pragma mark - 背景点击事件
-(void)backgroundTapped{
    [self hidenMenu];

}

#pragma mark - 设置考试试题类型
-(void)setItemAtIndex:(NSUInteger)idex withType:(ExamCardCellType)type{
    NSIndexPath *path  = [[NSIndexPath alloc]initWithIndex:idex];
    UICollectionViewCell * cell = [_collectView cellForItemAtIndexPath:path];
    [(MMExamCardCollectionCell *)cell setCellType:type];
}

-(void)setBgframe:(CGRect)bgframe{
    self.backGroundView.frame = bgframe;
}

-(void)showMenu
{
    if(!_isShow){
    [self animateBackground:self.backGroundView
                CollectView:self.collectView
                    forward:YES complecte:^{
                        _isShow = YES;
                    }];
    }else{
        return;
    }
}

-(void)hidenMenu
{
    if(_isShow){
    [self animateBackground:self.backGroundView
                CollectView:self.collectView
                    forward:NO complecte:^{
                        _isShow = NO;
                    }];
    }else{
        return;
    }
}

#pragma mark - 动画
- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            if(finished){
                [view removeFromSuperview];
            }
        }];
    }
    complete();
}

- (void)animateCollectView:(UICollectionView *)collectView show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        collectView.frame = CGRectMake(0,self.backGroundView.frame.size.height + 352.0f, self.backGroundView.frame.size.width,352.0f);
        [self.backGroundView addSubview:collectView];
        
        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                            collectView.frame =  CGRectMake(0,self.backGroundView.frame.size.height - 352.0f, self.backGroundView.frame.size.width,352.0f);
                         } completion:nil];
    } else {

        [UIView animateWithDuration:0.5
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                              collectView.frame = CGRectMake(0,self.backGroundView.frame.size.height + 352.0f, self.backGroundView.frame.size.width,352.0f);
                         } completion:^(BOOL finished) {
                             if(finished){
                                 [collectView removeFromSuperview];
                             }
                         }];
    }
    complete();
}

- (void)animateBackground:(UIView *)background CollectView:(UICollectionView *)collectView forward:(BOOL)forward complecte:(void(^)())complete{
    
    //背景
    [self animateBackGroundView:background show:forward complete:^{
        //tableView
        [self animateCollectView:collectView show:forward complete:^{
            
        }];
    }];
    
    complete();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
