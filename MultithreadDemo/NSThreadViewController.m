//
//  NSThreadViewController.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()
- (IBAction)buttonClicked:(id)sender;
@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 写一个耗时操作的任务
 @param sender 传递的button
 */
- (IBAction)buttonClicked:(id)sender {
   
    NSLog(@"main --- %@",[NSThread mainThread]);
    //第一种创建的方式
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"验证携带的方式"];
    thread.name = @"newThread";
    [thread start];
}

//NSThread有三种创建方式
-(void)createThread{
}

-(void)run:(id)obj{
    NSLog(@"打印携带的参数%@",obj);
    NSLog(@"currentThread --- %@",[NSThread currentThread]);
        //耗时操作(此操作会影响textView的滚动)
    for (int i = 0; i< 10000000 ; i++ ) {
        NSLog(@"-------%d------",i);
    }
    
}





@end
