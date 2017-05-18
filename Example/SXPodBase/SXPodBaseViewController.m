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

- (void)loadDataAtPage:(NSInteger)page {

    [self endRefreshing];
    NSLog(@"---- 页面 -> %@ 开始刷新 ---", NSStringFromClass([self class]));
}
#pragma mark - sf

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UITableViewCell new];
}

@end
