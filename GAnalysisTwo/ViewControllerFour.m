//
//  ViewControllerFour.m
//  GAnalysisTwo
//
//  Created by 杨宗维 on 2018/6/6.
//  Copyright © 2018年 Icecooll. All rights reserved.
//

#import "ViewControllerFour.h"

@interface ViewControllerFour ()
@property (weak, nonatomic) IBOutlet UIButton *button4;
@end

@implementation ViewControllerFour

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_button4 addTarget:self action:@selector(button4Pressed) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [[GAI sharedInstance]defaultTracker];
    [tracker set:kGAIScreenName value:@"第四个屏"];
    [tracker send:[[GAIDictionaryBuilder createScreenView]build]];
}

-(void)button4Pressed{
    NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory:@"分类：动作" action:@"动作：按钮1触发" label:@"标签：任意写写,后面值101" value:[NSNumber numberWithInt:101]]build];
    [[GAI sharedInstance].defaultTracker send:event];
    NSLog(@"事件触发按钮1");
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
