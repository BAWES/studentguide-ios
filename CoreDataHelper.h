//
//  CoreDataHelper.h
//  Nectarchat
//
//  Created by Vanithasree on 10/12/15.
//  Copyright © 2015 technoduce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrefixHeader.pch"
@interface CoreDataHelper : NSObject



@property (nonatomic)  int i;
@property (nonatomic, retain)NSManagedObjectContext *context;
@property (nonatomic, retain)NSManagedObjectModel *objectModel;
@property (nonatomic, retain)NSPersistentStoreCoordinator *coordinator;

+(CoreDataHelper *)sharedontabeeDB;

-(void)initializeContext;
-(NSString *)getApplicationDocumentsDirectoryPath;
-(NSPersistentStoreCoordinator *)initilizeManagedPersistentStoreCoordinator;
-(void)saveCurrentContext;

//methods to perform database operations
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues EntityName:(NSString *)entityName;
-(void)saveShopListToDB:(NSArray *)shopListArr;
-(NSMutableArray *)fetchShopListFromDB:(NSString *)entityName;
-(void)clearShopListDB:(NSString *)entityName;
-(void )updateCartItemsInDB:(NSString *)entityName  restaurantbranchitemkey  :(NSString *)restaurantbranchitemkey  noOfItems:( int)count  itemPrice:(double)price;

-(void )InsertCartItemsInDB:(NSDictionary *)cartitems;

@end
