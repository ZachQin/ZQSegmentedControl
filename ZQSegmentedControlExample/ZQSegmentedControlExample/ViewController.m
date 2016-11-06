//
//  ViewController.m
//  ZQSegmentedControlExample
//
//  Created by 秦智康 on 2016/11/4.
//  Copyright © 2016年 ZachQin. All rights reserved.
//

#import "ViewController.h"
#import "ZQSegmentedControl.h"

@interface ViewController () <ZQSegmentControlDataSource>
@property (nonatomic, strong) ZQSegmentedControl *sc;
@property (nonatomic, strong) NSDictionary *table;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.table = @{@"Monday" : @"Mon.",
                            @"Tuesday" : @"Tues.",
                            @"Wednesday" : @"Wed.",
                            @"Thursday" : @"Thurs.",
                            @"Friday" : @"Fri.",
                            @"Saturday" : @"Sat.",
                            @"Sunday" : @"Sun."
                            };
    
    self.sc = [[ZQSegmentedControl alloc] initWithItems:@[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday"]];
    self.sc.frame = CGRectMake(100, 100, 100, 300);
    self.sc.orientation = ZQSegmentedControlVertical;
    self.sc.popDirection = ZQSegmentedControlBelow;
    [self.sc addTarget:self action:@selector(action:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.sc];
    self.sc.datasource = self;
    self.sc.popBackgroundColor = [UIColor purpleColor];
}

- (void)action:(UISegmentedControl *)sc {
    NSLog(@"Select %ld segment.", (long)sc.selectedSegmentIndex);
}

- (NSString *)segmentControl:(ZQSegmentedControl *)segmentControl popViewTitleForIndex:(NSInteger)index {
    NSString *itemTitle = [self.sc titleForSegmentAtIndex:index];
    return self.table[itemTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
