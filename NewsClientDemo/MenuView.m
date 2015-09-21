//
//  MenuView.m
//  SlideMenu
//
//  Created by Pasco on 15/9/6.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "MenuView.h"
#import "MenuSectionView.h"
#define RGB(c,a)    [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:a]
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

@interface MenuView ()

@end
@implementation MenuView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        [self configureViews];
        [self configureShadowsViews];
    }
    return self;
}

- (void)configureViews{
    self.sectionView = [[MenuSectionView alloc] init];
    [self addSubview:self.sectionView];
    

    /*!
     *  @author Pasco, 15-09-16 22:09:11
     *
     *  @brief  这一段很重要的知识点！！！！！！！！！！！！！！！！！！
     *
     *  @param self self
     *
     *  @return
     *
     *  @since 1.0
     */
//    @weakify(self);
//    __weak __typeof__(self) weakSelf = self;
//    [weakSelf.sectionView setDidSelectedIndexBlock:^(NSInteger index) {
//        __strong __typeof__(self) strongSelf = weakSelf;
//        
//        if (strongSelf.didSelectedIndexBlock) {
//            strongSelf.didSelectedIndexBlock(index);
//        }
//        
//    }];
}

- (void)configureShadowsViews{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor colorWithWhite:0.98 alpha:1.000];
    
    self.sectionView.frame = CGRectMake(0, 0, self.frame.size.width, kScreenHeight);
}



@end
