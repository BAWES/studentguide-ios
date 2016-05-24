//
//  CoreDataHelper.m
//  Nectarchat
//
//  Created by Vanithasree on 10/12/15.
//  Copyright © 2015 technoduce. All rights reserved.
//

#import "CoreDataHelper.h"
#import "GlobalClass.h"


@implementation CoreDataHelper
@synthesize  context;
@synthesize objectModel;
@synthesize coordinator;

static CoreDataHelper *coreDataHelper;


+(CoreDataHelper *)sharedontabeeDB
{
    if (coreDataHelper == nil) {
        coreDataHelper = [[CoreDataHelper alloc] init];
        [coreDataHelper initializeContext];
    }
    return coreDataHelper;
    
}
-(NSString *)getApplicationDocumentsDirectoryPath
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath=([paths count]>0) ? [paths objectAtIndex:0]: nil;
    return basePath;
}
- (NSManagedObjectModel *) initilizeManagedObjectModel{
    if (objectModel != nil) {
        return objectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return objectModel;
}
-(NSPersistentStoreCoordinator *) initilizeManagedPersistentStoreCoordinator{
    if (coordinator != nil) {
        return coordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath:[[self getApplicationDocumentsDirectoryPath]stringByAppendingPathComponent: @"ontabee.sqlite"]];
    NSError *error = nil;
    coordinator = [[NSPersistentStoreCoordinator alloc]
                   initWithManagedObjectModel:[self initilizeManagedObjectModel]];
    if (![coordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil URL:storeUrl options:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                           [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                                                           [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil] error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return coordinator;
}
-(void) initializeContext{
    if (context == nil) {
        NSPersistentStoreCoordinator *acoordinator = [self initilizeManagedPersistentStoreCoordinator];
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:acoordinator];
    }
}
-(void) saveCurrentContext{
    NSError *error = nil;
    if (context != nil) {
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}



-(NSMutableArray *)fetchShopListFromDB:(NSString *)entityName
{
    NSMutableArray *shopDBListArray=[[NSMutableArray alloc]init];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    [fetchRequest setReturnsObjectsAsFaults:NO];
    
   NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (objects.count)
    {
        shopDBListArray=[objects mutableCopy];
    }
    
    
 return shopDBListArray;
}


-(void)clearShopListDB:(NSString *)entityName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    [fetchRequest setIncludesPropertyValues:NO];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    
    error = nil;
    [context save:&error];
       
}

//Details
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues EntityName:(NSString *)entityName
{
     NSManagedObject * branchItem  = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    NSDictionary *attributes = [entity attributesByName];
    int itemCount=0;
    for (NSString *attribute in attributes)
    {
      
        id value = [keyedValues objectForKey:[NSString stringWithFormat:@"%@",attribute]];
        
        if (value == nil) {
            // Don't attempt to set nil, or you'll overwite values in self that aren't present in keyedValues
            continue;
        }
        itemCount++;
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]]))
        {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]]))
        {
            
            
           value = [NSNumber numberWithInteger:[value  integerValue]];
               [branchItem setValue:value  forKey:attribute];
            
        } else if ((attributeType == NSFloatAttributeType) && ([value isKindOfClass:[NSString class]]))
        {
            value = [NSNumber numberWithFloat:[value floatValue]];
        }
        else if(attributeType ==NSBinaryDataAttributeType)
        {
        [branchItem setValue:[[GlobalClass sharedInstance] setReceiveList:value] forKey:attribute];
        }
        else  if(attributeType ==NSDoubleAttributeType)
        {
            [branchItem setValue:value  forKey:attribute];
        }
      
        else
        {
        [branchItem setValue:[NSString stringWithFormat:@"%@",value] forKey:attribute];
        }
    }
    
    NSError *error = nil;
    
    if ([context save:&error])
    {
        
    }

}
@end
