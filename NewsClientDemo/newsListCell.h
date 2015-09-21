//
//  newsListCell.h
//  SlideMenu
//
//  Created by Pasco on 15/9/11.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsFrame;
@interface newsListCell : UITableViewCell

@property (nonatomic,strong) NewsFrame *newsFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
