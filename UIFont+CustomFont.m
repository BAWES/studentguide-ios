//
//  UIFont+CustomFont.m
//  Taxiapp
//
//  Created by Karthick on 11/05/16.
//  Copyright © 2016 premmac. All rights reserved.
//

#import "UIFont+CustomFont.h"


//DroidKufi-Bold
//DroidKufi-Regular
//FontAwesome
//Montserrat-Bold
//Montserrat-Regular


@implementation UIFont (CustomFont)

// English Font

// English title font
+(UIFont*)customEnglishTitleFont
{
    return [UIFont fontWithName:@"Montserrat-Bold" size:20.0f];
}

// medium regular font
+(UIFont*)customEnglishFontRegular14
{
    return [UIFont fontWithName:@"Montserrat-Regular" size:14.0f];
}

// medium bold font
+(UIFont*)customEnglishFontBold14
{
    return [UIFont fontWithName:@"Montserrat-Bold" size:14.0f];
}

// small regular font
+(UIFont*)customEnglishFontRegular10
{
    return [UIFont fontWithName:@"Montserrat-Regular" size:10.0f];
}

// small bold font
+(UIFont*)customEnglishFontBold10
{
    return [UIFont fontWithName:@"Montserrat-Bold" size:10.0f];
}

//Arabic font

// Arabic title font
+(UIFont*)customArabicTitleFont
{
    return [UIFont fontWithName:@"DroidKufi-Bold" size:20.0f];
}

// small regular font
+(UIFont*)customArabicFontRegular10
{
    return [UIFont fontWithName:@"DroidKufi-Regular" size:10.0f];
}

// small bold font
+(UIFont*)customArabicFontBold10
{
    return [UIFont fontWithName:@"DroidKufi-Bold" size:10.0f];
}

// medium regular font
+(UIFont*)customArabicFontRegular14
{
    return [UIFont fontWithName:@"DroidKufi-Regular" size:14.0f];
}

// medium bold font
+(UIFont*)customArabicFontBold14
{
    return [UIFont fontWithName:@"DroidKufi-Bold" size:14.0f];
}

// Awesome Font 
+(UIFont*)customAwesomFont
{
    return [UIFont fontWithName:@"FontAwesome" size:30.0f];
}


@end
