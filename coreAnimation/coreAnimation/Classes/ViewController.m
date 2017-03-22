//
//  ViewController.m
//  coreAnimation
//
//  Created by chensx on 17/3/16.
//  Copyright © 2017年 coreAnimation. All rights reserved.
//

#import "ViewController.h"

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
        
    }else if (sender.tag % 10 == 2) {
        NSLog(@"======button2");
        
    }else if (sender.tag % 10 == 3) {
        NSLog(@"======button3");
        
    }else if (sender.tag % 10 == 4) {
        NSLog(@"======button4");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
