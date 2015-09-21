//
//  MenuSectionCell.h
//  SlideMenu
//
//  Created by Pasco on 15/9/8.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSectionCell : UITableViewCell
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *title;

+ (CGFloat)getCellHeight;
@end
