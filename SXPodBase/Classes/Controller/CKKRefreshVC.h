//
//  CKKRefreshVC.h
//  WisdomTown
//
//  Created by dfpo on 16/8/19.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKTableVC.h"

/// 自带下拉刷新，上拉加载
@interface CKKRefreshVC : CKKTableVC

/**
 手动下拉刷新
 */
- (void)startHeaderRefresh;

@property (nonatomic) NSInteger current_page;

- (void)loadDataAtPage:(NSInteger)page;

@end
/*
 如何使用：
 
 一、继承CKKRefreshVC
 
 二、实现方法
 
 - (void)loadDataAtPage:(NSInteger)page;
 
 咨询订单列表 示范
 - (void)loadDataAtPage:(NSInteger)page {
 
     NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     parameters[@"phoneNumber"] =   [CKKLoginManager sharedManager].currentLoginData.phoneNum;
     
     NSString *url = [NSString stringWithFormat:@"%@?page=%tu",app_consult_list,page];
     
     [[CKKNetManager manager] get:url params:parameters    success:^(id  _Nullable responseObject) {
     ///
     [self endRefreshing];
     NSArray *dicts = responseObject[@"data"];
     NSArray *CKKConsults = [CKKConsultItem arrayOfModelsFromDictionaries:dicts];
     if (page == 1) {
     [self.consultList removeAllObjects];
     }
     self.footRefreshView.hidden = dicts.count < 20;
     
     self.current_page = page;
     [self.consultList addObjectsFromArray:CKKConsults];
     [self.tableView reloadData];
     
     } failure:^(NSString * _Nullable errorString) {
     NSLog(@"----%@---", errorString);
     [self endRefreshing];
     }];
 }

 */
