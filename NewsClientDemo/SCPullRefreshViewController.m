//
//  SCPullRefreshViewController.m
//  v2ex-iOS
//
//  Created by Singro on 4/4/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "SCPullRefreshViewController.h"
#import "FrameAccessor.h"
#import "SCBubbleRefreshView.h"
#import "SCNavigation.h"
#import "SCBarButtonItem.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

//刷新栏的高度
static CGFloat const kRefreshHeight = 44.0f;

@interface SCPullRefreshViewController ()

@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *tableFooterView;

@property (nonatomic, strong) SCBubbleRefreshView *refreshView;
@property (nonatomic, strong) SCBubbleRefreshView *loadMoreView;

@property (nonatomic, assign) BOOL isLoadingMore;
@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, assign) BOOL hadLoadMore;
@property (nonatomic, assign) CGFloat dragOffsetY;

@end

@implementation SCPullRefreshViewController


/*!
 *  @author Pasco, 15-09-03 19:09:30
 *
 *  @brief  初始化参数
 *          刷新后表格第一行距离屏幕顶部的高度 self.tableViewInsertTop = 64 (保留导航栏高度64)
 *          最后一行距离底部的高度 self.tableViewInsertBottom ＝ 0
 *
 *  @param nibNameOrNil   nil
 *  @param nibBundleOrNil nil
 *
 *  @return SCRootViewController
 *
 *  @since 1.0
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.isLoadingMore = NO;
        self.isRefreshing = NO;
        self.hadLoadMore = NO;

        self.tableViewInsertTop = 64;
        self.tableViewInsertBottom = 0;
        
        NSLog(@"SCPullRefreshViewController----%@",[self class]);
        
        
    }
    return self;
}
/*!
 *  @author Pasco, 15-09-03 21:09:33
 *
 *  @brief  添加刷新效果的视图
 *
 *  @since 1.0
 */
- (void)loadView {
    [super loadView];
    
//#ifdef kBubbleAnimation
    
    // bubble animation
    self.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 0}];
    self.refreshView = [[SCBubbleRefreshView alloc] initWithFrame:(CGRect){0, -44, kScreenWidth, 44}];
    self.refreshView.timeOffset = 0.0;
    [self.tableHeaderView addSubview:self.refreshView];
    
    self.tableFooterView = [[UIView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 0}];
    self.loadMoreView = [[SCBubbleRefreshView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, 44}];
    self.loadMoreView.timeOffset = 0.0;
    [self.tableFooterView addSubview:self.loadMoreView];
    
    //配置导航栏的左按钮
    [self configureNavibarItems];
    
}

/*!
 *  @author Pasco, 15-09-21 11:09:17
 *
 *  @brief  配置导航栏的左按钮
 *
 *  @since 1.0
 */
- (void)configureNavibarItems {
    
    self.leftBarItem = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_menu_2"] style:SCBarButtonItemStylePlain handler:^(id sender) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kShowMenuNotification object:nil];
    }];
    
    //    [self.leftBarItem ]
    __weak __typeof__(self) weakSelf = self;
    [weakSelf.leftBarItem setLeftBarButtonBlock:^{
        __strong __typeof__(self) strongSelf = weakSelf;
        if (strongSelf.leftBarButtonBlock) {
            strongSelf.leftBarButtonBlock();
        }
        
    }];
}

#pragma mark - Layout
/*!
 *  @author Pasco, 15-09-04 11:09:41
 *
 *  @brief  viewWillLayoutSubviews:告诉view controller它的view将要加载subviews
 *
 *  @since 1.0
 */

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.000];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.000];
    
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.tableViewInsertTop, 0, self.tableViewInsertBottom, 0);
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置tableView到顶部得高度
    self.tableView.contentInsetTop= 44;
    
    self.sc_navigationItem.leftBarButtonItem = self.leftBarItem;
    
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//#warning SCRootViewController 中已经调用了了tableview的这个方法了
//    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
//    
//}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)dealloc {
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - ScrollViewDelegate
/*!
 *  @author Pasco, 15-09-04 12:09:07
 *
 *  @brief  滑动时执行
 *
 *  @param scrollView scrollView description
 *
 *  @since 1.0
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Refresh
    CGFloat offsetY = -scrollView.contentOffsetY - self.tableViewInsertTop  - 25;
    
    self.refreshView.timeOffset = MAX(offsetY / 60.0, 0);
    
    // LoadMore
    if ((self.loadMoreBlock && scrollView.contentSizeHeight > 300) || !self.hadLoadMore) {
        self.loadMoreView.hidden = NO;
    } else {
        self.loadMoreView.hidden = YES;
    }
    //内容高度没有屏幕高的话，就不刷新
    if (scrollView.contentSizeHeight + scrollView.contentInsetTop < [UIScreen mainScreen].bounds.size.height) {
        return;
    }
    
    CGFloat loadMoreOffset = - (scrollView.contentSizeHeight - self.view.height - scrollView.contentOffsetY + scrollView.contentInsetBottom);
    
    if (loadMoreOffset > 0) {
        self.loadMoreView.timeOffset = MAX(loadMoreOffset / 60.0, 0);
    } else {
        self.loadMoreView.timeOffset = 0;
    }
    
//    // Handle hidden
//    
//    CGFloat dragOffsetY = self.dragOffsetY - scrollView.contentOffsetY;
//    
//    CGFloat contentOffset = scrollView.contentOffsetY + scrollView.contentInsetTop;
//    
//    if (contentOffset < 43) {
//        [self sc_setNavigationBarHidden:NO animated:YES];
//        return;
//    }
//    
//    if (dragOffsetY < - 30) {
//        [self sc_setNavigationBarHidden:YES animated:YES];
//        return;
//    }
//    
//    if (dragOffsetY > 110) {
//        [self sc_setNavigationBarHidden:NO animated:YES];
//        return;
//    }
}



- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.dragOffsetY = scrollView.contentOffsetY;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // Refresh
    CGFloat refreshOffset = -scrollView.contentOffsetY - scrollView.contentInsetTop;
    if (refreshOffset > 60 && self.refreshBlock && !self.isRefreshing) {
        [self beginRefresh];
    }
    
    // loadMore
    CGFloat loadMoreOffset = scrollView.contentSizeHeight - self.view.height - scrollView.contentOffsetY + scrollView.contentInsetBottom;
    if (loadMoreOffset < -60 && self.loadMoreBlock && !self.isLoadingMore && scrollView.contentSizeHeight > [UIScreen mainScreen].bounds.size.height) {
        [self beginLoadMore];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
}

#pragma mark - Public Methods
//refreshBlock的set方法
- (void)setRefreshBlock:(void (^)())refreshBlock {
    _refreshBlock = refreshBlock;
    
    if (self.tableView) {
        self.tableView.tableHeaderView = self.tableHeaderView;
    }
}

/*!
 *  @author Pasco, 15-09-04 17:09:24
 *
 *  @brief  下拉刷新
 *
 *  @since 1.0
 */
- (void)beginRefresh {
    
    if (self.isRefreshing) {
        return;
    }
    
    self.isRefreshing = YES;
    
    [self.refreshView beginRefreshing];
    
    if (self.refreshBlock) {
        self.refreshBlock();
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            //刷新松手后，tableview的高度从松手的位置，0.15秒回弹到下面指定的高度 64+44
            self.tableView.contentInsetTop = kRefreshHeight + self.tableViewInsertTop;
            [self.tableView setContentOffset:(CGPoint){0,- (kRefreshHeight + self.tableViewInsertTop )} animated:NO];
            self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
            
        } completion:^(BOOL finished){
            
        }];
    });
    
}

- (void)endRefresh {
    
    [self.refreshView endRefreshing];
    
    self.isRefreshing = NO;
    //刷新结束后，tableview的高度从刷新时高度64+44，0.15秒回弹到下面指定的高度44
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.contentInsetTop = self.tableViewInsertTop;
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    }];
    
}

/*!
 *  @author Pasco, 15-09-04 17:09:05
 *
 *  @brief  上拉加载
 *
 *  @since 1.0
 */
- (void)beginLoadMore {
    
    [self.loadMoreView beginRefreshing];
    
    self.isLoadingMore = YES;
    self.hadLoadMore = YES;
  
    if (self.loadMoreBlock) {
        self.loadMoreBlock();
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.tableView.contentInsetBottom = kRefreshHeight + self.tableViewInsertBottom;

        } completion:^(BOOL finished){
            
        }];
    });
    
    
}

- (void)endLoadMore {
    
    [self.loadMoreView endRefreshing];
    
    self.isLoadingMore = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.contentInsetBottom =  + self.tableViewInsertBottom;
    }];
    
}

//LoadMore set方法
- (void)setLoadMoreBlock:(void (^)())loadMoreBlock {
    _loadMoreBlock = loadMoreBlock;
    
    if (self.loadMoreBlock && self.tableView) {
        self.tableView.tableFooterView = self.tableFooterView;
    }
    
}

@end
