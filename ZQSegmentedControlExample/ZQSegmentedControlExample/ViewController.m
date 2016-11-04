//
//  ViewController.m
//  ZQSegmentedControlExample
//
//  Created by 秦智康 on 2016/11/4.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import "ViewController.h"
#import "ZQSegmentedControl.h"

@interface ViewController ()
@property (nonatomic, strong) ZQSegmentedControl *sc;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.sc = [[ZQSegmentedControl alloc] initWithItems:@[@"1", @"2", @"3", @"4"]];
    self.sc.frame = CGRectMake(100, 100, 400, 400);
    self.sc.orientation = ZQSegmentedControlVertical;
    [self.sc addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.sc];
}

- (void)action:(UISegmentedControl *)sc {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
