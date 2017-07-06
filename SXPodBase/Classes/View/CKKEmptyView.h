//
//  CKKSJBaseVC.m
//  dfpo
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EmptyViewType) {
    
    EmptyViewTypeNormal = 0,    ///< 空数据
    EmptyViewTypeNoNetwork,     ///< 当前网络连接不可用
    EmptyViewTypePageLoadFailed,    ///< 页面加载失败，显示“页面加载失败~”，点击重试
    EmptyViewTypeRefresh,       ///< 页面加载失败，显示“无网络”，点击重试
    EmptyViewTypeRefreshPull,   ///< 页面加载失败，下拉刷新
    
};

/**
 空白view
 */
@interface CKKEmptyView : UIView
@property (nonatomic, readonly) UILabel *label;

@property (nonatomic, strong) UIImage  *icon;
@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, assign) EmptyViewType type;

/**
 重新加载按钮
 */
@property (nonatomic, readonly) UIButton *reloadBtn;

- (void)addTarget:(id)target refreshSelector:(SEL)selector;
@end
