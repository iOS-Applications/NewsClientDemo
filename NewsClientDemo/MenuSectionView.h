//
//  MenuSectionView.h
//  SlideMenu
//
//  Created by Pasco on 15/9/7.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface MenuSectionView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) ViewController *delegate;


@end
