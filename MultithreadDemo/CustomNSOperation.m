//
//  CustomNSOperation.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/17.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "CustomNSOperation.h"

@implementation CustomNSOperation
//自定义的Operation要重写main方法
-(void)main{
    NSLog(@"currentThread%@",[NSThread currentThread]);
    //自定义挂起取消的应用代码
    for (int i = 0; i < 5000; i++) {
        NSLog(@"---1---%@",[NSThread currentThread]);
    }
    if (self.cancelled) {
        return;
    }
    for (int i = 0; i < 5000; i++) {
        NSLog(@"---2---%@",[NSThread currentThread]);
    }
    if (self.cancelled) {
        return;
    }
    for (int i = 0; i < 5000; i++) {
        NSLog(@"---3---%@",[NSThread currentThread]);
    }
    if (self.cancelled) {
        return;
    }
    for (int i = 0; i < 5000; i++) {
        NSLog(@"---4---%@",[NSThread currentThread]);
    }
    if (self.cancelled) {
        return;
    }
}
@end
