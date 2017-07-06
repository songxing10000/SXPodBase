//
//  CKKSJBaseVC.h
//  dfpo
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKKEmptyView.h"

@interface CKKBaseVC : UIViewController

@property (nonatomic, class) UIColor *defaultBackgroundColor;

/**
 当前最顶顶部的控制器的view
 */
@property (nonatomic) UIView *topVCView;
@property (nonatomic) CKKEmptyView *emptyFailedView;

- (void)addLoading;
- (void)removeLoading;

- (void)showEmptyViewInView:(UIView *)view withType:(EmptyViewType)type;
- (void)showEmptyViewInView:(UIView *)view withFrame:(CGRect)frame withType:(EmptyViewType)type;
- (void)hideEmptyView;

/**
 页面加载失败，重新加载，子类实现此方法
 */
- (void)reloadData;

#pragma mark - 快速子类方法，可抽取至分类

/**
 self.navigationItem.rightBarButtonItem title 事件

 @param title self.navigationItem.rightBarButtonItem的title
 @param action self.navigationItem.rightBarButtonItem的事件
 @return 这个用做rightBarButtonItem的按钮
 */
- (UIButton *)addRightItemWithTitle:(NSString *)title action:(SEL)action;
@end
