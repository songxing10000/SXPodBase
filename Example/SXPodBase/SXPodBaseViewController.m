//
//  SXPodBaseViewController.m
//  SXPodBase
//
//  Created by dfpo on 05/18/2017.
//  Copyright (c) 2017 dfpo. All rights reserved.
//

#import "SXPodBaseViewController.h"
#import "MJRefresh.h"
@interface SXPodBaseViewController ()

@end

@implementation SXPodBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 都是从1开始的
    self.current_page = 1;
    [self headRefreshView].refreshingTarget = self;
    [self addpull2RefreshWithTableView:self.tableView WithIsInset:NO];
    [self addPush2LoadMoreWithTableView:self.tableView WithIsInset:NO];
}

#pragma mark - public
- (void)startHeaderRefresh {
    [self pull2RefreshWithScrollerView:self.tableView];
}


- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView {
    [self loadDataAtPage:1];
}
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView {
    [self loadDataAtPage:self.current_page + 1];
}

- (void)loadDataAtPage:(NSInteger)page {

    NSLog(@"---- 页面 -> %@ 开始刷新 ---", NSStringFromClass([self class]));
}
#pragma mark - sf

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}

@end
