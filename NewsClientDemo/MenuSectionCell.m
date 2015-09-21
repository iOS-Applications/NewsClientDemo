//
//  MenuSectionCell.m
//  SlideMenu
//
//  Created by Pasco on 15/9/8.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "MenuSectionCell.h"
//#import "UIImage+Tint.h"

#define RGB(c,a)    [UIColor colorWithRed:((c>>16)&0xFF)/256.0  green:((c>>8)&0xFF)/256.0   blue:((c)&0xFF)/256.0   alpha:a]
#define kColorBlue    RGB(0x3fb7fc, 1.0)
#define kFontColorBlackMid      RGB(0x777777, 1.0)
#define kMenuCellHighlightedColor     RGB(0xf6f6f6,1.0)

static CGFloat const kCellHeight = 60;
static CGFloat const kFontSize   = 16;

@interface MenuSectionCell ()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *highlightedImage;

@property (nonatomic,assign) BOOL cellHighlighted;
@end

@implementation MenuSectionCell
/*!
 *  @author Pasco, 15-09-21 11:09:47
 *
 *  @brief  获得cell高度
 *
 *  @return <#return value description#>
 *
 *  @since <#1.0#>
 */
+ (CGFloat)getCellHeight{
    return kCellHeight;
}

/*!
 *  @author Pasco, 15-09-21 11:09:16
 *
 *  @brief  Initializes a table cell with a style and a reuse identifier and returns it to the caller.
 *
 *  @param style           <#style description#>
 *  @param reuseIdentifier <#reuseIdentifier description#>
 *
 *  @return <#return value description#>
 *
 *  @since <#1.0#>
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        [self configureViews];
    }
    return self;
}

- (void)configureViews{
    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.iconImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = kFontColorBlackMid;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font            = [UIFont systemFontOfSize:kFontSize];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconImageView.frame = CGRectMake(30, 21, 18, 18);
    self.titleLabel.frame = CGRectMake(85, 0, 110, self.frame.size.height);
    
}

- (void)awakeFromNib {
    // Initialization code
}

/*!
 *  @author Pasco, 15-09-08 16:09:12
 *
 *  @brief  Sets the selected state of the cell, optionally animating the transition between states.
 *
 *  @param selected <#selected description#>
 *  @param animated <#animated description#>
 *
 *  @since <#1.0#>
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.cellHighlighted = selected;
    } completion:nil];

    // Configure the view for the selected state
}

/*!
 *  @author Pasco, 15-09-08 16:09:16
 *
 *  @brief  Sets the highlighted state of the cell, optionally animating the transition between states.
 *
 *  @param highlighted (BOOL)isHighlighted
 *  @param animated    (BOOL)animated
 *
 *  @since 1.0
 */
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.isSelected) {
        return;
    }
    
    [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.cellHighlighted = highlighted;
    } completion:nil];
}

#pragma mark - 重写set方法

/*!
 *  @author Pasco, 15-09-08 16:09:08
 *
 *  @brief  重写属性cellHighlied的set方法
 *
 *  @param cellHighlighted BOOL类型
 *
 *  @since 1.0
 */
- (void)setCellHighlighted:(BOOL)cellHighlighted {
    _cellHighlighted = cellHighlighted;
    
    if (cellHighlighted) {
        self.titleLabel.textColor = kColorBlue;
        self.backgroundColor = kMenuCellHighlightedColor;
        self.iconImageView.image = self.highlightedImage;
        
    } else {
        self.titleLabel.textColor = kFontColorBlackMid;
        self.backgroundColor = [UIColor clearColor];
        self.iconImageView.image = self.normalImage;
    }
    
}

/*!
 *  @author Pasco, 15-09-21 11:09:42
 *
 *  @brief  设置标题
 *
 *  @param title <#title description#>
 *
 *  @since <#1.0#>
 */
- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.titleLabel.text = self.title;
    
}
/*!
 *  @author Pasco, 15-09-21 11:09:00
 *
 *  @brief  设置图标
 *
 *  @param imageName <#imageName description#>
 *
 *  @since <#1.0#>
 */
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    
    NSString *highlightedImageName = [self.imageName stringByAppendingString:@"_highlighted"];
    
    self.highlightedImage= [UIImage imageNamed:highlightedImageName];
    self.normalImage  = [UIImage imageNamed:self.imageName];

    self.iconImageView.alpha = 1;
    
}

@end
