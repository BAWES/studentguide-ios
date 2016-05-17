//
//  APICall.m
//  Mcomcustomer
//
//  Created by sadeeshmac on 11/13/15.
//  Copyright © 2015 technoduce. All rights reserved.

#import "APICall.h"


@implementation APICall
@synthesize receivedData;

- (void)sendMethod:(NSString *)postUrl postDictionary:(NSDictionary *)postDictionary delegate:(id)className method:(NSString *)Method key:(NSString *)key;
{
   
    if ([GlobalClass networkConnectAvailable])
    {
        __block STHTTPRequest *request = [STHTTPRequest requestWithURLString:[NSString stringWithFormat:@"%@",postUrl]];
       
        classNameDelegate = className;
        keyString = key;
        
        if ([Method isEqualToString:@"GET"])
        {
             request.HTTPMethod = @"GET";

        }
        else if([Method isEqualToString:@"RAW"])
        {
            request.HTTPMethod = @"POST";
            NSError * err;
            NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:postDictionary options:0 error:&err];
            NSString * postBody = [[NSString alloc] initWithData:jsonData   encoding:NSUTF8StringEncoding];
            request.rawPOSTData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
 
        }
        else if ([Method isEqualToString:@"POST"])
        {
            request.HTTPMethod = @"POST";
            request.POSTDictionary=[postDictionary mutableCopy];
        }
        else if ([Method isEqualToString:@"GETPOST"])
        {
            request.GETDictionary=[postDictionary mutableCopy];
        }
        else if ([Method isEqualToString:@"GOOGLE"]){
            
        }
        
        request.completionBlock=^(NSDictionary *headers, NSString *responseBody)
        {
            
            NSDictionary *jsonDict  = [NSJSONSerialization JSONObjectWithData:[responseBody dataUsingEncoding:NSUTF8StringEncoding]options:0 error:NULL];
            
            if ([jsonDict count]>0)
            {
                if([classNameDelegate respondsToSelector:@selector(didFinishLoading:key:)])
                    [classNameDelegate didFinishLoading:jsonDict key:keyString];
                
            }        
        };
        request.errorBlock = ^(NSError *error)
        {
            NSLog(@"-- error: %@", error);
        };
        
        
        [request startAsynchronous];
        
    }
    
    
}

- (void)didFinishLoading:(NSDictionary *)dictonary key:(NSString *)key;
{
   
}
#pragma mark UIActivity Loading


@end
