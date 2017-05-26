//
//  CKKNavigationController.h
//  Chekuaikuai
//
//  Created by CKK on 16/4/14.
//  Copyright © 2016年 dfpo. All rights reserved.
//  导航栏基类

#import <UIKit/UIKit.h>

@interface CKKNavigationController : UINavigationController

@property (nonatomic, class) NSString *navigationBarBackgroundImageName;
/**
 要重载返回事件重写 pop
 */
@property (nonatomic, class) NSString *leftBackBarButtonItemImageName;

@property (nonatomic, class) NSArray <NSString *> *needHideNaivgaionBarVCNames;

/**
 @{
 NSFontAttributeName:[UIFont systemFontOfSize:18.0,
 NSForegroundColorAttributeName : [UIColor whiteColor]
 ]}
 */
@property (nonatomic, class) NSDictionary *navigatioinBarAppearanceTitleTextAttributes;
/**
 @{
 NSFontAttributeName:[UIFont systemFontOfSize:15.0,
 NSForegroundColorAttributeName : [UIColor whiteColor]
 ]}
 */
@property (nonatomic, class) NSDictionary *navigatioinBarAppearanceBarItemTitleTextAttributes;

/**
 设置完以上属性之后，配置此方法即可
 */
+ (void)cutomAppearance;
@end
