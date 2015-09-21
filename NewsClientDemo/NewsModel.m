//
//  NewsModel.m
//  SlideMenu
//
//  Created by Pasco on 15/9/14.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel
/*!
 *  @author Pasco, 15-09-21 09:09:17
 *
 *  @brief  将plist文件中的数据转化成对象
 *
 *  @param dict plist字典
 *
 *  @return NewsModel
 *
 *  @since 1.0
 */
- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.status = dict[@"status"];
        self.title = dict[@"title"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSString *timeString= [dateFormatter stringFromDate:dict[@"time"]];
        
        self.time = timeString;
        self.viewsCount = [NSString stringWithFormat:@"浏览次数: %@",dict[@"viewsCount"]];
    }
    return self;
}

/*!
 *  @author Pasco, 15-09-21 09:09:05
 *
 *  @brief  类方法
 *
 *  @param dict plist字典
 *
 *  @return NewsModel
 *
 *  @since 1.0
 */
+ (id)newsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end
