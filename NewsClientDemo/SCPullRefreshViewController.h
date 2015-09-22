//
//  SCPullRefreshViewController.h
//  v2ex-iOS
//
//  Created by Singro on 4/4/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCBarButtonItem;

@interface SCPullRefreshViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter = isHiddenEnabled) BOOL hiddenEnabled;

@property (nonatomic, assign) CGFloat tableViewInsertTop;
@property (nonatomic, assign) CGFloat tableViewInsertBottom;

@property (nonatomic, strong) SCBarButtonItem *leftBarItem;

@property (nonatomic, copy) void (^refreshBlock)();

- (void)beginRefresh;
- (void)endRefresh;

@property (nonatomic, copy) void (^loadMoreBlock)();

- (void)beginLoadMore;
- (void)endLoadMore;

@property (nonatomic, copy) void (^leftBarButtonBlock)();

@end
