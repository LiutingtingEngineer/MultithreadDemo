//
//  NSOpreationViewController.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "NSOpreationViewController.h"
#import "CustomNSOperation.h"

@interface NSOpreationViewController ()
- (IBAction)loadImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)NSOperationQueue *queue;
- (IBAction)suspended:(id)sender;
- (IBAction)cancleQUeue:(id)sender;
@end

@implementation NSOpreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
//    [self maxCountOperation];
    [self CustomQueueCacle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击屏幕触发测试的代码，相应的结论看一下打印平台
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self invocationOperation];
//    [self blokOperation];
//    [self customOperation];
    [self operationQueue];
}

#pragma mark 第一部分 NSOpreation 三种任务的使用
/**
 * 1、NSinvocationOperation的使用
 */
-(void)invocationOperation {
    NSInvocationOperation *ip = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(oprationTask) object:nil];
    [ip start];
}

-(void)oprationTask {
    NSLog(@"%@",[NSThread currentThread]);
}


/**
 2、blokOperation的使用
 */
-(void)blokOperation{
   NSBlockOperation *bo = [NSBlockOperation blockOperationWithBlock:^{
       NSLog(@"---1---%@",[NSThread currentThread]);
   }];
    //额外任务在子线程中完成
    [bo addExecutionBlock:^{
        NSLog(@"---2---%@",[NSThread currentThread]);
    }];
    [bo addExecutionBlock:^{
        NSLog(@"---3---%@",[NSThread currentThread]);
    }];
    [bo addExecutionBlock:^{
        NSLog(@"---4---%@",[NSThread currentThread]);
    }];
    //任务开始之后就不能再添加额外任务
    [bo start];
}


/**
  3、自定义
 */
-(void)customOperation {
    CustomNSOperation *cp = [[CustomNSOperation alloc]init];
    [cp start];
}

#pragma mark 第二部分  NSOperationQueue的使用

-(void)operationQueue {
    //创建队列 (1、主队列 2、自定义的队列)  默认创建的是并行队列
    //NSOperationi相对GCD的队列是更加简化的
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
   NSInvocationOperation *ip = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(oprationTask) object:nil];
    NSInvocationOperation *ip2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(oprationTaskTwo) object:nil];
    [queue addOperation:ip];
    [queue addOperation:ip2];
}

-(void)oprationTaskTwo{
    NSLog(@"%@",[NSThread currentThread]);
}

#pragma mark 第三部分 NSOperation通信与依赖关系

- (IBAction)loadImage:(id)sender {
//    [self loadImage];
//    [self dependency];
    [self maxCountOperation];
}
-(void)loadImage {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:IMAGEURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
        }];
    }];
}

//任务的依赖关系
-(void)dependency {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i< 5; i++) {
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i< 5; i++) {
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i< 5; i++) {
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    }];
    
    //前者依赖与后者  后者先执行，前者再执行 ，任务之间不能相互依赖
    [op1 addDependency:op];
    [op2 addDependency:op1];
    
    [queue addOperation:op];
    [queue addOperation:op1];
    [queue addOperation:op2];
}

#pragma mark 最大并发数、挂起、取消

//最大并发数
-(void)maxCountOperation {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 2;
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 5000; i++) {
            NSLog(@"---4---%@",[NSThread currentThread]);
        }
    }];
    self.queue = queue;
}


-(void)CustomQueueCacle {
    CustomNSOperation *cp = [[CustomNSOperation alloc]init];
    
   NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:cp];
    self.queue = queue;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)suspended:(id)sender {
    //挂起
    if (self.queue.suspended) {
      self.queue.suspended = NO;
    }else{
       self.queue.suspended = YES;
    }
}

- (IBAction)cancleQUeue:(id)sender {
    //取消是无法恢复
    [self.queue cancelAllOperations];
}



@end
