//
//  CKKSJBaseVC.m
//  dfpo
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//


#import "CKKEmptyView.h"

@interface CKKEmptyView(){
    SEL _refreshSelector;
}
@property (nonatomic, weak) id target;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, readwrite) UILabel *label;
@end
@implementation CKKEmptyView


UIColor*RGBS(CGFloat sameValue) {
    if (sameValue < 0) {
        sameValue = 0;
    }
    if (sameValue > 255.0) {
        sameValue = 255.0;
    }
    return [UIColor colorWithRed:sameValue / 255.0f green:sameValue / 255.0f blue:sameValue / 255.0f alpha:1.0f];
}

- initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backView = [[UIView alloc] initWithFrame:CGRectZero];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView = [[UIImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 1;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [self colorWithHexString:@"0x888888"];
        
        [_backView addSubview:_imageView];
        [_backView addSubview:_label];
        [self addSubview:_backView];
        self.type = EmptyViewTypeNormal;
        
        self.autoresizesSubviews = NO;
        
        // 重新加载按钮
        UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        reloadBtn.backgroundColor = [UIColor clearColor];
        
        reloadBtn.clipsToBounds = YES;
        reloadBtn.layer.cornerRadius = 6.0f;
        reloadBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reloadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        
        UIImage *nImg = [self imageWithColor:[self colorWithHexString:@"0xF45861"]];
        [reloadBtn setBackgroundImage:nImg forState:UIControlStateNormal];
        
        UIImage *hImg = [self imageWithColor:[self colorWithHexString:@"0xE53441"]];
        [reloadBtn setBackgroundImage:hImg forState:UIControlStateHighlighted];
        [reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        
        [_backView addSubview:reloadBtn];
        _reloadBtn = reloadBtn;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat topSpace = 10;
    CGSize imageSize = self.icon.size;
    CGFloat spaceV = 20.f;
    [_label sizeToFit];
    CGFloat labelHeight = CGRectGetHeight(_label.frame);
    CGFloat totalHeight = imageSize.height + spaceV + labelHeight + 2 * topSpace + 45 + 20;
    //labelHeight + 2 * topSpace 为固定不变 不缩放的高度。
    
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
    
    CGFloat backViewHeight = totalHeight;//MIN(totalHeight, 200);
    _backView.frame = CGRectMake(0, (selfH - backViewHeight ) / 2-70, selfW, backViewHeight);
    CGFloat backViewH = _backView.frame.size.height;
    CGFloat backViewW = _backView.frame.size.width;

    
    CGRect iconRect = CGRectMake((backViewW - imageSize.width) / 2.0, (backViewH - totalHeight) / 2.0 + topSpace, imageSize.width, imageSize.height);
    _imageView.frame = iconRect;
    
    _label.frame = CGRectMake(0, CGRectGetMaxY(iconRect) + spaceV, selfW, labelHeight);
    
    // 重新加载按钮的位置
    CGFloat reloadBtnW = 210;
    CGFloat reloadBtnH = 45;

    _reloadBtn.frame =
    CGRectMake(([UIScreen mainScreen].bounds.size.width - reloadBtnW)*0.5, CGRectGetMaxY(_label.frame)+30, reloadBtnW, reloadBtnH);
}
#if 0
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_type != EmptyViewTypeNormal) {
        if(_target && [_target respondsToSelector:_refreshSelector])
        {
            SuppressPerformSelectorLeakWarning([_target performSelector:_refreshSelector withObject:self]);
        }
    }
}
#endif
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _imageView.image = _icon;
}

- (void)setText:(NSString *)text {
    _text = text;
    _label.text = _text;
}

- (void)setType:(EmptyViewType)type{
    _type = type;
    _label.textColor = RGBS(170);
    _label.font = [UIFont systemFontOfSize:14.f];
    switch (type) {
        case EmptyViewTypeNormal:{
            _label.textColor = RGBS(60);
            self.text = @"空数据";
            self.icon = [UIImage imageNamed:@"no-message"];
        }
            break;
        case EmptyViewTypeNoNetwork:{
            self.text = @"页面加载失败~";
            [self.reloadBtn setTitle:@"无网络连接" forState:UIControlStateNormal];
            self.icon = [UIImage imageNamed:@"no-net"];
            break;
        }
        case EmptyViewTypePageLoadFailed:{
            self.text = @"页面加载失败~";
            [self.reloadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
            self.icon = [UIImage imageNamed:@"no-net"];
            break;
        }
        case EmptyViewTypeRefresh:{
            self.text = @"加载失败";
            self.icon = [UIImage imageNamed:@"no-net"];
            break;
        }
        case EmptyViewTypeRefreshPull:{
            self.text = @"加载失败";
            self.icon = [UIImage imageNamed:@"no-net"];
            break;
        }
    }
}

- (void)addTarget:(id)target refreshSelector:(SEL)selector{
    _target = target;
    _refreshSelector = selector;
    [_reloadBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - image category
-(UIImage *)imageWithColor:(UIColor *)aColor{
    return [self imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

-(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark - UIColor category
- (UIColor *)colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
            case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
            case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
            case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
            case 8: // #AARRGGBB
            alpha = [colorString substringToIndex:2].floatValue * 0.01;
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}
- (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

@end
