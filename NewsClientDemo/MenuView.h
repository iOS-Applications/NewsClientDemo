//
//  MenuView.h
//  SlideMenu
//
//  Created by Pasco on 15/9/6.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuSectionView;

@interface MenuView : UIView

@property (nonatomic,strong) MenuSectionView *sectionView;

@property (nonatomic,copy) void (^MenuBlock)(NSInteger index);

@end
