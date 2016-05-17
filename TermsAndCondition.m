//
//  TermsAndCondition.m
//  StudentsGuide
//
//  Created by Karthick on 13/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "TermsAndCondition.h"

@interface TermsAndCondition ()

@end

@implementation TermsAndCondition

@synthesize navigationImageView,backBtn,webView,titleLbl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    webView.delegate = self;
    
    // set naviagtion image color
    self.navigationImageView.backgroundColor = [UIColor customNavigationColor];
    
    // set title
    titleLbl.text = LocalizedString(@"Terms & Condition");
    [GlobalClass setupLabel:titleLbl];
    // load url in Webview
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.bbc.com/arabic"]]];
    
    // add activity
    [GlobalClass showGlobalProgressHUDWithTitle:@"" controller:self.view];
    
    // set back button image
    [backBtn setImage:[UIImage imageNamed:@"Leftarrow"] forState:UIControlStateNormal];
    NSLog(@"%@",[GlobalClass getLanguage]);
    

    
    #define SYSTEM_VERSION_LESS_THAN(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *language = [userLanguage substringToIndex:2];
    
    NSLog(@"language=%@ ==%@",userLanguage,language);
    
    if (SYSTEM_VERSION_LESS_THAN(@"9.0"))
    {
            if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
            {
                for (UIView *tempView in [self.view allSubViews])
                {
                    [self changeViewRTL:tempView];
                }
            }
            else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
            {
                for (UIView *tempView in [self.view allSubViews])
                {
                    [self changeViewRTL:tempView];
                }
            }
            else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
            {
                
            }
            else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
            {
                
            }
    }
    else
    {
        [backBtn setImage:[UIImage imageNamed:@"Rightarrow"] forState:UIControlStateNormal];
        
        if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }

        
        if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            [backBtn setImage:[UIImage imageNamed:@"Leftarrow"] forState:UIControlStateNormal];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            [backBtn setImage:[UIImage imageNamed:@"Leftarrow"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark Webview delegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // remove activity
    [GlobalClass dismissGlobalHUD:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
