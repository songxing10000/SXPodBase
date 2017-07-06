//
//  CKKStaticTVC.m
//  dfpo
//
//  Created by dfpo on 2016/12/16.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKStaticTVC.h"

@interface CKKStaticTVC ()

@end

@implementation CKKStaticTVC
static UIColor *_defaultBackgroundColor = nil;
+ (UIColor *)defaultBackgroundColor {
    
    return _defaultBackgroundColor;
}
+(void)setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor {
    if (defaultBackgroundColor != nil) {
        
        _defaultBackgroundColor = defaultBackgroundColor;
    }
}

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *dc = [self class].defaultBackgroundColor;
    if (dc) {
        
        self.view.backgroundColor = dc;
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.tableView endEditing:YES];
}
#pragma mark - UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section NS_REQUIRES_SUPER {
    return 15.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section NS_REQUIRES_SUPER {
    return 0.01f;
}
@end
