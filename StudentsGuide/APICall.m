//
//  APICall.m
//  Mcomcustomer
//
//  Created by sadeeshmac on 11/13/15.
//  Copyright © 2015 technoduce. All rights reserved.

#import "APICall.h"


@implementation APICall
@synthesize receivedData;

+ (APICall *)sharedInstance
{
    static APICall *sharedInstance;
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}


-(void)getMethod:(NSString *)url user:(NSString *)user_id  PostBody:(NSString *)body method:(NSString *)Method View:(UIViewController*)view boolean:(BOOL)isFirst completion:(void(^)(NSDictionary* jsonDict))handler

{
    
    
    __block STHTTPRequest *request = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@",url]];
        request.HTTPMethod = Method;
        
        
        request.completionBlock=^(NSDictionary *headers, NSString *body)
        {
            
            NSDictionary *jsonDict  = [NSJSONSerialization JSONObjectWithData:[body dataUsingEncoding:NSUTF8StringEncoding]options:0 error:NULL];
            handler(jsonDict);
        };
        request.errorBlock=^(NSError *error)
        {
            NSLog(@"Error: %@", [error localizedDescription]);
        };
        [request startAsynchronous];
}

@end
