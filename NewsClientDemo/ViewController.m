//
//  ViewController.m
//  SlideMenu
//
//  Created by Pasco on 15/9/6.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//
#import "FrameAccessor.h"

#import "ViewController.h"
#import "MenuView.h"
#import "MenuSectionView.h"
#import "SCNavigation.h"

#import "SCPullRefreshViewController.h"

#import "lastestViewController.h"
#import "alertViewController.h"
#import "exchangeViewController.h"
#import "undergraduateViewController.h"
#import "graduateViewController.h"
#import "researchViewController.h"
#import "networkViewController.h"
#import "collectionViewController.h"

//宏定义屏幕宽高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

//设置侧滑菜单栏的宽度
static CGFloat const kMenuWidth = 240.0;

@interface ViewController ()<UIGestureRecognizerDelegate>

//所有的控件都放在viewControllerContainView上面
@property (nonatomic,strong) UIView *viewControllerContainView;

//添加三种手势
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *edgePanRecognizer;
@property (nonatomic,strong) UIPanGestureRecognizer *panRecognizer;

//菜单栏
@property (nonatomic,strong) MenuView *menuView;

//声明8个菜单对应的view，
@property (nonatomic,strong) SCNavigationController *lastestNavigationController;
@property (nonatomic,strong) lastestViewController *lastestPullRefreshController;

@property (nonatomic,strong) SCNavigationController *alertNavigationController;
@property (nonatomic,strong) alertViewController *alertPullRefreshController;

@property (nonatomic,strong) SCNavigationController *exchangeNavigationController;
@property (nonatomic,strong) exchangeViewController *exchangePullRefreshController;

@property (nonatomic,strong) SCNavigationController *undergraduateNavigationController;
@property (nonatomic,strong) undergraduateViewController *undergraduatePullRefreshController;

@property (nonatomic,strong) SCNavigationController *graduateNavigationController;
@property (nonatomic,strong) graduateViewController *graduatePullRefreshController;

@property (nonatomic,strong) SCNavigationController *researchNavigationController;
@property (nonatomic,strong) researchViewController *researchPullRefreshController;

@property (nonatomic,strong) SCNavigationController *networkNavigationController;
@property (nonatomic,strong) networkViewController *networkPullRefreshController;

@property (nonatomic,strong) SCNavigationController *collectionNavigationController;
@property (nonatomic,strong) collectionViewController *collectionPullRefreshController;

@property (nonatomic,strong) SCNavigationController *setNavigationController;
@property (nonatomic,strong) SCPullRefreshViewController *setPullRefreshController;

//当前选择的是第几个菜单
@property (nonatomic, assign) NSInteger currentSelectedIndex;

@end

@implementation ViewController

/*!
 *  @author Pasco, 15-09-06 18:09:48
 *
 *  @brief  初始化controller，设置当前页的值默认为0
 *
 *  @param nibNameOrNil   nibNameOrNil description
 *  @param nibBundleOrNil nibBundleOrNil description
 *
 *  @return return value description
 *
 *  @since 1.0
 */


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.currentSelectedIndex = 0;
    }
    return self;
}
/*!
 *  @author Pasco, 15-09-20 11:09:28
 *
 *  @brief  Creates the view that the controller manages.
 *
 *  @since 1.0
 */
- (void)loadView{
    [super loadView];
    //配置viewController
    [self configureViewControllers];
    //配置view
    [self configureView];
}
/*!
 *  @author Pasco, 15-09-20 11:09:18
 *
 *  @brief  Called to notify the view controller that its view is about to layout its subviews.
 *
 *  @since 1.0
 */
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.rootBackgroundButton.frame = self.view.frame;
}

/*!
 *  @author Pasco, 15-09-20 11:09:34
 *
 *  @brief  Called after the controller's view is loaded into memory.
 *
 *  @since 1.0
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //配置手势
    [self configureGestures];
}
/*!
 *  @author Pasco, 15-09-20 11:09:22
 *
 *  @brief  Notifies the view controller that its view is about to be added to a view hierarchy.
 *
 *  @param animated
 *
 *  @since 1.0
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tapRecognizer.delegate = self;
    self.edgePanRecognizer.delegate = self;
    self.panRecognizer.delegate = self;
}

/*!
 *  @author Pasco, 15-09-20 11:09:25
 *
 *  @brief  Notifies the view controller that its view was added to a view hierarchy
 *
 *  @param animated animated description
 *
 *  @since 1.0
 */
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 *  @author Pasco, 15-09-20 11:09:43
 *
 *  @brief  配置ViewController
 *
 *  @since 1.0
 */
- (void)configureViewControllers{
    //self.lastestViewController = [[UIViewController alloc] init];
//    self.rootBackgroundButton.frame = self.view.frame;
    self.viewControllerContainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:self.viewControllerContainView];
    
    self.lastestPullRefreshController = [[lastestViewController alloc] init];
    self.alertPullRefreshController = [[alertViewController alloc] init];
    self.exchangePullRefreshController = [[exchangeViewController alloc] init];
    self.undergraduatePullRefreshController = [[undergraduateViewController alloc] init];
    self.graduatePullRefreshController = [[graduateViewController alloc] init];
    self.researchPullRefreshController = [[researchViewController alloc] init];
    self.networkPullRefreshController =[[networkViewController alloc] init];
    self.collectionPullRefreshController = [[collectionViewController alloc] init];
    
    self.lastestNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.lastestPullRefreshController];
    self.alertNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.alertPullRefreshController];
    self.exchangeNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.exchangePullRefreshController];
    self.undergraduateNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.undergraduatePullRefreshController];
    self.graduateNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.graduatePullRefreshController];
    self.researchNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.researchPullRefreshController];
    self.networkNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.networkPullRefreshController];
    self.collectionNavigationController = [[SCNavigationController alloc] initWithRootViewController:self.collectionPullRefreshController];
    
    
    self.lastestPullRefreshController.leftBarItem.delegate = self;
    self.alertPullRefreshController.leftBarItem.delegate = self;
    self.exchangePullRefreshController.leftBarItem.delegate = self;
    self.undergraduatePullRefreshController.leftBarItem.delegate = self;
    self.graduatePullRefreshController.leftBarItem.delegate = self;
    self.researchPullRefreshController.leftBarItem.delegate = self;
    self.networkPullRefreshController.leftBarItem.delegate = self;
    self.collectionPullRefreshController.leftBarItem.delegate = self;
    
    [self.viewControllerContainView addSubview:[self viewControllerForIndex:self.currentSelectedIndex].view];
    
}
- (void)configureView{

    self.rootBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rootBackgroundButton.alpha = 0.0;
    self.rootBackgroundButton.backgroundColor = [UIColor blackColor];
    self.rootBackgroundButton.hidden = YES;
    [self.viewControllerContainView addSubview:self.rootBackgroundButton];
    
    self.menuView = [[MenuView alloc] initWithFrame:CGRectMake(-kMenuWidth, 0, kMenuWidth, kScreenHeight)];
    //设置代理（简单代理，以后有机会再优化，估计没机会了）这里好像会循环引用吧！
    self.menuView.sectionView.delegate = self;
    //设置menu默认选择第一行
    [self.menuView.sectionView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    [self.view addSubview:self.menuView];
    
    //    [sekf.menuView.sectionView ]
}

/*!
 *  @author Pasco, 15-09-20 11:09:07
 *
 *  @brief  配置手势：self.view添加屏幕边缘侧滑手势、self.rootBackgroundButton添加拖动手势 和 点击手势
 *
 *  @since 1.0
 */
- (void)configureGestures {
    self.edgePanRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleEdgePanRecognizer:)];
    self.edgePanRecognizer.edges = UIRectEdgeLeft;
    self.edgePanRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.edgePanRecognizer];
    
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    self.panRecognizer.delegate =self;
    [self.rootBackgroundButton addGestureRecognizer:self.panRecognizer];
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizer:)];
    self.tapRecognizer.delegate = self;
    [self.rootBackgroundButton addGestureRecognizer:self.tapRecognizer];
    
}

/*!
 *  @author Pasco, 15-09-20 11:09:55
 *
 *  @brief  响应单击事件
 *
 *  @param recognizer recognizer description
 *
 *  @since 1.0
 */
- (void)handleTapRecognizer:(UITapGestureRecognizer *)recognizer{
    //    NSLog(@"TapRecognizer");
    [UIView animateWithDuration:0.3 animations:^{
        [self setMenuOffset:0];
    } completion:^(BOOL finished) {
        self.rootBackgroundButton.hidden = YES;
        self.rootBackgroundButton.alpha = 0.0;
    }];
    
}

/*!
 *  @author Pasco, 15-09-20 17:09:05
 *
 *  @brief  响应边缘侧滑事件
 *
 *  @param recognizer recognizer description
 *
 *  @since 1.0
 */
- (void)handleEdgePanRecognizer:(UIPanGestureRecognizer *)recognizer{
    CGFloat progress = [recognizer translationInView:self.view].x / kMenuWidth;
    progress = MIN(MAX(0.0, progress), 1.0);
    NSLog(@"ViewController----%f-----------%d",progress,self.rootBackgroundButton.hidden);
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.rootBackgroundButton.hidden = NO;
        NSLog(@"begin-----%d",[self.rootBackgroundButton isHidden]);
        
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        [self setMenuOffset:(progress * kMenuWidth)];
        NSLog(@"change-----%d",[self.rootBackgroundButton isHidden]);
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        CGFloat velocity = [recognizer velocityInView:self.view].x;
        if (velocity>20 || progress > 0.5) {
            [UIView animateWithDuration:(1-progress)/1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:3.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                [self setMenuOffset:kMenuWidth];
            } completion:^(BOOL finished) {
                ;
            }];
        }else{
            [UIView animateWithDuration:progress/3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self setMenuOffset:0];
            } completion:^(BOOL finished) {
                self.rootBackgroundButton.hidden = YES;
                self.rootBackgroundButton.alpha = 0.0;
            }];
        }
    }
}

/*!
 *  @author Pasco, 15-09-20 17:09:39
 *
 *  @brief  响应拖动事件
 *
 *  @param recognizer recognizer description
 *
 *  @since 1.0
 */
- (void)handlePanRecognizer:(UIPanGestureRecognizer *)recognizer{
    CGFloat progress = [recognizer translationInView:self.rootBackgroundButton].x / (kScreenWidth * 0.5);
    progress = - MIN(progress, 0);
    
    [self setMenuOffset:kMenuWidth - (kMenuWidth * progress)];
    
    static CGFloat sumProgress = 0;
    static CGFloat lastProgress = 0;
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        sumProgress = 0;
        lastProgress = 0;
    } else if(recognizer.state == UIGestureRecognizerStateChanged){
        if (progress > lastProgress) {
            sumProgress = sumProgress +progress;
        } else {
            sumProgress = sumProgress - progress;
        }
        lastProgress = progress;
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        [UIView animateWithDuration:0.3 animations:^{
            if (sumProgress > 0.1) {
                [self setMenuOffset:0];
            } else {
                [self setMenuOffset:kMenuWidth];
            }
        } completion:^(BOOL finished) {
            if (sumProgress > 0.1) {
                self.rootBackgroundButton.hidden = YES;
            }else{
                self.rootBackgroundButton.hidden = NO;
            }
        }];
    }
    
    
}

/*!
 *  @author Pasco, 15-09-07 21:09:52
 *
 *  @brief  设置菜单栏的offset
 *
 *  @param offset
 *
 *  @since 1.0
 */
- (void)setMenuOffset:(CGFloat)offset{
    CGRect menuFrame = self.menuView.frame;
    menuFrame.origin.x = -kMenuWidth + offset;
    self.menuView.frame = menuFrame;
    
    self.rootBackgroundButton.alpha = offset/kMenuWidth * 0.3;
    NSLog(@"ViewController----%f",self.rootBackgroundButton.alpha);
    
    UIViewController *previousViewController = [self viewControllerForIndex:self.currentSelectedIndex];
    
    //主页面向右位移offset的1/8的距离
    previousViewController.view.x       = offset/8;
    //    previousViewController.view.y       = offset/5;
    //    previousViewController.view.height  = kScreenHeight - 2 * offset / 5;
    //    previousViewController.view.width   = (kScreenWidth/kScreenHeight) * previousViewController.view.height;
    
    //self.view
}

/*!
 *  @author Pasco, 15-09-20 17:09:48
 *
 *  @brief  返回主页面被点击的菜单栏的对应行 对应的viewController
 *
 *  @param index 第几个
 *
 *  @return 返回相应的viewController
 *
 *  @since 1.0
 */
- (UIViewController *)viewControllerForIndex:(NSInteger)index{
    UIViewController *viewController;
    switch (index) {
        case 0:
            viewController = self.lastestNavigationController;
            break;
        case 1:
            viewController = self.alertNavigationController;
            break;
        case 2:
            viewController = self.exchangeNavigationController;
            break;
        case 3:
            viewController = self.undergraduateNavigationController;
            break;
        case 4:
            viewController = self.graduateNavigationController;
            break;
        case 5:
            viewController = self.researchNavigationController;
            break;
        case 6:
            viewController = self.networkNavigationController;
            break;
        case 7:
            viewController = self.collectionNavigationController;
            break;
        default:
            break;
    }
    return viewController;
}

/*!
 *  @author Pasco, 15-09-17 15:09:46
 *
 *  @brief  把旧的viewController去掉，换上新的
 *
 *  @param BOOL BOOL description
 *
 *  @return return value description
 *
 *  @since 1.0
 */
- (void)showViewControllerAtIndex:(NSInteger)index animated:(BOOL)animated {
    
    if (self.currentSelectedIndex != index) {
        
        UIViewController *previousViewController = [self viewControllerForIndex:self.currentSelectedIndex];
        UIViewController *willShowViewController = [self viewControllerForIndex:index];
        
        if (willShowViewController) {
            
            //                BOOL isViewInRootView = NO;
            //                //从子控件中选出
            //                for (UIView *subView in self.view.subviews) {
            //                    if ([subView isEqual:willShowViewController.view]) {
            //                        isViewInRootView = YES;
            //                    }
            //                }
            //                if (isViewInRootView) {
            //                    willShowViewController.view.x = 320;
            //                    //bring Subview to front
            //                    [self.viewControllerContainView bringSubviewToFront:willShowViewController.view];
            //                } else {
            [self.viewControllerContainView addSubview:willShowViewController.view];
            willShowViewController.view.x = 320;
            //                }
            
            //rootBackgroundButton放在最上面
            [self.viewControllerContainView bringSubviewToFront:self.rootBackgroundButton];
            
            if (animated) {
                [UIView animateWithDuration:0.2 animations:^{
                    previousViewController.view.x += 20;
                    
                } completion:^(BOOL finished) {
                    //移除上一个ViewController
                    [previousViewController.view removeFromSuperview];
                }];
                
                //动画的把新的viewcontroller的origin.x设为0
                [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1.2 options:UIViewAnimationOptionCurveLinear animations:^{
                    willShowViewController.view.x = 0;
                } completion:nil];
                //动画的把新的菜单栏缩回
                [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
                    [self setMenuOffset:0.0f];
                } completion:nil];
            } else {
                [previousViewController.view removeFromSuperview];
                willShowViewController.view.x = 0;
                [self setMenuOffset:0.0f];
            }
            
            self.currentSelectedIndex = index;
            
        }
    } else {
        
        UIViewController *willShowViewController = [self viewControllerForIndex:index];
        
        [UIView animateWithDuration:0.4 animations:^{
            willShowViewController.view.x = 0;
        } completion:^(BOOL finished) {
        }];
        [UIView animateWithDuration:0.5 animations:^{
            [self setMenuOffset:0.0f];
        }];
        
    }
    
}



/*!
 *  @author Pasco, 15-09-09 00:09:30
 *
 *  @brief  隐藏手机状态栏
 *
 *  @since 1.0
 */
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
@end
