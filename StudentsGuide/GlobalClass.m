//
//  GlobalClass.m
//  Mcomcustomer
//
//  Created by sadeeshmac on 11/14/15.
//  Copyright © 2015 technoduce. All rights reserved.
//

#import "GlobalClass.h"
#import "UIColor+custom.h"
#import "UIViewController+LocalizeConstrint.h"
#import "UIView+viewRecursion.h"


//[[AppDelegate appdelegate]showGlobalProgressHUDWithTitle:@""];
#define IS_IOS_GREATER_EQUAL8     ([[UIDevice currentDevice].systemVersion compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
@interface GlobalClass () <UITextFieldDelegate>
{
    
}
@end

@implementation GlobalClass

+ (GlobalClass *)sharedInstance
{
    static GlobalClass *sharedInstance;
    
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
# pragma mark - Alert
+(void)showAlertwithtitle:(NSString *)title message:(NSString *)Message view:(UIViewController *)View

{
    if (IS_IOS_GREATER_EQUAL8)
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:title
                                              message:Message
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"Ok"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
        [alertController addAction:okAction];
        [View presentViewController:alertController animated:YES completion:nil];
    }

    else
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:title message:Message delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
        
        [alert1 show];
    }
    
}

# pragma mark - Toast
//toast
+(void)showToast:(NSString *)title message:(NSString *)Message view:(UIViewController *)View
{
    if (IS_IOS_GREATER_EQUAL8)
    {
        UIAlertController * alert=   [UIAlertController alertControllerWithTitle:nil message:Message preferredStyle:UIAlertControllerStyleAlert];
      [View presentViewController:alert animated:YES completion:nil];
        int duration = 1; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [View dismissViewControllerAnimated:YES completion:nil];
        });
    }
    else
    {
        UIAlertView *toast= [[UIAlertView alloc] initWithTitle:nil message:Message delegate:View cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [toast show];
        int duration = 1; // duration in seconds
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [toast dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}

# pragma mark - Check network connection
//Network Availablity
+(BOOL)networkConnectAvailable
{
    Reachability *reach=[Reachability reachabilityWithHostname:@"www.google.com"];
    NetworkStatus internetStatus= [reach currentReachabilityStatus];
    if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

# pragma mark animate Textfield
//animated textfield
+(void)animateTextField:(UITextField*)textField1 txt:(UIView *)viewc val:(int)value up:(BOOL)up
{
    const int movementDistance =-value;// -130; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement = (up ? movementDistance : -movementDistance);
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    viewc.frame = CGRectOffset(viewc.frame, 0, movement);
    [UIView commitAnimations];
}

# pragma mark - Validation
// is string or textfield empty validation
+(BOOL)isEmptyString:(NSString *)string
{
    if ((NSNull *)string == [NSNull null] || (string == nil) || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"])
    {
        return  YES;
    }
    string =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

// IsData is empty
+(BOOL)isEmptyData:(NSData *)string
{
    if ((NSNull *)string == [NSNull null] || (string == nil))
    {
        return  YES;
    }
    return NO;
}

#pragma mark UitextField UnderLine
+(void)UnderLineStyleTextField:(UITextField *)textField // Set Textfield bottom border
{
    CALayer *textFieldbottomBorder = [CALayer layer];
    textFieldbottomBorder.frame = CGRectMake(0.0f, textField.frame.size.height -1, textField.frame.size.width, 1.0f);
    textFieldbottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [textField.layer addSublayer:textFieldbottomBorder];
}

+(void)setUPTextfield:(UITextField *)textField
{
     [textField setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];
//    textField.delegate = view;
    textField.textColor = [UIColor customWhiteColor];
    textField.font = [UIFont customEnglishFontRegular10];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
    textField.font = [UIFont customArabicFontRegular10];
    }
}


# pragma mark - set Button Border
+(void)setBorder:(UIButton *)button // set button setup
{
    [button setTitleColor:[UIColor customBtnTitleColor] forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont customEnglishFontRegular14];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
     button.titleLabel.font = [UIFont customArabicFontRegular14];
    }
    
    button.backgroundColor = [UIColor customBtnClearColor];
    button.layer.borderColor = [UIColor customBtnBorderColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = button.frame.size.height/2;
}

# pragma mark - set & get Language
+(void)setLanguage:(NSString*)lang // set selectes languag
{
    [[NSUserDefaults standardUserDefaults]setObject:lang forKey:Language];
}
+(NSString*)getLanguage //get selected language
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:Language];
}

# pragma mark - Create Bar button 
// Create bar button for global
+(UIBarButtonItem *)NewButtonInView:(UIView *)view withAction:(SEL)actionbutton withTarget:(id)target
{
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStyleBordered target:self action:nil];
    return menuBarButton;
}

#pragma mark - label setup
// setup naviagtion title label 
+(void)setupLabel:(UILabel*)label
{
    label.textColor = [UIColor navigationTitleColor];
    label.font = [UIFont customEnglishTitleFont];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        label.font = [UIFont customArabicTitleFont];
    }
    label.textAlignment = NSTextAlignmentCenter;
}

// setup naviagtion top title label
+(void)setTopTitleLabel:(UILabel*)label
{
    label.textColor = [UIColor customTopTitleColor];
    label.font = [UIFont customEnglishTitleFont];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        label.font = [UIFont customArabicTitleFont];
    }
    label.textAlignment = NSTextAlignmentCenter;
}

+(void)setTableLbl:(UILabel*)label
{
    label.textColor = [UIColor customWhiteColor];
    label.font = [UIFont customEnglishFontRegular14];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        label.font = [UIFont customArabicFontBold14];
    }
    label.layer.borderColor = [UIColor customBtnBorderColor].CGColor;
    
    label.clipsToBounds = YES;
    label.layer.cornerRadius = label.frame.size.height/2;
    label.layer.borderWidth = 2.0;
    label.textAlignment = NSTextAlignmentCenter;
}

// setup searchControll table title label

+(void)setSearchTableTitleLbl:(UILabel*)label
{
    label.textColor = [UIColor blackColor];
    label.font = [UIFont customEnglishFontRegular14];
    NSInteger alignment = NSTextAlignmentLeft;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        label.font = [UIFont customArabicFontRegular14];
        alignment = NSTextAlignmentRight;
    }
    label.textAlignment = alignment;
}
+(void)setSearchTableSubTitleLbl:(UILabel*)label
{
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont customEnglishFontRegular10];
    NSInteger alignment = NSTextAlignmentLeft;
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        label.font = [UIFont customArabicFontRegular10];
        alignment = NSTextAlignmentRight;
    }
    label.textAlignment = alignment;
}

# pragma Mark - activity progress
// progress view start
+ (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title controller:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
   hud.labelText = LocalizedString(@"Please wait...");
    hud.labelFont = [UIFont customEnglishTitleFont];
    hud.labelColor = [UIColor customThemeColor];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:Language] isEqualToString:@"ar"]) // is arabic language
    {
        hud.labelFont = [UIFont customArabicTitleFont];
    }
    
    return hud;
}
// progress view dismiss
+ (void)dismissGlobalHUD:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}
//+(void)layoutChange:(UIView*)view
//{
//    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
//    NSString *language = [userLanguage substringToIndex:2];
//    
//    NSLog(@"language=%@ ==%@",userLanguage,language);
//    
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//    
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
//    {
//        if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//        }
//        else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//        }
//        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        }
//        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        }
//    }
//    else
//    {
//        for (UIView *tempView in [view allSubViews])
//        {
//            [self changeViewRTL:tempView];
//        }
//    }
//
//}
@end
