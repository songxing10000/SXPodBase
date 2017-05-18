//
//  SmallRedDotContainersLayer.m
//  CKK_SJ
//
//  Created by MobileUser on 2017/1/19.
//  Copyright © 2017年 一号车. All rights reserved.
//

#import "SmallRedDotContainersLayer.h"

@implementation SmallRedDotContainersLayer

+ (instancetype)layer {
    
    SmallRedDotContainersLayer *layer = [[SmallRedDotContainersLayer alloc] init];
    layer.masksToBounds = YES;
    layer.instanceCount = kCircleCount;
    layer.instanceDelay = kAnimationDuration / layer.instanceCount;
    layer.instanceTransform = CATransform3DMakeRotation(AngleWithDegrees(360 / layer.instanceCount), 0, 0, 1);
    
    return layer;
}

-(void)startAnimation {
    
    CALayer *subLayer2 =
    ({
        CALayer *subLayer2 = [CALayer layer];
        subLayer2.backgroundColor = [UIColor redColor].CGColor;
//        [CKKRGBAColor(244, 86, 129, 1.0) CGColor];
        subLayer2.frame = CGRectMake((kCircleContainerSize - kCircleSize) / 2, 0, kCircleSize, kCircleSize);
        subLayer2.cornerRadius = kCircleSize / 2;
        subLayer2.transform = CATransform3DMakeScale(0, 0, 0);
        subLayer2;
    });
    [self addSublayer:subLayer2];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = @(1);
    animation2.toValue = @(0.1);
    animation2.repeatCount = HUGE;
    animation2.duration = kAnimationDuration;
    [subLayer2 addAnimation:animation2 forKey:nil];
    
}

- (void)endAnimation {
    
    for (CALayer *layer in self.sublayers) {
        [layer removeAllAnimations];
    }
    
}
@end
