//
//  GCDViewController.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "GCDViewController.h"



@interface GCDViewController ()
- (IBAction)loadImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;
- (IBAction)tsetElseGCD:(id)sender;

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self concuurentSync];
//    [self concuurentAsync];
//    [self serialSync];
//    [self serialAsync];
//    [self globalSync];
//    [self globalAsync];
//    [self mainSync];
    [self mainAsync];
}


/**
    并发队列+同步任务  没有开启新的线程，任务是逐个执行的
 */
-(void)concuurentSync {
    //创建并发队列
    dispatch_queue_t  queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%@",[NSThread mainThread]);
    //在队列里添加任务
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}


/**
    并发队列+异步任务   开启新的线程，任务是并发的
 */
-(void)concuurentAsync {

    //创建并发队列
    dispatch_queue_t  queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"%@",[NSThread mainThread]);
    //在队列里添加任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

/**
   全局队列+同步任务  不会开启新线程，任务逐步进行
 */
-(void)globalSync {
    //获取全局的队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //同步任务
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}


/**
  全局队列（并行队列）+ 异步任务  开启新的线程，任务是并发的
 */
-(void)globalAsync {
    //获取全局的队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //同步任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

/**
 串行队列+同步任务  没有开启新的线程，任务是逐个执行的
 */
-(void)serialSync {
    //创建串行发队列
    dispatch_queue_t  queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    //在队列里添加任务
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

/**
 串行队列+异步任务   开启新的线程，任务逐步执行
 */
-(void)serialAsync {
    //创建串行发队列
    dispatch_queue_t  queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_PRIORITY_DEFAULT);
    //在队列里添加任务
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

/**
  主队列+同步任务 会造成死锁的线程【切记】
 */
-(void)mainSync {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

/**
  主队列（串行队列）+异步任务  没有开启新线程，任务逐步执行
 */
-(void)mainAsync {
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----1----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----2----%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 5 ; i++) {
            NSLog(@"-----3----%@",[NSThread currentThread]);
        }
    });
}

#pragma mark GCD的线程通信  图片的加载

- (IBAction)loadImage:(id)sender {
    //触发新的线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       //耗时操作
        NSURL *url = [NSURL URLWithString:IMAGEURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        //回归到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
          
        self.image.image = image;
        });
    });
}

#pragma mark GCD的其他用法
- (IBAction)tsetElseGCD:(id)sender {
    //延时
//    [self delay];
    //一次性
    [self once];
    
}

/**
  1、延时操作
 */
-(void)delay{
    [NSThread sleepForTimeInterval:2];
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    
    //GCD版的延时
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0* NSEC_PER_SEC)),dispatch_get_main_queue() ,^{
      //2秒后执行这里的代码
      [self run];
  });
   
    //定时器的延时
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(run) userInfo:nil repeats:NO];
    
}

-(void)run{
    NSLog(@"111111");
}

//2、一次性代码
-(void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       //只执行一次的代码
        NSLog(@"只执行一次的操作");
    });
}

//多次操作
-(void)apply{
    //10次操作是并行执行的
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        //index需要自己填写 每次遍历的下标
        NSLog(@"%ld",index);
    });
    
}
//3、队列组 分别执行两个一步运行的人任务，等两个一步任务都执行完毕之后，再回到主线程完成操作
-(void)dispatchGroup {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //执行第一个耗时的异步的操作
        NSLog(@"第一个耗时操作");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //执行第二个耗时的异步的操作
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //等上面两个完成之后，回到主线程
    });
}


@end

