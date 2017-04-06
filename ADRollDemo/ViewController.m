//
//  ViewController.m
//  ADRollDemo
//
//  Created by hztuen on 17/3/16.
//  Copyright © 2017年 cesar. All rights reserved.
//

#import "ViewController.h"
#import "ADRollView.h"
#import "ADRollModel.h"
#import "WebViewController.h"

@interface ViewController ()

@property (nonatomic, strong) ADRollView *adRollView;
@property (nonatomic, strong) NSMutableArray *adsArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.adRollView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.adRollView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupInit];
    [self buildUI];
}

- (void)setupInit {
    
    self.title = @"滚动公告";
    self.adsArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f3f3f3" alpha:1.0];
    
}

- (void)buildUI {
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 200, ScreenWidth-[self Suit:30], [self Suit:40])];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self.view addSubview:bgView];
    
    //公告image
    UIImageView *adImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AD"]];
    [bgView addSubview:adImage];
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset([self Suit:8]);
        make.width.mas_equalTo([self Suit:95/3]);
        make.height.mas_equalTo([self Suit:44/3]);
    }];
    
    //分割线
    CALayer *line = [CALayer layer];
    line.backgroundColor = [UIColor colorWithHexString:@"ececec" alpha:1.0].CGColor;
    line.frame = CGRectMake([self Suit:47], [self Suit:10], [self Suit:1], [self Suit:20]);
    [bgView.layer addSublayer:line];
    
    //ADRollView
    self.adRollView = [[ADRollView alloc] initWithFrame:CGRectMake([self Suit:48], 0, ScreenWidth-[self Suit:30+48], [self Suit:40])];
    [self.adRollView setVerticalShowDataArr:[self getData]];
    
    //点击公告内容
    __weak __typeof(self)weakSelf = self;
    self.adRollView.clickBlock = ^(NSInteger index) {
        ADRollModel *model = weakSelf.adsArray[index];
        WebViewController *adWeb = [[WebViewController alloc] initWithUrl:model.urlString title:model.noticeTitle];
        [weakSelf.navigationController pushViewController:adWeb animated:YES];
        NSLog(@"点击了: %@", model.noticeTitle);
    };

    [bgView addSubview:self.adRollView];

}

/**
 适配 给定4.7寸屏尺寸，适配4和5.5寸屏尺寸
 */
- (float)Suit:(float)MySuit
{
    (IS_IPHONE4INCH||IS_IPHONE35INCH)?(MySuit=MySuit/Suit4Inch):((IS_IPHONE55INCH)?(MySuit=MySuit*Suit55Inch):MySuit);
    return MySuit;
}

- (NSMutableArray *)getData {
    
    NSArray *adTypeArray = @[@"紧急通知", @"公告", @"通告"];
    NSArray *titleArray = @[@"程序员才是真正的段子手", @"iOS动画", @"移动导航设计，看这一篇就够了"];
    NSArray *timeArray = @[@"2016-12-25", @"2017-02-14", @"2017-05-13"];
    NSArray *urlArray = @[@"http://www.cocoachina.com/programmer/20170315/18892.html", @"http://www.cocoachina.com/ios/20170315/18890.html", @"http://www.cocoachina.com/design/20170315/18884.html"];
    
    for (int i = 0; i < adTypeArray.count; i++) {
        ADRollModel *model = [[ADRollModel alloc] init];
        model.noticeType = adTypeArray[i];
        model.noticeTitle = titleArray[i];
        model.addTime = timeArray[i];
        model.urlString = urlArray[i];
        [self.adsArray addObject:model];
    }
    
    return self.adsArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
