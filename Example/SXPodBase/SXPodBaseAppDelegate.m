//
//  SXPodBaseAppDelegate.m
//  SXPodBase
//
//  Created by dfpo on 05/18/2017.
//  Copyright (c) 2017 dfpo. All rights reserved.
//

#import "SXPodBaseAppDelegate.h"
#import <SXPodBase/CKKRefreshVC.h>
#import "CKKHeaderRefresh.h"
#import "CKKFooterRefresh.h"
#import "CKKTabBarController.h"
#import "CKKNavigationController.h"
@implementation SXPodBaseAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CKKTableVC.headRefreshViewClass = [CKKHeaderRefresh class];
    CKKTableVC.footRefreshViewClass = [CKKFooterRefresh class];
    
    CKKTabBarController.childVCInfoDicts = @[
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
    CKKTabBarController.tabBarBackgroundColor = [UIColor orangeColor];
    CKKTabBarController.tabBarItemNormalTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]};
    CKKTabBarController.tabBarItemSelectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:12.0]};
    CKKNavigationController.leftBackBarButtonItemImageName = @"Main007";
    CKKNavigationController.needHideNaivgaionBarVCNames = @[@"SXPodBaseViewController"];
    return YES;
}

@end
