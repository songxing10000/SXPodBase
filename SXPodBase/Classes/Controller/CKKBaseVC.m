//
//  CKKSJBaseVC.m
//  CKK_SJ
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKBaseVC.h"
#import "CKKLoadingView.h"
#import "MBProgressHUD.h"
@interface CKKBaseVC ()
@property (nonatomic, strong) CKKLoadingView *loadingView;

@end

@implementation CKKBaseVC

#pragma mark - life cycle
-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - view life cycel
- (void)loadView {
    [super loadView];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.view.frame = CGRectMake(0, 0, screenW, screenH);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
#if 0 // 最好单独写在需要的控制器页面，父类会调用多次，没必要这样浪费性能
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    if (viewControllerArray.count > 1) {
        
        long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
        UIViewController *previous;
        if (previousViewControllerIndex != NSNotFound) {
            previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
            previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                         initWithTitle:@" "
                                                         style:UIBarButtonItemStylePlain
                                                         target:self.navigationController
                                                         action:@selector(pop)];
        }
    }
#endif
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"----收到了内存警告的页面：%@---", self.title);
}
- (UIView *)topVCView {
    return [self topViewController].view;
}



- (void)addLoading
{
    if(_loadingView.superview)
        return;
    if(!_loadingView)
    {
        _loadingView = [[CKKLoadingView alloc] initWithFrame:self.view.bounds];
        _loadingView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_loadingView];
        
    }
    
    [self.view bringSubviewToFront:_loadingView];
}

- (void)removeLoading
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         _loadingView.alpha = 0;
                     }completion:^(BOOL finished){
                         [_loadingView removeFromSuperview];
                     }];
}

- (CKKEmptyView *)emptyFailedView{
    if (!_emptyFailedView) {
        _emptyFailedView = [[CKKEmptyView alloc] initWithFrame:self.view.bounds];
        _emptyFailedView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_emptyFailedView addTarget:self refreshSelector:@selector(reloadData)];
    }
    return _emptyFailedView;
}
- (void)reloadData {
    
}
- (void)showEmptyViewInView:(UIView *)view withType:(EmptyViewType)type{
    [self showEmptyViewInView:view withFrame:CGRectZero withType:type];
}

- (void)showEmptyViewInView:(UIView *)view withFrame:(CGRect)frame withType:(EmptyViewType)type{
    if ([view isKindOfClass:[UIScrollView class]]) {
        [((UIScrollView *)view) setContentOffset:CGPointZero];
    }
    
    if (![[view subviews] containsObject:self.emptyFailedView]) {
        [view addSubview:self.emptyFailedView];
    }
    if (CGRectEqualToRect(frame, CGRectZero)) {
        self.emptyFailedView.frame = view.bounds;
    }
    else {
        self.emptyFailedView.frame = frame;
    }
    self.emptyFailedView.type = type;
}
- (void)hideEmptyView{
    [_emptyFailedView removeFromSuperview];
}

- (void)showNoNetworkMessageInView:(UIView *)view{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = @"无网络连接";
    [hud hideAnimated:YES afterDelay:2.0];
}

#pragma mark - 快速子类方法，可抽取至分类
- (UIButton *)addRightItemWithTitle:(NSString *)title action:(SEL)action {
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 44);
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    rightButton.titleLabel.contentMode = UIViewContentModeLeft;
    rightButton.contentMode = UIViewContentModeLeft;
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [rightButton sizeToFit];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;

    return rightButton;
}
#pragma mark - 抽取到分类
- (UIViewController*)topViewController {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    
    return result;
}

@end
