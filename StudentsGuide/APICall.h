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
- (void)sendMethod:(NSString *)postUrl postDictionary:(NSDictionary *)postDictionary delegate:(id)className method:(NSString *)Method key:(NSString *)key;
- (void)didFinishLoading:(NSDictionary *)dictonary key:(NSString *)key;

@end
