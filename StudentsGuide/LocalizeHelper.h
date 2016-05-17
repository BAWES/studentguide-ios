//
//  LocalizeHelper.h
//  AnfaLimo
//
//  Created by APPLE on 11/20/14.
//  Copyright (c) 2014 Ndot. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LocalizedString(key) [[LocalizeHelper sharedLocalSystem] localizedStringForKey:(key)]

#define LocalizationSetLanguage(language) [[LocalizeHelper sharedLocalSystem] setLanguage:(language)]


@interface LocalizeHelper : NSObject

+ (LocalizeHelper*) sharedLocalSystem;

// this gets the string localized:
- (NSString*) localizedStringForKey:(NSString*) key;

//set a new language:
- (void) setLanguage:(NSString*) lang;

@end
