//
//  CKKXHeaderRefresh.m
//  CKKSJ


//
//  Created by BILL on 2016/12/7.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKHeaderRefresh.h"
#import "SmallRedDotContainersLayer.h"

@interface CKKHeaderRefresh()
{
    SmallRedDotContainersLayer *_containerLayer2;
}
@property(weak, nonatomic)UILabel * label;
@property(nonatomic, strong)UIImageView * imageView;

@end
@implementation CKKHeaderRefresh



 
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    // 设置控件的高度
    self.mj_h = 80;

    UIView * headerFreshView =
    ({
        UIView * view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        view.layer.masksToBounds = YES;
        view;
    });
    
    [self addSubview:headerFreshView];
    self.headerFreshView = headerFreshView;

    UILabel *label =
    ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithRed:136.0/255 green:136.0/255 blue:136.0/255 alpha:1.0];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    
    [self.headerFreshView addSubview:label];
    self.label = label;
    
    
    _containerLayer2 = [SmallRedDotContainersLayer layer];
    [self.headerFreshView.layer addSublayer:_containerLayer2];
    UIColor *c = [UIColor blueColor];

    self.headerFreshView.backgroundColor = c;
//    [UIColor backgroudColor];
    self.backgroundColor = c;
//    [UIColor backgroudColor];

}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];

    _containerLayer2.frame = CGRectMake(0, 5, kCircleContainerSize, kCircleContainerSize);
    
    self.label.frame = CGRectMake(30, 5, 80, 20);
    [self.label sizeToFit];
    self.headerFreshView.bounds = CGRectMake(0, 0, 120, 80);// 20 4 80 = 104
    self.headerFreshView.center = CGPointMake(self.mj_w*0.5, self.mj_h-20);


}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉刷新";
            [self endAnimation];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开加载更多";
             [self startAnimation];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载中...";
            [self startAnimation];
            break;
        default:
            break;
    }
}



#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    self.label.textColor = [UIColor blackColor];
}


#pragma mark 图片旋转
- (void)startAnimation {

    [_containerLayer2 startAnimation];

}
- (void)endAnimation {
    
    [_containerLayer2 endAnimation];
}

@end
