//
//  NewsFrame.m
//  SlideMenu
//
//  Created by Pasco on 15/9/14.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "NewsFrame.h"
#import "NewsModel.h"
//屏幕宽高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//标题、时间、浏览次数的字体
#define kTitleFont [UIFont systemFontOfSize:17.0]
#define kTimeFont [UIFont systemFontOfSize:12.0]
#define kViewCountFont [UIFont systemFontOfSize:12.0]


@implementation NewsFrame
/*!
 *  @author Pasco, 15-09-21 11:09:41
 *
 *  @brief  手动实现setNews方法，顺便把每个控件的frame也计算出来
 *
 *  @param news newModel
 *
 *  @since 1.0
 */
- (void)setNews:(NewsModel *)news{
    _news = news;
//    NSLog(@"setNews方法");
    
    CGRect titleLabelRect = [news.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, MAXFLOAT)
                                                               options:NSStringDrawingUsesLineFragmentOrigin
                                                            attributes:[NSDictionary dictionaryWithObjectsAndKeys:kTitleFont,NSFontAttributeName, nil]
                                                               context:nil];
    
    _titleF = CGRectMake(10, 15, kScreenWidth - 20, titleLabelRect.size.height);
    
    CGFloat titleLabelMaxY = CGRectGetMaxY(_titleF);
    
    
//    CGSize timeLabelSize = [news.time sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kTimeFont,NSFontAttributeName, nil]];
    CGRect timeLabelRect = [news.time boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:[NSDictionary dictionaryWithObjectsAndKeys:kTimeFont,NSFontAttributeName, nil] context:nil];
    
    _timeF = CGRectMake(20, titleLabelMaxY + 20, timeLabelRect.size.width, timeLabelRect.size.height);
//    NSLog(@"timeF----%f-----%f----%f----%f",0.0,titleLabelMaxY, timeLabelRect.size.width,timeLabelRect.size.height);
    
    CGRect viewsCountLabelRect = [news.viewsCount boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:[NSDictionary dictionaryWithObjectsAndKeys:kViewCountFont,NSFontAttributeName, nil]
                                                         context:nil];

    _viewsCountF = CGRectMake(kScreenWidth - 20 - viewsCountLabelRect.size.width,
                              _timeF.origin.y,
                              viewsCountLabelRect.size.width,
                              viewsCountLabelRect.size.height);
    
//    NSLog(@"viewsCountF----%f-----%f----%f----%f",kScreenWidth - 20 - viewsCountLabelRect.size.width,_timeF.origin.y, viewsCountLabelRect.size.width,viewsCountLabelRect.size.height);
    
    
    _cellHeight = CGRectGetMaxY(_viewsCountF) + 10;
    
}
@end
