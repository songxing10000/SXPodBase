//
//  CKKSJBaseVC.m
//  dfpo
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKLoadingView.h"

@interface CKKLoadingView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end
@implementation CKKLoadingView

- initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.imageView = [[UIImageView alloc] initWithImage:nil];//[UIImage sd_animatedGIFNamed:@"bg_loading"]];
        self.imageView.backgroundColor = [UIColor clearColor];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        self.label.font = [UIFont systemFontOfSize:14.f];
        self.label.textColor = [UIColor lightGrayColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 2;
        self.label.text = @"正在加载，请稍候...";
        
        [_backView addSubview:_imageView];
        [_backView addSubview:_label];
        [self addSubview:_backView];
        
        self.autoresizesSubviews = NO;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topSpace = 10;
    CGSize imageSize = self.imageView.image.size;
    CGFloat spaceV = 20.f;
    CGFloat labelHeight = 40.f;
    CGFloat totalHeight = imageSize.height + spaceV + labelHeight + 2 * topSpace;
    
    //调整大小
    CGFloat r = 1.0;//缩放比例
    CGFloat selfH = self.frame.size.height;
    CGFloat selfW = self.frame.size.width;
    if (selfH <= totalHeight) {
        r = (selfH - labelHeight - 2 * topSpace) / (totalHeight - labelHeight - 2 * topSpace);
        imageSize = CGSizeMake(imageSize.width*r, imageSize.height*r);
        spaceV *= r;
        totalHeight = imageSize.height + spaceV + labelHeight + 2 * topSpace;
    }
    
    CGFloat backViewHeight = MIN(totalHeight, 200);
    CGFloat backViewH = _backView.frame.size.height;
    CGFloat backViewW = _backView.frame.size.width;

    _backView.frame = CGRectMake(0, (selfH - backViewHeight ) / 2, selfW, backViewHeight);
    
    CGRect iconRect = CGRectMake((backViewW - imageSize.width) / 2.0, (backViewH - totalHeight) / 2.0 + topSpace, imageSize.width, imageSize.height);
    _imageView.frame = iconRect;
    
    _label.frame = CGRectMake(0, CGRectGetMaxY(iconRect) + spaceV, selfW, labelHeight);
//    self.imageView.frame = CGRectMake((self.width - self.imageView.size.width)/2, (self.height - self.imageView.size.height ) / 2, self.imageView.size.width, self.imageView.size.height);
//    
//    
//    self.label.frame = CGRectMake(0, self.imageView.bottom, self.width, 20);
    
}
@end
