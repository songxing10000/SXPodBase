//
//  SXOrderTableView.h
//  UITableViewStylePlain
//
//  Created by dfpo on 16/7/19.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKKBaseVC.h"
@class MJRefreshHeader, MJRefreshFooter;
/**
 *  上下联动，下方的子控制器，自包含tableView，可下拉刷新，上拉加载的基类
 */
@interface CKKTableVC : CKKBaseVC <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, class) Class headRefreshViewClass;

@property (nonatomic, class) Class footRefreshViewClass;
/// 下拉刷新视图
@property (nonatomic,readonly) MJRefreshHeader *headRefreshView;
/// 上提刷新视图
@property (nonatomic,readonly) MJRefreshFooter *footRefreshView;
/**
 tableView，没有就生成，有就自动获取sb中的tableView,当然也可以连线
 */
@property (nonatomic) IBOutlet UITableView *tableView;



/// 注册下拉刷新功能，一般只用时第二个参数一律传NO
- (void)addpull2RefreshWithTableView:(UIScrollView *)tableView WithIsInset:(BOOL)isInset;

/// 注册上提加载，第二个参数同上
- (void)addPush2LoadMoreWithTableView:(UIScrollView *)tableView WithIsInset:(BOOL)isInset;
/// 下拉刷新回调
- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView;
/// 上提加载回调
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView;

/**
 结束刷新（下拉、上拉）
 */
- (void)endRefreshing;

/**
 *  移除 `TableView` 所有约束.
 */
- (void)uninstallTableViewConstraints;
@end
/**
 *  如何使用---------------------
    1、子类使用
    [self addPush2LoadMoreWithTableView:self.tableView];
    [self addpull2RefreshWithTableView:self.tableView];
    加入上下拉功能
 
    2、子类实现
    -(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView;
    - (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView;
    定义好自己的当前页码（总页码可选）变量，然后以上两方法里进行判断处理，加载网络请求缓存，时长判断等。
 
    例如
     -(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
     {
     if (_totalPage == 1)
     {
     [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
     }
     else if (_currentPage <_totalPage)
     {
     _currentPage ++;
     
     [self getCollectionData];
     }
     else
     {
     [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
     }
     }
     
     - (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
     {
     _currentPage = 1;
     [_dataSource removeAllObjects];
     [self getCollectionData];
     }

    [self getCollectionData]; 为加载网络数据，成功失败都得调用父类的endRefreshing。

 */
