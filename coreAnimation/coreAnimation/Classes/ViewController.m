//
//  ViewController.m
//  coreAnimation
//
//  Created by chensx on 17/3/16.
//  Copyright © 2017年 coreAnimation. All rights reserved.
// 参考资料: zsisme.gitbooks.io/ios-/content/chapter8/changes-custom-transitions.html

#import "ViewController.h"
#import "LayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickButton:(UIButton *)sender {
    if (sender.tag % 10 == 1) {
        NSLog(@"======button1");
        [self cAMediaTiming];
        
    }else if (sender.tag % 10 == 2) {
        NSLog(@"======button2");
        
    }else if (sender.tag % 10 == 3) {
        NSLog(@"======button3");
        
    }else if (sender.tag % 10 == 4) {
        NSLog(@"======button4");
        
    }
}


/**
 CAMediaTiming协议
 */
- (void)cAMediaTiming {
    LayerViewController *vc = [[LayerViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

