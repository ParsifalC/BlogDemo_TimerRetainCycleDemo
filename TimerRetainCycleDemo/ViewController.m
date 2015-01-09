//
//  ViewController.m
//  TimerRetainCycleDemo
//
//  Created by Parsifal on 15/1/8.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "ViewController.h"
#import "TimerLabel.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (strong, nonatomic) TimerLabel *myTimerLabel;

@end

@implementation ViewController

/*
 *1、测试持有timer的对象是否被释放，tap Remove Button，观察TimerLabel dealloc；
 *2、tap View，进入SecondViewController，测试timer被ViewController持有时的写法，同样观察dealloc方法是否执行
 */

/*  苹果官方文档中对NSTimer使用的建议，总而言之一句话：对于Repeat形式加入Runloop的timer，必须手动invalid，才能释放timer，从而释放timer中的target
  Once scheduled on a run loop, the timer fires at the specified interval until it is invalidated. A non-repeating timer invalidates itself immediately after it fires. However, for a repeating timer, you must invalidate the timer object yourself by calling its invalidate method. Calling this method requests the removal of the timer from the current run loop; as a result, you should always call the invalidate method from the same thread on which the timer was installed. Invalidating the timer immediately disables it so that it no longer affects the run loop. The run loop then removes the timer (and the strong reference it had to the timer), either just before the invalidate method returns or at some later point. Once invalidated, timer objects cannot be reused.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1 TimerLabel as ViewController's property
    [self.view addSubview:self.myTimerLabel];
    [self.myTimerLabel startTimer];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 80, 100, 30)];
    [button setTitle:@"remove" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(tapButton) forControlEvents:(UIControlEventTouchDown)];
    button.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:button];
    
    //2 Just add TimerLabel on the view
    TimerLabel *timerLabel = [[TimerLabel alloc] initWithFrame:CGRectMake(100, 80, 100, 40)];
    [self.view addSubview:timerLabel];
    timerLabel.text = @"0";
    [timerLabel startTimer];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)tapView
{
    [self presentViewController:[SecondViewController new] animated:YES completion:nil];
}

- (TimerLabel *)myTimerLabel
{
    if (!_myTimerLabel) {
        _myTimerLabel = [[TimerLabel alloc] initWithFrame:CGRectMake(20, 80, 100, 40)];
    }
    
    return _myTimerLabel;
}

- (void)tapButton
{
    NSArray *subViews = self.view.subviews;
    
    //移除视图上所有的TimerLabel
    [subViews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[TimerLabel class]]) {
            [obj removeFromSuperview];
        }
    }];
}

@end
