//
//  NSString+validation.m
//  Nutrient
//
//  Created by sadeeshmac on 31/12/14.
//  Copyright (c) 2014 sadeeshmac. All rights reserved.
//

#import "NSString+validation.h"

@implementation NSString (validation)

// check email Validation
-(BOOL)isValidEmail
{
    NSString *regex=@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [emailpredicate evaluateWithObject:self];
}

-(NSString *)removenumberfronnsstring:(NSString *)removestrinng // trming string
{
    NSString *trimmingstr;
    NSCharacterSet *character=[NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    trimmingstr=[removestrinng stringByTrimmingCharactersInSet:character];
    return trimmingstr;
}
@end
