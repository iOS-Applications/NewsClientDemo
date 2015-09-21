//
//  undergraduateViewController.m
//  SlideMenu
//
//  Created by Pasco on 15/9/10.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "undergraduateViewController.h"
#import "SCNavigation.h"
#import "newsListCell.h"
#import "NewsFrame.h"
#import "NewsModel.h"
@interface undergraduateViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSMutableArray *newsFrames;
@end

@implementation undergraduateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"undergraduateModel.plist" ofType:nil]];
    
    _newsFrames = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NewsFrame *newsFrame = [[NewsFrame alloc] init];
        newsFrame.news = [NewsModel newsWithDict:dict];
        [_newsFrames addObject:newsFrame];
        //        NSLog(@"%@",dict);
    }
    
    __weak typeof(undergraduateViewController) *weakSelf = self;
    
    //下拉想做什么？在这里设置吧
    self.refreshBlock = ^{
        
        __strong typeof(undergraduateViewController) *strongSelf = weakSelf;
        
        [strongSelf performSelector:@selector(endRefresh) withObject:strongSelf afterDelay:2.0];
        
    };
    
    //上拉想做什么？在这里设置吧
    self.loadMoreBlock = ^{
        
        __strong typeof(undergraduateViewController) *strongSelf = weakSelf;
        
        [strongSelf performSelector:@selector(endLoadMore) withObject:strongSelf afterDelay:2.0];
        
    };
    
    self.sc_navigationItem.leftBarButtonItem = self.leftBarItem;
    self.sc_navigationItem.title = @"本科教学";
    
}
- (void)loadView{
    [super loadView];
    [self configureTableView];
    [self configureNavibarItems];
}

- (void)configureNavibarItems {
    
    self.leftBarItem = [[SCBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_menu_2"] style:SCBarButtonItemStylePlain handler:^(id sender) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:kShowMenuNotification object:nil];
    }];
    
    //    [self.leftBarItem ]
}

- (void)configureBlocks {
    
}

- (void)configureTableView {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.frame];
    //    self.tableView.backgroundColor = kBackgroundColorWhiteDark;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    [self.view addSubview:self.tableView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_newsFrames[indexPath.row] cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";
    newsListCell *cell = (newsListCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[newsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.newsFrame = _newsFrames[indexPath.row];
    //cell.reuseIdentifier;
    //NSLog(@"%@",cell.reuseIdentifier);
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
