//
//  ViewControllerThree.m
//  GAnalysisTwo
//
//  Created by 杨宗维 on 2018/6/6.
//  Copyright © 2018年 Icecooll. All rights reserved.
//

#import "ViewControllerThree.h"

@interface ViewControllerThree ()
@property (weak, nonatomic) IBOutlet UIButton *button3;

@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"第三个屏幕"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
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
