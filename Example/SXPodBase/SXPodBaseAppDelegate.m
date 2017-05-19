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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
