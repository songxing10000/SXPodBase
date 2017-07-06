//
//  CKKTabBarController.h
//  dfpo
//
//  Created by dfpo on 16/4/10.
//  Copyright © 2016年 dfpo. All rights reserved.
//  底部工具条

#import <UIKit/UIKit.h>

extern NSString *const kClassKey;
extern NSString *const kTitleKey;
extern NSString *const kImgKey;
extern NSString *const kSelImgKey;

@interface CKKTabBarController : UITabBarController

@property (nonatomic, class) UIColor *tabBarBackgroundColor;

/**
     @[
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
     ]
 */
@property (nonatomic, class) NSArray<NSDictionary<NSString *, NSString *> *> *childVCInfoDicts;
/**
     @{
             NSFontAttributeName:[UIFont systemFontOfSize:12.0,
             NSForegroundColorAttributeName : [UIColor blackColor]
     ]}
 */
@property (nonatomic, class) NSDictionary *tabBarItemNormalTitleTextAttributes;
/**
     @{
             NSFontAttributeName:[UIFont systemFontOfSize:12.0,
             NSForegroundColorAttributeName : [UIColor blueColor]
      ]}
 */
@property (nonatomic, class) NSDictionary *tabBarItemSelectedTitleTextAttributes;

@end
