//
//  ViewController.h
//  NewsClientDemo
//
//  Created by Pasco on 15/9/20.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

//背景按钮，菜单栏侧滑时显示，用来遮盖主页面区域，有产生阴影效果，响应单击事件收回菜单栏的作用
@property (nonatomic,strong) UIButton *rootBackgroundButton;

//动画的显示第几个菜单对应的view
- (void)showViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated;

//设置菜单栏的offset
- (void)setMenuOffset:(CGFloat)offset;

@end

