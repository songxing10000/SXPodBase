//
//  SXOrderTableView.m
//  UITableViewStylePlain
//
//  Created by dfpo on 16/7/19.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKTableVC.h"
#import <Masonry/Masonry.h>
#import "UIScrollView+EmptyDataSet.h"
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
@interface CKKTableVC()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, copy) NSArray *tableViewConstraints;

@end
@implementation CKKTableVC

static MJRefreshHeader *_headRefreshView = nil;
static MJRefreshFooter *_footRefreshView = nil;

+ (MJRefreshHeader *)headRefreshView {

    return _headRefreshView;
}
+ (void)setHeadRefreshView:(MJRefreshHeader *)headRefreshView {
    
    if (headRefreshView != nil) {
        
        _headRefreshView = headRefreshView;
        _headRefreshView.refreshingTarget = self;
        _headRefreshView.refreshingAction = @selector(pull2RefreshWithScrollerView:);
    }
}
+ (MJRefreshFooter *)footRefreshView {
    
    return _footRefreshView;
}
+ (void)setFootRefreshView:(MJRefreshFooter *)footRefreshView {
    
    if (footRefreshView) {
        
        _footRefreshView = footRefreshView;
        _footRefreshView.refreshingTarget = self;
        _headRefreshView.refreshingAction = @selector(push2LoadMoreWithScrollerView:);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
#if 1 // 该项目不启用
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
#endif
    if (self.tableView.superview == nil) {
        
        [self.view addSubview:self.tableView];
    }
    
    if (self.tableView.frame.size.width < 100) {
        // 说明talbeView不是sb或者xib生成的，需要添加约束
        self.tableViewConstraints = [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }

    
//    UIEdgeInsets inset2 = self.tableView.contentInset;
//    inset2.bottom += 113; // 64 + 49 = 113 导航加tabbar偏移量
//    self.tableView.contentInset = inset2;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void)contentSizeCategoryChanged:(NSNotification *)notification {
    [self.tableView reloadData];
}

- (void)uninstallTableViewConstraints {
    [self.tableViewConstraints makeObjectsPerformSelector:@selector(uninstall)];
    self.tableViewConstraints = @[];
}
#pragma mark - <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"No-news"];
}
- (nullable NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"暂无消息";
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15.0],
                                 NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(NO, @"子类必须重写此方法");
    return nil;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSAssert(tableView.rowHeight > 0, @"子类必须重写此方法");
//  return tableView.rowHeight;
//}


#pragma mark MJRefresh下拉刷新
///    添加下拉刷新
- (void)addpull2RefreshWithTableView:(UIScrollView *)tableView WithIsInset:(BOOL)isInset{
    
    
    MJRefreshHeader *header = [[self class ] headRefreshView];
//    [CKKHeaderRefresh headerWithRefreshingTarget:self refreshingAction:@selector(pull2RefreshWithScrollerView:)];
    tableView.mj_header = header;
    _headRefreshView = tableView.mj_header;
    [tableView.mj_header endRefreshing];

#if 0 // 使用自定义的
    // self.tableView 换成了 tableView
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull2RefreshWithScrollerView:)];
    tableView.mj_header = header;
    _headRefreshView = tableView.mj_header;
    [tableView.mj_header endRefreshing];
    // 外观设置
    // 设置文字
    [header setTitle:@"下拉刷新..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:13];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:11];
    // 设置颜色
    header.stateLabel.textColor = [UIColor blackColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
#endif
}

///   添加上提加载
- (void)addPush2LoadMoreWithTableView:(UITableView *)tableView WithIsInset:(BOOL)isInset{
    MJRefreshFooter *footer = [[self class] footRefreshView];
//    [CKKFooterRefresh footerWithRefreshingTarget:self refreshingAction:@selector(push2LoadMoreWithScrollerView:)];
//    [CKKRefresh footerWithRefreshingTarget:self refreshingAction:@selector(push2LoadMoreWithScrollerView:)];
    footer.refreshingTarget = self;
    tableView.mj_footer = footer;
    footer.automaticallyHidden = YES;
    
    _footRefreshView = tableView.mj_footer;
    [tableView.mj_footer endRefreshing];
    // self.tableView 换成了 tableView
#if 0 // 此项目使用自定义
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(push2LoadMoreWithScrollerView:)];
    tableView.mj_footer = footer;
    footer.automaticallyHidden = YES;

    _footRefreshView = tableView.mj_footer;
    [tableView.mj_footer endRefreshing];
    // 设置文字
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"全部加载完毕" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor grayColor];
#endif
}

//下拉刷新
- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView {

//    NSLog(@"----%@---", _cmd);
}

//上提加载
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView {
//    NSLog(@"----%@---", _cmd);
}

- (void)endRefreshing {
    // 如果子类的tableView是myTableView如何停止刷新
    [self.tableView.mj_header endRefreshing];
    [self.headRefreshView endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.footRefreshView endRefreshing];

    
}

#pragma mark - getter and setter
- (UITableView *)tableView
{
    if (!_tableView) {

        _tableView = ({
            
            __block UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
            [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([view isKindOfClass:[UITableView class]] &&
                    view.frame.size.width > 100) {
                    
                    tableView = view;
                    *stop = YES;
                }
            }];

            tableView.estimatedRowHeight = UITableViewAutomaticDimension;
            tableView.translatesAutoresizingMaskIntoConstraints = NO;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = [[UIView alloc] init];
            tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
            tableView.separatorInset = UIEdgeInsetsZero;

            tableView;
        });
    }
    return _tableView;
}
@end
