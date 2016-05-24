//
//  APICall.h
//  Mcomcustomer
//
//  Created by sadeeshmac on 11/13/15.
//  Copyright © 2015 technoduce. All rights reserved.

#import "GlobalClass.h"
#import <Foundation/Foundation.h>

@interface APICall : NSObject<NSURLSessionDelegate>
{
    NSMutableData *receivedData;
    NSURLSession *serverConnection;
    id classNameDelegate;
    NSString *keyString;

}
@property(nonatomic,strong) NSMutableData *receivedData;

+ (APICall *)sharedInstance;

-(void)getMethod:(NSString *)url user:(NSString *)user_id  PostBody:(NSString *)body method:(NSString *)Method View:(UIViewController*)view boolean:(BOOL)isFirst completion:(void(^)(NSDictionary* jsonDict))handler;

@end
