//
//  NSThreadViewController.h
//  MultithreadDemo
//
//  Created by 刘停停 on 2017/2/16.
//  Copyright © 2017年 刘停停. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSThreadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *loadImage;
- (IBAction)loadImage:(id)sender;

@end
