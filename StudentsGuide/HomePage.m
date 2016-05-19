//
//  IntroPage.m
//  StudentsGuide
//
//  Created by Karthick on 12/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "HomePage.h"
#import "GlobalClass.h"

//#import "UIViewController+LocalizeConstrint.h"
//#import "UIView+viewRecursion.h"

@interface HomePage ()

@end

@implementation HomePage

@synthesize arabicBtn,englishBtn,termsCondotion;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    
    [GlobalClass setBorder:arabicBtn];
    [GlobalClass setBorder:englishBtn];
    
    [arabicBtn setTitle:LocalizedString(@"Arabic") forState:UIControlStateNormal];
    [englishBtn setTitle:LocalizedString(@"English") forState:UIControlStateNormal];
    [termsCondotion setTitle:LocalizedString(@"Terms & Condition") forState:UIControlStateNormal];
    
    [termsCondotion setTitleColor:[UIColor customBtnTitleColor] forState:UIControlStateNormal];
    [termsCondotion setBackgroundColor:[UIColor customBtnClearColor]];
    termsCondotion.titleLabel.font = [UIFont customEnglishFontRegular10];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

# pragma mark - Button actions

- (IBAction)arabicChoose:(id)sender // choose arabic
{
//    for (UIView *tempView in [self.view allSubViews]) {
//        
//        [self changeViewRTL:tempView];
//    }
    
    [self.arabicBtn setBackgroundColor:[UIColor selectBtnColor]];
    [self.englishBtn setBackgroundColor:[UIColor clearColor]];
    [GlobalClass setLanguage:@"ar"];
    LocalizationSetLanguage(@"ar");
    LocalizedString(@"ar");
    
    [self courseListPage];
    
//    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
//    
//    NSLog(@"language=%@",language);
//    
//#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//    
//    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
//    {
//        if ([language isEqualToString:@"ar-US"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//        }
//        else if ([language isEqualToString:@"ar-US"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        }
//        else if ([language isEqualToString:@"en-US"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//            
//        }
//        else if ([language isEqualToString:@"en-US"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
//        {
//            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        }
//    }

    
}

- (IBAction)englishChoose:(id)sender  // chooose English
{
    [self.englishBtn setBackgroundColor:[UIColor selectBtnColor]];
    [self.arabicBtn setBackgroundColor:[UIColor clearColor]];
    
    
    [GlobalClass setLanguage:@"en"];
    LocalizationSetLanguage(@"en");
    LocalizedString(@"en");
    
    [self courseListPage];
    
}
// move to next page courseListPage viewcontroller
-(void)courseListPage
{
    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *language = [userLanguage substringToIndex:2];

    NSLog(@"language=%@ ==%@",userLanguage,language);
    
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
    if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
    {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    }
    else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
    {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
//        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    }
    else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
    {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
//        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    }
    else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
    {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
    }
    }

    CourseListPage *coursepage = [self.storyboard instantiateViewControllerWithIdentifier:@"CourseListPage"];
    [self.navigationController pushViewController:coursepage animated:YES];
}
- (IBAction)termsAndCodition:(id)sender
{
    TermsAndCondition *termsPage = [ self.storyboard instantiateViewControllerWithIdentifier:@"TermsAndCondition"];
    [self.navigationController pushViewController:termsPage animated:YES];
}
@end
