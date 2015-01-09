//
//  TimerLabel.m
//  TimerRetainCycleDemo
//
//  Created by Parsifal on 15/1/8.
//  Copyright (c) 2015年 Parsifal. All rights reserved.
//

#import "TimerLabel.h"

@interface TimerLabel ()

@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger num;

@end

@implementation TimerLabel

//start count
- (void)startTimer
{
    if (!self.timer) {
//        __weak typeof(self) weakSelf = self;//就算是用weakSelf作为target，也是会造成retain cycle ，因为timer肯定会进行retain一次
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:weakSelf selector:@selector(count) userInfo:nil repeats:YES];
        
        //这行代码需注意两点：1、新建的timer会scheduled到runloop中，并且retain一次timer；2、timer会将target进行retain一次；
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(count) userInfo:nil repeats:YES];
    }
    
    self.num = 0;
}

//stop timer
- (void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)count
{
    self.text = @(self.num++).stringValue;
}

//stop the timer when the label had been removed from it's super view ----- a correct way
-(void)removeFromSuperview
{
    [super removeFromSuperview];
    [self stopTimer];
}

- (void)dealloc
{
    //    [self stopTimer];  //it won't work.. it's a wrong way to stop the timer;
    
    NSLog(@"%s", __FUNCTION__);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
