//
//  ViewController.m
//  XD9LockView
//
//  Created by apple on 2018/5/8.
//  Copyright © 2018年 sxd. All rights reserved.
//

#import "ViewController.h"
#import "XD9LockView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XD9LockView *xd9lock = [[XD9LockView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 500) normalImgSte:@"normal" selectImgStr:@"selected" selectedOrder:^(NSArray *orderArr) {
        NSLog(@"%@",orderArr);
    }];
    [self.view addSubview:xd9lock];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
