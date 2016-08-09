//
//  AppDelegate.m
//  Calendar Events Creator iOS
//
//  Created by Andrey on 8/9/16.
//  Copyright © 2016 Andrey. All rights reserved.
//

#import "AppDelegate.h"

#import "SAPCreatorViewController.h"

#import "UIWindow+SAPExtensions.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    SAPCreatorViewController *controller = [SAPCreatorViewController new];
    
    window.rootViewController = controller;
    
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
