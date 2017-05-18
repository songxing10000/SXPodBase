//
//  SmallRedDotContainersLayer.h
//  CKK_SJ
//
//  Created by MobileUser on 2017/1/19.
//  Copyright © 2017年 一号车. All rights reserved.
//


#define AngleWithDegrees(deg) (M_PI * (deg) / 180.0)

static const CGFloat kCircleSize = 4; //!< 点的大小
static const NSInteger kCircleCount = 9; //!< 点的数量
static const CGFloat kAnimationDuration = 0.9; //!< 动画时长
static const CGFloat kCircleContainerSize = 20; //!< 转圈的大小

#import <QuartzCore/QuartzCore.h>


/**
 小红点容器layer
 */
@interface SmallRedDotContainersLayer : CAReplicatorLayer


/**
 初始化一个对象

 @return 各项属性初始化后的一下实例对象
 */
+ (instancetype)layer;


/**
 开始动画
 */
-(void)startAnimation;

/**
 结束动画
 */
- (void)endAnimation;

@end
