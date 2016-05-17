//
//  AppDelegate.h
//  StudentsGuide
//
//  Created by sadeeshmac on 5/11/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIView *loadView;
    UIImageView *imgloading,*imgback;
    NSTimer *timerloading;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;

-(void)starIndicator;
-(void)stopIndicator;
+(AppDelegate *)appDelegate;

@end

