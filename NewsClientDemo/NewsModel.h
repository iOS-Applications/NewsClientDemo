//
//  NewsModel.h
//  SlideMenu
//
//  Created by Pasco on 15/9/14.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NewsModel : NSObject

@property (nonatomic,assign) BOOL status;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *viewsCount;

- (id)initWithDict:(NSDictionary *)dict;
+ (id)newsWithDict:(NSDictionary *)dict;

@end
