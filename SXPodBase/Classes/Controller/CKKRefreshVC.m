//
//  CKKRefreshVC.m
//  WisdomTown
//
//  Created by dfpo on 16/8/19.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKRefreshVC.h"

@interface CKKRefreshVC ()

@end

@implementation CKKRefreshVC
#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 都是从1开始的
    self.current_page = 1;
    [self addpull2RefreshWithTableView:self.tableView WithIsInset:NO];
    [self addPush2LoadMoreWithTableView:self.tableView WithIsInset:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - public
- (void)startHeaderRefresh {
    [self pull2RefreshWithScrollerView:self.tableView];
}

- (void)loadDataAtPage:(NSInteger)page {
    NSAssert(NO, @"子类必须重写此方法");
#if 0
    [[CKKNetManager manager] postWithAPI:@"Local/localNews" params:@{@"page": page} needCache:NO success:^(NSArray *dicts) {
        
        [self endRefreshing];
        
        NSArray *localNews = [WTLocalNews arrayOfModelsFromDictionaries:dicts];
        if (page == 1) {
            [self.localNews removeAllObjects];
        }
        self.footRefreshView.hidden = dicts.count < 20;
        
        self.current_page = page;
        [self.localNews addObjectsFromArray:localNews];
        [self.tableView reloadData];
        
    } failure:^(NSString * _Nullable errorString) {
        [self endRefreshing];
        
        NSLog(@"----%@---", errorString);
    }];
#endif
}

- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView {
    [self loadDataAtPage:1];
}
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView {
    [self loadDataAtPage:self.current_page + 1];
}

@end
