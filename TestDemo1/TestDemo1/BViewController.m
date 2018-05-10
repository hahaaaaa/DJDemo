//
//  BViewController.m
//  TestDemo1
//
//  Created by Sky on 2018/4/27.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()
{
    NSInteger count;
}
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation BViewController
- (void)dealloc {
    self.timer = nil;
    NSLog(@"Bdealloc");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(action) userInfo:nil repeats:YES];
    _timer = timer;
}
- (void)action {
    count++;
    if (count > 10) {
        [_timer invalidate];
    }
    NSLog(@"Timer");

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
