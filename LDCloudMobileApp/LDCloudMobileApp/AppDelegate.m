//
//  AppDelegate.m
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "AppDelegate.h"
#import "CCPMTask.h"
#import "MyTableViewController_1.h"
#import "ViewController.h"
#import "Parse/parse.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    //ViewController *viewController = [navigationController viewControllers][0];
    
    //tableViewController._ccpmTaskList = _ccpmTaskList;
    [Parse setApplicationId:@"V09dXwlGkXaND5FcHF3PuYk4ItRmyK8ZU08MzAoY"
                  clientKey:@"NDqB5qz2T7uomsl2xhMwwPrNVh6P7cBwceSBRWd5"];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        /*
        NSMutableSet *categories = [NSMutableSet set];
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        category.identifier = @"identifier";
        UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
        action.identifier = @"test2";
        action.title = @"test";
        action.activationMode = UIUserNotificationActivationModeBackground;
        action.authenticationRequired = YES;
        //YES显示为红色，NO显示为蓝色
        action.destructive = NO;
        NSArray *actions = @[ action ];
        [category setActions:actions forContext:UIUserNotificationActionContextMinimal];
        [categories addObject:category];
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:categories]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
         */
        
        // Register for Push Notitications
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];

    }else
    {
        /*这里是8.0之前的代码
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
         */
    }

    return YES;
}

/* Called when your app has been activated by the user selecting an action from
   a remote notification.
   A nil action identifier indicates the default action.
   You should call the completion handler as soon as you've finished handling
   the action.
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(nonnull UIUserNotificationSettings *)notificationSettings{
    
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
