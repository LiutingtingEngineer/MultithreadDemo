//
//  ViewController.m
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadViewController.h"
#import "GCDViewController.h"
#import "NSOpreationViewController.h"


@interface ViewController ()
- (IBAction)NSThread:(id)sender;
- (IBAction)GCD:(id)sender;
- (IBAction)NSOpreation:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)NSThread:(id)sender {
    NSThreadViewController *thread = [[NSThreadViewController alloc]initWithNibName:@"NSThreadViewController" bundle:nil];
    [self presentViewController:thread animated:YES completion:^{
    }];
}

- (IBAction)GCD:(id)sender {
    GCDViewController *gcd = [[GCDViewController alloc]initWithNibName:@"GCDViewController" bundle:nil];
    [self presentViewController:gcd animated:YES completion:^{
    }];
}

- (IBAction)NSOpreation:(id)sender {
    NSOpreationViewController *opreation = [[NSOpreationViewController alloc]initWithNibName:@"NSOpreationViewController" bundle:nil];
    [self presentViewController:opreation animated:YES completion:^{
    }];
}
@end
