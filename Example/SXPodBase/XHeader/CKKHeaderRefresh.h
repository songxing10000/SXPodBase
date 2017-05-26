//
//  CKKXHeaderRefresh.h
//  CKKSJ
//
//  Created by BILL on 2016/12/7.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface CKKHeaderRefresh : MJRefreshHeader


#pragma mark - 特别情况下调用
/**
 特别页面为白色时，需要更改其颜色为白色
 */
@property(weak, nonatomic) UIView * headerFreshView;

@end
