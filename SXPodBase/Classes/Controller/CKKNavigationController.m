//
//  CKKNavigationController.m
//  dfpo
//
//  Created by dfpo on 16/4/14.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKNavigationController.h"
#import <objc/runtime.h>
@interface CKKNavigationController ()<UINavigationControllerDelegate>

@end

@implementation CKKNavigationController
static NSString *_navigationBarBackgroundImageName = nil;
static NSString *_leftBackBarButtonItemImageName = nil;
static NSArray<NSString *> *_needHideNaivgaionBarVCNames = nil;
static NSDictionary *_navigatioinBarAppearanceTitleTextAttributes = nil;
static NSDictionary *_navigatioinBarAppearanceBarItemTitleTextAttributes = nil;

#pragma  mark - life cycle

//+ (void)initialize {
+ (void)cutomAppearance {
    
    [[UINavigationBar appearance] setTranslucent:NO];
    
    NSDictionary *titleAttributeDict = [self class].navigatioinBarAppearanceTitleTextAttributes;;
    if (titleAttributeDict == nil) {
        
        titleAttributeDict = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                               NSFontAttributeName:[UIFont systemFontOfSize:18.0]};
    }
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttributeDict];
    
    NSString *navigationBarBackgroundImageName = [self class].navigationBarBackgroundImageName;
    UIImage *navigationBarBackgroundImage = [UIImage imageNamed:navigationBarBackgroundImageName];
    if (navigationBarBackgroundImage) {
        
        [[UINavigationBar appearance] setBackgroundImage:[navigationBarBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                          forBarPosition:UIBarPositionAny
                                              barMetrics:UIBarMetricsDefault];
    }
    
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // UIBarButtonItem
    UIBarButtonItem *item=[UIBarButtonItem appearance];
    item.tintColor = [UIColor whiteColor];
    
    NSDictionary *itemAttributeDict= [self class].navigatioinBarAppearanceBarItemTitleTextAttributes;
    if (itemAttributeDict == nil) {
        
        itemAttributeDict= @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                             NSForegroundColorAttributeName : [UIColor whiteColor]};
    }
    
    [item setTitleTextAttributes:itemAttributeDict forState:UIControlStateNormal];
    
    // backItem 这里设置全局返回按钮，不够灵活，美工给的图不到位的话，很难调整
    //        UIImage *originImage = [UIImage imageNamed:@"navback"];
    //        UIEdgeInsets insets = UIEdgeInsetsMake(0.0f, -10.0f, 0.0f, -10.0f);
    //        UIColor *fillColor = [UIColor clearColor];
    //        UIImage *backButtonImage = [originImage imageByInsetEdge:insets withColor:fillColor];
    //        [item setBackButtonBackgroundImage:[originImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18, 0, 0) ]
    //                                  forState:UIControlStateNormal
    //                                barMetrics:UIBarMetricsDefault];
    
    
    //    UIOffset minOffset =
    //    UIOffsetMake(NSIntegerMin, NSIntegerMin);
    //    [item setBackButtonTitlePositionAdjustment:minOffset
    //                                 forBarMetrics:UIBarMetricsDefault];
    
}
#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  whiteColor];
    self.delegate = self;
}
#pragma mark - Private Methods
#pragma mark -
#pragma mark Whether need Navigation Bar Hidden
- (BOOL) needHiddenBarInViewController:(UIViewController *)viewController {
    
    BOOL needHideNaivgaionBar = NO;
    
    NSArray <NSString *> *needHideNaivgaionBarVCNames = [self class].needHideNaivgaionBarVCNames;
    for (NSString *vcName in needHideNaivgaionBarVCNames) {
        
        if (NSClassFromString(vcName) &&
            [vcName isKindOfClass:[NSString class]] &&
            [viewController isKindOfClass:NSClassFromString(vcName)]) {
            
            needHideNaivgaionBar = YES;
        }
    }
    
    return needHideNaivgaionBar;
}
#pragma mark - UINaivgationController Delegate
#pragma mark -
#pragma mark Will Show ViewController
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 在 NavigationController 的这个代理方法中, 设置导航栏的隐藏和显示
    [self setNavigationBarHidden: [self needHiddenBarInViewController: viewController]
                        animated: animated];
}

- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (![self.visibleViewController isKindOfClass:[UIAlertController class]]) {//iOS9 UIWebRotatingAlertController
        return [self.visibleViewController supportedInterfaceOrientations];
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 相同页面不允许push两次
    if ([self.topViewController isKindOfClass:[viewController class]]) {
        return;
    }
    
    // 开始push画页
    if (self.viewControllers.count) {
        
        // 这里设置返回按钮，理灵活些
        viewController.navigationItem.leftBarButtonItem =
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [[UIBarButtonItem alloc] initWithImage:[self getBackBarImage]
                                         style:UIBarButtonItemStyleDone
                                        target:viewController
                                        action:@selector(pop)];
#pragma clang diagnostic pop
        // 重写pop可拦截返回事件
        // 调整左右位置
        /*
         // 返回按钮内容左靠
         button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         // 让返回按钮内容继续向左边偏移10
         button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
         viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
         */
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

- (UIImage *)getBackBarImage {
    
    NSString *backImageName = [self class].leftBackBarButtonItemImageName;
    UIImage *backImage = [UIImage imageNamed:backImageName];
    if (backImage ) {
        
        return [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    NSBundle *selfClassBundle = [NSBundle bundleForClass:[self class]];
    NSString *podBundlePath = [selfClassBundle pathForResource:@"SXPodBase" ofType:@"bundle"];
    NSBundle *podBundle = [NSBundle bundleWithPath:podBundlePath];
    
    backImageName = @"jt3-icon@2x";
    if ([[UIScreen mainScreen] bounds].size.height == 736) {
        
        backImageName = @"jt3-icon@3x";
    }
    NSString *backImagePath = [podBundle pathForResource:backImageName ofType:@"png"];
    UIImage *leftBackBarButtonItemImage = 
    [[UIImage imageWithContentsOfFile:backImagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return leftBackBarButtonItemImage;
}
#pragma mark - getter and setter
+ (NSString *)navigationBarBackgroundImageName {
    
    return _navigationBarBackgroundImageName;
}
+ (void)setNavigationBarBackgroundImageName:(NSString *)navigationBarBackgroundImageName {
    
    if (navigationBarBackgroundImageName && navigationBarBackgroundImageName.length) {
        
        _navigationBarBackgroundImageName = navigationBarBackgroundImageName;
    }
}
+ (NSString *)leftBackBarButtonItemImageName {
    return _leftBackBarButtonItemImageName;
}
+ (void)setLeftBackBarButtonItemImageName:(NSString *)leftBackBarButtonItemImageName {
   
    if (leftBackBarButtonItemImageName && leftBackBarButtonItemImageName.length) {
        
        _leftBackBarButtonItemImageName = leftBackBarButtonItemImageName;
    }
}
+ (NSArray<NSString *> *)needHideNaivgaionBarVCNames {
    
    return _needHideNaivgaionBarVCNames;
}
+ (void)setNeedHideNaivgaionBarVCNames:(NSArray<NSString *> *)needHideNaivgaionBarVCNames {
    if (needHideNaivgaionBarVCNames) {
        
        _needHideNaivgaionBarVCNames = needHideNaivgaionBarVCNames;
    }
}
+(NSDictionary *)navigatioinBarAppearanceTitleTextAttributes {
    
    return _navigatioinBarAppearanceTitleTextAttributes;
}
+ (void)setNavigatioinBarAppearanceTitleTextAttributes:(NSDictionary *)navigatioinBarAppearanceTitleTextAttributes {
    
    if (navigatioinBarAppearanceTitleTextAttributes && [navigatioinBarAppearanceTitleTextAttributes.allKeys count]) {
        
        _navigatioinBarAppearanceTitleTextAttributes = navigatioinBarAppearanceTitleTextAttributes;
    }
}
+ (NSDictionary *)navigatioinBarAppearanceBarItemTitleTextAttributes {
    
    return _navigatioinBarAppearanceBarItemTitleTextAttributes;
}
+ (void)setNavigatioinBarAppearanceBarItemTitleTextAttributes:(NSDictionary *)navigatioinBarAppearanceBarItemTitleTextAttributes {
    if (navigatioinBarAppearanceBarItemTitleTextAttributes && [navigatioinBarAppearanceBarItemTitleTextAttributes allKeys].count) {
        
        _navigatioinBarAppearanceBarItemTitleTextAttributes = navigatioinBarAppearanceBarItemTitleTextAttributes;
    }
}
@end
@implementation UIViewController (SXPodBase_pop)

void dynamicMethodIMP(UINavigationController *self, SEL _cmd) {

    if ([self isKindOfClass:[UINavigationController class]]) {
        
        [self popViewControllerAnimated:YES];
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

+ (BOOL) resolveInstanceMethod:(SEL)aSEL {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (aSEL == @selector(pop)) {
#pragma clang diagnostic pop
        
        class_addMethod([self class], aSEL, (IMP) dynamicMethodIMP, "v@:");
        
        return YES;
        
    }
    
    return [super resolveInstanceMethod:aSEL];
}
@end
