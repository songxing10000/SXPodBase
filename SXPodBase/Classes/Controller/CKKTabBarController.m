//
//  CKKTabBarController.m
//  dfpo
//
//  Created by dfpo on 16/4/10.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKTabBarController.h"
#import "CKKNavigationController.h"


NSString *const kClassKey  = @"rootVCClassString";
NSString *const kTitleKey  =  @"title";
NSString *const kImgKey    =  @"imageName";
NSString *const kSelImgKey = @"selectedImageName";

@interface CKKTabBarController ()<UITabBarControllerDelegate>


@end

@implementation CKKTabBarController
static UIColor *_tabBarBackgroundColor = nil;
static NSDictionary *_tabBarItemNormalTitleTextAttributes = nil;
static NSDictionary *_tabBarItemSelectedTitleTextAttributes = nil;
static NSArray *_childVCInfoDicts = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.delegate  = self;
    
    NSArray<NSDictionary<NSString *, NSString *> *> *childVCInfoDicts = [self class].childVCInfoDicts;
    if (childVCInfoDicts == nil) {
        
        childVCInfoDicts = @[
                             
                             @{kClassKey  : @"CKKNewHomePageVC",
                               kTitleKey  : @"首页",
                               kImgKey    : @"Main009",
                               kSelImgKey : @"Main008"},
                             
                             @{kClassKey  : @"CKKCarStoreListVC",
                               kTitleKey  : @"门店",
                               kImgKey    : @"Main027",
                               kSelImgKey : @"Main026"},
                             
                             @{kClassKey  : @"CKKUserCenterVC",
                               kTitleKey  : @"我的",
                               kImgKey    : @"Main020",
                               kSelImgKey : @"Main019"}
                             
                             ];
    }
    [childVCInfoDicts enumerateObjectsUsingBlock:^(NSDictionary<NSString *,NSString *> * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {

        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        
        vc.title = dict[kTitleKey];
        vc.tabBarItem.title = vc.title;
        
        CKKNavigationController *nav = [[CKKNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        NSDictionary *normalTitleDict = [self class].tabBarItemNormalTitleTextAttributes;
        NSDictionary *selectedTitleDict = [self class].tabBarItemNormalTitleTextAttributes;
        
        if (normalTitleDict == nil) {
            normalTitleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                NSForegroundColorAttributeName : [UIColor blueColor]};
        }
        [item setTitleTextAttributes:normalTitleDict
                            forState:UIControlStateNormal];
        
        if (selectedTitleDict == nil) {
            selectedTitleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                  NSForegroundColorAttributeName : [UIColor blackColor]};
        }
        [item setTitleTextAttributes:selectedTitleDict
                            forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
    }];
    
    self.selectedIndex = 0;
    self.tabBar.itemSpacing = 0;
    self.tabBar.translucent = NO;
    self.tabBar.itemPositioning = UITabBarItemPositioningFill;
    self.tabBar.itemWidth = [UIScreen mainScreen].bounds.size.width / self.childViewControllers.count;
    
    
    UIColor *tabBarC = [self class].tabBarBackgroundColor;
    if (tabBarC) {
        
        self.tabBar.backgroundColor = tabBarC;
    }
}

#pragma mark - <UITabBarControllerDelegate>
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UINavigationController *)viewController {
    
    
    
//    if ([[viewController.childViewControllers[0] class] isSubclassOfClass:[CKKUserCenterVC class]] && ![CKKLoginManager sharedManager].currentUser.login) {
//                [CKKLoginVC presentByVC:self.navigationController withDismissCompletion:nil];
//        
//        return NO;
//    }
    
    return YES;
}
#pragma mark - getter and setter
+(UIColor *)tabBarBackgroundColor {
    
    return _tabBarBackgroundColor;
}
+ (void)setTabBarBackgroundColor:(UIColor *)tabBarBackgroundColor {
    if (tabBarBackgroundColor != nil) {
        _tabBarBackgroundColor = tabBarBackgroundColor;
    }
}
+ (NSDictionary *)tabBarItemNormalTitleTextAttributes {
    
    return _tabBarItemNormalTitleTextAttributes;
}
+ (void)setTabBarItemNormalTitleTextAttributes:(NSDictionary *)tabBarItemNormalTitleTextAttributes {
    
    if (tabBarItemNormalTitleTextAttributes) {
        
        _tabBarItemNormalTitleTextAttributes = tabBarItemNormalTitleTextAttributes;
    }
}
+ (NSDictionary *)tabBarItemSelectedTitleTextAttributes {
    
    return _tabBarItemSelectedTitleTextAttributes;
}
+ (void)setTabBarItemSelectedTitleTextAttributes:(NSDictionary *)tabBarItemSelectedTitleTextAttributes {
    
    if (tabBarItemSelectedTitleTextAttributes) {
        
        _tabBarItemSelectedTitleTextAttributes = tabBarItemSelectedTitleTextAttributes;
    }
}

+ (NSArray<NSDictionary<NSString *,NSString *> *> *)childVCInfoDicts {
    
    return _childVCInfoDicts;
}
+ (void)setChildVCInfoDicts:(NSArray<NSDictionary<NSString *,NSString *> *> *)childVCInfoDicts {
    
    if (childVCInfoDicts) {
        
        _childVCInfoDicts = childVCInfoDicts;
    }
}
@end
