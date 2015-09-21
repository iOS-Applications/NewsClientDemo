//
//  MenuSectionView.m
//  SlideMenu
//
//  Created by Pasco on 15/9/7.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "MenuSectionView.h"
#import "MenuSectionCell.h"
#import "ViewController.h"
//static CGFloat const kAvatarWidth = 70.0f;
@interface MenuSectionView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *sectionImageNameArray;
@property (nonatomic,strong) NSArray *sectionTitleArray;
@property (nonatomic,strong) UIImageView *avatarImageView;
@property (nonatomic,strong) UIImageView *divideImageView;

@end

@implementation MenuSectionView

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
        self.sectionImageNameArray = @[@"section_lastest", @"section_alert", @"section_exchange", @"section_undergraduate", @"section_graduate", @"section_research",@"section_network", @"section_collection", @"section_set"];
        self.sectionTitleArray = @[@"最新资讯", @"新闻通知", @"学术交流", @"本科教学", @"研究生教学", @"科研信息", @"网络中心", @"我的收藏", @"设置"];
        
        [self configureTableView];
        //[self configureProfileView];
        
    }
    return self;
}

- (void) layoutSubviews{
//    self.avatarImageView.frame = CGRectMake(30, 30, kAvatarWidth, kAvatarWidth);
//    self.divideImageView.frame = CGRectMake(-self.frame.size.width, kAvatarWidth + 50, self.frame.size.width * 2, 0.5);
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //NSLog(@"%f",self.tableView.contentInset.top);
    
}


- (void)configureTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    UIEdgeInsets edgeInsets = self.tableView.contentInset;
//    edgeInsets.top = 120;
//    self.tableView.contentInset = edgeInsets;
    //NSLog(@"%f",self.tableView.contentInset.top);
    
    [self addSubview:self.tableView];
}

//- (void)configureProfileView{
//    self.avatarImageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_default"]];
//    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.avatarImageView.clipsToBounds = YES;
//    self.avatarImageView.layer.cornerRadius = 5;
//    self.avatarImageView.layer.borderColor = [UIColor grayColor].CGColor;
//    self.avatarImageView.layer.borderWidth = 1.0f;
//    [self addSubview:self.avatarImageView];
//    
//    self.divideImageView = [[UIImageView alloc] init];
//    self.divideImageView.backgroundColor = [UIColor grayColor];
//    self.divideImageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.divideImageView.clipsToBounds = YES;
//    [self addSubview:self.divideImageView];
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sectionTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    MenuSectionCell *cell = (MenuSectionCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    return [self configureWithCell:cell IndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MenuSectionCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
#warning 可能存在循环应用，回头再看看
    [_delegate showViewControllerAtIndex:indexPath.row animated:YES];

}

- (MenuSectionCell *)configureWithCell:(MenuSectionCell *)cell IndexPath:(NSIndexPath *)indexPath {
    
    cell.imageName = self.sectionImageNameArray[indexPath.row];
    cell.title     = self.sectionTitleArray[indexPath.row];

    return cell;
    
}
/*!
 *  @author Pasco, 15-09-19 14:09:17
 *
 *  @brief  设置默认选中第一行
 *
 *  @since 1.0
 */
@end
