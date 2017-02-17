//
//  NSThreadViewController.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "NSThreadViewController.h"

@interface NSThreadViewController ()

@property(nonatomic,strong)NSThread *thr1;
@property(nonatomic,strong)NSThread *thr2;
@property(nonatomic,strong)NSThread *thr3;
@property(nonatomic,assign)NSInteger tickets;

- (IBAction)buttonClicked:(id)sender;
@end

@implementation NSThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self conductorCondition];
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
    [self createThreadOne];
//    [self createThreadTwo];
//    [self createThreadThree];
}

//NSThread有三种创建方式
-(void)createThreadOne{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"验证携带的方式"];
    thread.name = @"newThread";
    [thread start];
}

//第二种创建的方法
-(void)createThreadTwo{
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self  withObject:@"second"];
}

/**
 第三种创建方法(开启一个后台线程子线程)
 */
-(void)createThreadThree{
    [self performSelectorInBackground:@selector(run:) withObject:@"third"];
}

-(void)run:(id)obj{
    NSLog(@"打印携带的参数%@",obj);
    NSLog(@"currentThread --- %@",[NSThread currentThread]);
        //耗时操作(此操作会影响textView的滚动)
    for (int i = 0; i< 10000000 ; i++ ) {
        NSLog(@"-------%d------",i);
    }
}

#pragma mark 对线程安全隐患所做的处理  例如多个线程访问同一个数据(售票员售票)
-(void)conductorCondition {
    self.tickets = 1000;
    self.thr1 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thr1.name = @"张女士";
    self.thr2 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thr2.name = @"孙女士";
    self.thr3 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTickets) object:nil];
    self.thr3.name = @"刘女士";
}

-(void)sellTickets {
    //利用线程锁来解决这个问题
    
    @synchronized (self) {
        while (self.tickets > 0) {
            NSInteger currentTickets = self.tickets;
            if(currentTickets > 0){
                NSLog(@"%@卖了一张票，还剩%ld张票",[NSThread currentThread],--self.tickets);
            }else{
                NSLog(@"票已售完");
            }
        }
    }
}

/**
 * 点击屏幕触发售票的事件
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.thr1 start];
    [self.thr2 start];
    [self.thr3 start];
}

//线程之间的信息通信 网络图片的显示

- (IBAction)loadImage:(id)sender {
//    NSURL *url = [NSURL URLWithString:IMAGEURL];
//    NSDate *begin = [NSDate date];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSDate *end = [NSDate date];
//    NSLog(@"%f",[end timeIntervalSinceDate:begin]);
//    self.loadImage.image = [UIImage imageWithData:data];
    [NSThread detachNewThreadSelector:@selector(downloadImage) toTarget:self withObject:nil];
}

-(void)downloadImage{
    NSURL *url = [NSURL URLWithString:IMAGEURL];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(showImage:) withObject:image waitUntilDone:YES];
    NSLog(@"图片加载完成");
}

-(void)showImage:(UIImage *)image {
    self.loadImage.image = image;
}

@end
