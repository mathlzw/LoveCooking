//
//  AppDelegate.m
//  爱厨艺
//
//  Created by shengdai on 15/12/4.
//  Copyright © 2015年 shengdai. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewTableVC.h"
#import "ExchangeCollectionVC.h"
#import "FoodMaterialMatailTableVC.h"
#import "TopViewController.h"
#import "ClassVC.h"
#import <AVOSCloud/AVOSCloud.h>

@interface AppDelegate ()
@property(nonatomic,strong) UIImageView *imgV;//网略未连接显示图片
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //检测网络连接
    [self reach];
    
    return YES;
}

- (void)reach
{
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // 局域网络,不花钱
     */
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 检测网络连接的单例,网络变化时的回调方法
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        NSLog(@"%ld", (long)status);
        if (status ==-1) {
            NSLog(@"未知网络");
           self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weilianwang.png"]];
            _imgV.frame = CGRectMake(0, 64, self.window.frame.size.width, self.window.frame.size.height);
            [self.window addSubview:_imgV];
            NSLog(@"网络无连接");
        }else if (status ==0){
            self.imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"weilianwang.png"]];
            _imgV.frame = CGRectMake(0, 64, self.window.frame.size.width, self.window.frame.size.height);
            [self.window addSubview:_imgV];
            _imgV.userInteractionEnabled = NO;
            NSLog(@"网络无连接");
        }else if (status == 1){
            NSLog(@"3G网络花钱");
            //进入有网络操作
            [self connect];
            _imgV.hidden = YES;
        }else if (status ==2){
            NSLog(@"局域网络,不花钱");
         //进入有网络操作
         [self connect];
        _imgV.hidden = YES;
        }
    }];
}

-(void)connect{
    
    [AVOSCloud setApplicationId:@"PxRv7USTAixKM8RloCI8AHco-gzGzoHsz" clientKey:@"MTuFcAJJgKYpOt8ILhuAuo6j"];
    
    FirstViewTableVC *firstVC = [[FirstViewTableVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:firstVC];
    nav.navigationBar.translucent = NO;
    
    ClassVC *classView = [[ClassVC alloc]init];
    UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:classView];
    naVC.navigationBar.translucent = NO;
    
    TopViewController *top = [[TopViewController alloc] init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:top];
    nav2.navigationBar.translucent = YES;
    
    ExchangeCollectionVC *exchangVC = [[ExchangeCollectionVC alloc] init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:exchangVC];
    nav3.navigationBar.translucent = NO;
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    tabBar.tabBar.tintColor = [UIColor colorWithRed:0.800 green:0.059 blue:0.125 alpha:1.000];
    tabBar.viewControllers = @[nav, naVC, nav2, nav3];
    tabBar.tabBar.barTintColor = [UIColor whiteColor];
    self.window.rootViewController = tabBar;

}


#pragma mark - 检测网络连接



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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "mathlzw-163.com.___" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"___" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"___.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
