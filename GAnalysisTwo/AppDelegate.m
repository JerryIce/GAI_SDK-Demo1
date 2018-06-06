//
//  AppDelegate.m
//  GAnalysisTwo
//
//  Created by 杨宗维 on 2018/6/6.
//  Copyright © 2018年 Icecooll. All rights reserved.
//

#import "AppDelegate.h"
static NSString *const KTrackingID = @"UA-120449429-1";
static NSString *const KAllowTracking = @"allowTracking";

@interface AppDelegate ()
//创建google追踪器
@property (strong,nonatomic) id<GAITracker> tracker;
// 谷歌分析 Used for sending Google Analytics traffic in the background.
@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);

//谷歌分析初始化及配置
-(void) configGoogleAnalytics;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
   // [FIRApp configure];
    
    
    // Configure tracker from GoogleService-Info.plist.
//    NSError *configureError;
//    [[GGLContext sharedInstance] configureWithError:&configureError];
//    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    
//    // Optional: configure GAI options.
//    GAI *gai = [GAI sharedInstance];
//    gai.trackUncaughtExceptions = YES;  // report uncaught exceptions
//    gai.logger.logLevel = kGAILogLevelVerbose;  // remove before app release
    
    [self configGoogleAnalytics];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self sendHitsInBackground];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [GAI sharedInstance].optOut = ! [[NSUserDefaults standardUserDefaults]boolForKey:KAllowTracking];
    
}
- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [self sendHitsInBackground];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - configGoogleAnalytics
-(void)configGoogleAnalytics{
    self.tracker = [[GAI sharedInstance]trackerWithName:@"追踪器名字1" trackingId:KTrackingID];  //设置追踪器
    [GAI sharedInstance].trackUncaughtExceptions = YES;  //追踪异常事件
    [GAI sharedInstance].dispatchInterval = 5;  //已修改成5秒 //追踪数据发送间隔  设置为-1是因为采用后台发送，如果采用自动发送则需要设置发送间隔
    NSDictionary *allowTrackingDef = @{KAllowTracking:@(YES)};  //允许追踪
    [[NSUserDefaults standardUserDefaults]registerDefaults:allowTrackingDef];
    [GAI sharedInstance].optOut = ![[NSUserDefaults standardUserDefaults]boolForKey:KAllowTracking];  //设置选择退出为否
}

//谷歌分析进入后台后发送数据方法
// This method sends hits in the background until either we're told to stop background processing,
// we run into an error, or we run out of hits.  We use this to send any pending Google Analytics
// data since the app won't get a chance once it's in the background.
- (void)sendHitsInBackground {
    self.okToWait = YES;
    __weak AppDelegate *weakSelf = self;
    __block UIBackgroundTaskIdentifier backgroundTaskId =
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        weakSelf.okToWait = NO;
    }];
    
    if (backgroundTaskId == UIBackgroundTaskInvalid) {
        return;
    }
    
    self.dispatchHandler = ^(GAIDispatchResult result) {
        // If the last dispatch succeeded, and we're still OK to stay in the background then kick off
        // again.
        if (result == kGAIDispatchGood && weakSelf.okToWait ) {
            [[GAI sharedInstance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
        }
    };
    [[GAI sharedInstance] dispatchWithCompletionHandler:self.dispatchHandler];
}


@end
