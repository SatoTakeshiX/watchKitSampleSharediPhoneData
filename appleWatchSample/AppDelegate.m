//
//  AppDelegate.m
//  appleWatchSample
//
//  Created by satoutakeshi on 2015/03/18.
//  Copyright (c) 2015年 satoutakeshi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void(^)(NSDictionary *replyInfo))reply
{
    //watchからのデータはuserInfoに入っている。
    NSNumber *watchCount = [userInfo valueForKey:@"watchValue"];
    
    //watchからのデータをiPhoneの画面に表示させる。
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    ViewController *vc = (ViewController *)appDelegate.window.rootViewController;
    vc.watchCountLabel.text = [NSString stringWithFormat:@"アップルウォッチでのカウントは%ld回", [watchCount integerValue]];
    
    //iPhoneからwatchへ画像データを送る。
    UIImage *nekoImage = [UIImage imageNamed:@"neko"];
    NSData *nekoData = [[NSData alloc] initWithData:UIImagePNGRepresentation(nekoImage)];
    reply(
          @{
            @"iPhoneData":@(1),
            @"nekoImage":nekoData//UIImageオブジェクトをそのまま送ると送信が失敗してしまう。NSDataに直して送る。
            }
    );
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
