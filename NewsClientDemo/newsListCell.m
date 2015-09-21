//
//  newsListCell.m
//  SlideMenu
//
//  Created by Pasco on 15/9/11.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "newsListCell.h"
#import "NewsModel.h"
#import "NewsFrame.h"
#define RGB(c,a)    [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:a]
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kTitleFont [UIFont systemFontOfSize:17.0]
#define kTimeFont [UIFont systemFontOfSize:12.0]
#define kViewCountFont [UIFont systemFontOfSize:12.0]

#define kLineColorBlackDark    RGB(0xdbdbdb, 1.0)

#define kFontColorBlackLight   RGB(0x999999, 1.0)
#define kFontColorBlackDark    RGB(0x333333, 1.0)

#define kCellHighlightedColor RGB(0xdbdbdb, 0.6f);
@interface newsListCell ()

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *viewsCountLabel;

//@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *borderLineView;

@end

@implementation newsListCell

/*!
 *  @author Pasco, 15-09-21 11:09:21
 *
 *  @brief  Initializes a table cell with a style and a reuse identifier and returns it to the caller.
 *
 *  @param style           style description
 *  @param reuseIdentifier reuseIdentifier
 *
 *  @return newsListCell
 *
 *  @since 1.0
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configureViews];
    }
    return self;
}

/*!
 *  @author Pasco, 15-09-21 11:09:37
 *
 *  @brief  配置View
 *
 *  @since 1.0
 */
- (void)configureViews{
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.frame = CGRectMake(-7.5, -7.5, 15, 15);
    _statusLabel.transform = CGAffineTransformMakeRotation(M_PI_4);
    _statusLabel.backgroundColor = [UIColor colorWithRed:0.318 green:0.782 blue:1.000 alpha:0.600];
    [self.contentView addSubview:_statusLabel];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = kTitleFont;
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.font = [UIFont systemFontOfSize:12.0];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    _viewsCountLabel = [[UILabel alloc] init];
    _viewsCountLabel.backgroundColor = [UIColor clearColor];
    _viewsCountLabel.font = [UIFont systemFontOfSize:12.0];
    _viewsCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_viewsCountLabel];
    
//    _topLineView                        = [[UIView alloc] init];
//    [self addSubview:_topLineView];
    
    _borderLineView                     = [[UIView alloc] init];
    [self addSubview:_borderLineView];
}
/*!
 *  @author Pasco, 15-09-21 11:09:18
 *
 *  @brief  配置子控件数据
 *
 *  @since 1.0
 */
- (void) settingSubviewsData{
    _borderLineView.backgroundColor = kLineColorBlackDark;
    _titleLabel.textColor = kFontColorBlackDark;
    _timeLabel.textColor = kFontColorBlackLight;
    _viewsCountLabel.textColor = kFontColorBlackLight;
    
    NewsModel *news = _newsFrame.news;
    _titleLabel.text = news.title;
    _timeLabel.text = news.time;
    _viewsCountLabel.text = news.viewsCount;
}

/*!
 *  @author Pasco, 15-09-21 11:09:11
 *
 *  @brief  配置子控件frame
 *
 *  @since 1.0
 */
- (void)settingSubviewsFrame{
    
    _borderLineView.frame   = CGRectMake(0, _newsFrame.cellHeight-0.5, kScreenWidth, 0.5);
//    _topLineView.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
    _titleLabel.frame = _newsFrame.titleF;
    _timeLabel.frame = _newsFrame.timeF;
    _viewsCountLabel.frame = _newsFrame.viewsCountF;
}

/*!
 *  @author Pasco, 15-09-21 11:09:42
 *
 *  @brief  设置新闻frame和data
 *
 *  @param newsFrame newsFrame description
 *
 *  @since 1.0
 */
-(void)setNewsFrame:(NewsFrame *)newsFrame{
    _newsFrame = newsFrame;
//    NSLog(@"setNewsFrame方法");

    [self settingSubviewsFrame];
    [self settingSubviewsData];
}
/*!
 *  @author Pasco, 15-09-21 11:09:45
 *
 *  @brief  Sets the selected state of the cell, optionally animating the transition between states.
 *
 *  @param selected <#selected description#>
 *  @param animated <#animated description#>
 *
 *  @since <#1.0#>
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    UIColor *backbroundColor = [UIColor whiteColor];
    if (selected) {
        
        backbroundColor = kCellHighlightedColor;
        self.backgroundColor = backbroundColor;
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = backbroundColor;
        } completion:^(BOOL finished) {
            [self setNeedsLayout];
        }];
        
    }
}
/*!
 *  @author Pasco, 15-09-21 11:09:31
 *
 *  @brief  Sets the highlighted state of the cell, optionally animating the transition between states.
 *
 *  @param highlighted <#highlighted description#>
 *  @param animated    <#animated description#>
 *
 *  @since <#1.0#>
 */
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    UIColor *backbroundColor = [UIColor whiteColor];
    if (highlighted) {
        backbroundColor = kCellHighlightedColor;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.backgroundColor = backbroundColor;
    }];
    
}

@end



