//
//  LocalizeHelper.m
//  AnfaLimo
//
//  Created by APPLE on 11/20/14.
//  Copyright (c) 2014 Ndot. All rights reserved.
//

#import "LocalizeHelper.h"

static LocalizeHelper* SingleLocalSystem = nil;

static NSBundle* myBundle = nil;
@implementation LocalizeHelper

+ (LocalizeHelper*) sharedLocalSystem {
    // lazy instantiation
    if (SingleLocalSystem == nil) {
        SingleLocalSystem = [[LocalizeHelper alloc] init];
    }
    return SingleLocalSystem;
}


//-------------------------------------------------------------
// initiating
//-------------------------------------------------------------
- (id) init {
    self = [super init];
    if (self) {
        // use systems main bundle as default bundle
        myBundle = [NSBundle mainBundle];
    }
    return self;
}

//-------------------------------------------------------------
// translate a string
//-------------------------------------------------------------
// you can use this macro:
// LocalizedString(@"Text");
- (NSString*) localizedStringForKey:(NSString*) key {
    // this is almost exactly what is done when calling the macro NSLocalizedString(@"Text",@"comment")
    // the difference is: here we do not use the systems main bundle, but a bundle
    // we selected manually before (see "setLanguage")
    return [myBundle localizedStringForKey:key value:@"" table:nil];
}


//-------------------------------------------------------------
// set a new language
//-------------------------------------------------------------
// you can use this macro:
// LocalizationSetLanguage(@"German") or LocalizationSetLanguage(@"de");
- (void) setLanguage:(NSString*) lang {
    
    // path to this languages bundle
    NSString *path = [[NSBundle mainBundle] pathForResource:lang ofType:@"lproj" ];
    if (path == nil) {
        // there is no bundle for that language
        // use main bundle instead
        myBundle = [NSBundle mainBundle];
    } else {
        
        // use this bundle as my bundle from now on:
        myBundle = [NSBundle bundleWithPath:path];
        
        // to be absolutely shure (this is probably unnecessary):
        if (myBundle == nil) {
            myBundle = [NSBundle mainBundle];
        }
    }
}

@end
