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
   
}

-(void)button4Pressed{
    
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
