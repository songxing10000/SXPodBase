//
//  CKKStaticTVC.m
//  CKK_SJ
//
//  Created by MobileUser on 2016/12/16.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKStaticTVC.h"

@interface CKKStaticTVC ()

@end

@implementation CKKStaticTVC

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
