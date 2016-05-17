//
//  AppDelegate.m
//  StudentsGuide
//
//  Created by sadeeshmac on 5/11/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "AppDelegate.h"
#import "PrefixHeader.pch"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
//
//    NSLog(@"language=%@",language);
    
//    if ([language isEqualToString:@"ar-US"])
//    
//        [GlobalClass setLanguage:@"ar"];
//    
//    else if ([language isEqualToString:@"en-US"])
//    
//        [GlobalClass setLanguage:@"en"];
    
    
//    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
//    
//    NSLog(@"language=%@",language);
//    
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//    
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
//    {
//        if ([language isEqualToString:@"ar-US"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//        }
//        else if ([language isEqualToString:@"ar-US"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
//        {
//            
//        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        }
//        
//        
//        else
////            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//    }
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [UINavigationBar appearance].barTintColor = [UIColor customThemeColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor navigationTitleColor],NSFontAttributeName:[UIFont customEnglishTitleFont]}];
    [UINavigationBar appearance].translucent = NO;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)starIndicator
{
    
    loadView=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.window.frame.size.width, self.window.frame.size.height)];
    loadView.backgroundColor=[UIColor colorWithRed:26.0f/255.0f green:26.0f/255.0f blue:26.0f/255.0f alpha:0.8f];
    
    loadView.opaque = YES;
    loadView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    imgloading=[[UIImageView alloc]initWithFrame:CGRectMake(133, ([[UIScreen mainScreen] bounds].size.height/2)-35, 50, 50)];
    imgloading.image=[UIImage imageNamed:@"loading"];
    [loadView addSubview:imgloading];
    
    imgback=[[UIImageView alloc]initWithFrame:CGRectMake(149,([[UIScreen mainScreen] bounds].size.height/2)-24,19, 28)];
    imgback.image=[UIImage imageNamed:@"loadingpin"];
    [loadView addSubview:imgback];
    
    timerloading=[NSTimer timerWithTimeInterval:1.5f target:self selector:@selector(startApp) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timerloading forMode:NSDefaultRunLoopMode];
    
    [_window.rootViewController.view addSubview:loadView];
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 3.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)startApp
{
    [self runSpinAnimationOnView:imgloading duration:6.0 rotations:0.5 repeat:100];
    
}

// Loading indicator stop //

-(void)stopIndicator
{
    [loadView removeFromSuperview];
    [[UIApplication sharedApplication]endIgnoringInteractionEvents];
}
+(AppDelegate *)appDelegate
{
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]);
    
}


# pragma mark - Core data Delegate
// core data.....

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NAMEOFYOURMODELHERE" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NAMEOFYOURMODELHERE.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
