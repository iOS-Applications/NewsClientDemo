//
//  NewsFrame.h
//  SlideMenu
//
//  Created by Pasco on 15/9/14.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsFrame : NSObject

@property (nonatomic,strong) NewsModel *news;

@property (nonatomic, assign, readonly) CGRect statusF;
@property (nonatomic, assign, readonly) CGRect titleF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect viewsCountF;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
