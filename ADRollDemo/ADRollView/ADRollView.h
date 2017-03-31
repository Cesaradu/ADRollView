//
//  ADRollView.h
//  OKSheng
//
//  Created by hztuen on 17/3/6.
//  Copyright © 2017年 hztuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADRollModel.h"

@interface ADRollView : UIView

@property (nonatomic,copy) void (^clickBlock)(NSInteger index);//第几个数据被点击

//数组内部数据需要是ADRollModel类型
- (void)setVerticalShowDataArr:(NSMutableArray *)dataArr;

//开始滚动
- (void)start;

//停止定时器(界面消失前必须要停止定时器否则内存泄漏)
- (void)stopTimer;

@end
