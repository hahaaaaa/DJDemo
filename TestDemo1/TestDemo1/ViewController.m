//
//  ViewController.m
//  TestDemo1
//
//  Created by Sky on 2018/4/27.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)dealloc {
    NSLog(@"dealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    BViewController *vc = [BViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
