//
//  SXPodBaseViewController.h
//  SXPodBase
//
//  Created by dfpo on 05/18/2017.
//  Copyright (c) 2017 dfpo. All rights reserved.
//

@import UIKit;

@interface SXPodBaseViewController : CKKTableVC

/**
 手动下拉刷新
 */
- (void)startHeaderRefresh;

@property (nonatomic) NSInteger current_page;

- (void)loadDataAtPage:(NSInteger)page;

@end
