//
//  GlobalClass.h
//  Mcomcustomer
//
//  Created by sadeeshmac on 11/14/15.
//  Copyright © 2015 technoduce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "Constant.h"
#import "NSString+validation.h"
#import "STHTTPRequest.h"
#import "PrefixHeader.pch"
#import "MBProgressHUD.h"


@interface GlobalClass : NSObject <UIAlertViewDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    
}

+(void)showToast:(NSString *)title message:(NSString *)Message view:(UIViewController *)View;

+(void)showAlertwithtitle:(NSString *)title message:(NSString *)Message view:(UIViewController *)View;

+(void)animateTextField:(UITextField*)textField1 txt:(UIView *)viewc val:(int)value up:(BOOL)up;

+ (GlobalClass *)sharedInstance;

+(BOOL)networkConnectAvailable;

+(BOOL)isEmptyString:(NSString *)string;

+(BOOL)isEmptyData:(NSData *)string;

+(void)UnderLineStyleTextField:(UITextField *)textField;

+(void)setBorder:(UIButton *)button;

+(void)setLanguage:(NSString*)lang;

+(NSString*)getLanguage;

+(UIBarButtonItem *)NewButtonInView:(UIView *)view withAction:(SEL)actionbutton withTarget:(id)target;

- (id)init;

+(void)setupLabel:(UILabel*)label;

+(MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title controller:(UIView *)view;

+(void)dismissGlobalHUD:(UIView *)view;

+(void)setTopTitleLabel:(UILabel*)label;

+(void)setTableLbl:(UILabel*)label;

+(void)setSearchTableSubTitleLbl:(UILabel*)label;

+(void)setSearchTableTitleLbl:(UILabel*)label;

+(void)setUPTextfield:(UITextField *)textField;



@end
