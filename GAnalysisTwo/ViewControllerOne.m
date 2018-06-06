//
//  ViewController.m
//  GAnalysisTwo
//
//  Created by 杨宗维 on 2018/6/6.
//  Copyright © 2018年 Icecooll. All rights reserved.
//

#import "ViewControllerOne.h"

@interface ViewControllerOne ()
@property (weak, nonatomic) IBOutlet UIButton *button1;

@end

@implementation ViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"第一个屏幕"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
