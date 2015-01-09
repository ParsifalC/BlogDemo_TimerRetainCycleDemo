//
//  SecondViewController.m
//  TimerRetainCycleDemo
//
//  Created by Parsifal on 15/1/8.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [self.view addGestureRecognizer:tap];
    
    //not repeat---it will invalid by itself
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(log) userInfo:nil repeats:NO];

/*
    //这种写法是绝对不允许的 因为timer将无法invalid 你得不到这个timer
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(log) userInfo:nil repeats:YES];
*/
    
    //因为是repeat的timer，所以你必须手动invalid，而且这个操作必须在ViewController dealloc 方法执行前进行 例如 可以将timer的创建放在viewDidAppear里面，释放放在viewWillDisappear..
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(log) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;//安全的做法
    }
}

- (void)tapGes
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)log
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
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
