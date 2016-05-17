
//
//  ContactUsPage.m
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "ContactUsPage.h"

@interface ContactUsPage ()

@end

@implementation ContactUsPage

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.naviagationImage.backgroundColor = [UIColor customNavigationColor];
    [GlobalClass setupLabel:self.titleLbl];
    
    self.titleLbl.text = LocalizedString(@"Contact US");
    self.nameTxt.placeholder = LocalizedString(@"Name");
    self.contactTxt.placeholder = LocalizedString(@"Contact number");
    self.textView.text = LocalizedString(@"Message");
    [self.submitBtn setTitle:LocalizedString(@"Submit") forState:UIControlStateNormal];
    
    [GlobalClass setBorder:self.submitBtn];
    
    self.nameTxtBg.layer.cornerRadius = self.nameTxtBg.frame.size.height/2;
    self.nameTxtBg.clipsToBounds = YES;
    
    self.contactBgView.layer.cornerRadius = self.contactBgView.frame.size.height/2;
    self.contactBgView.clipsToBounds = YES;
    
    self.textViewBg.layer.cornerRadius = 8.0f;
    self.textViewBg.clipsToBounds = YES;
    
    [GlobalClass setUPTextfield:self.nameTxt];
    [GlobalClass setUPTextfield:self.contactTxt];
    
    self.contactTxt.delegate = self;
    self.nameTxt.delegate = self;
    
    self.textView.delegate = self;
    
    self.textView.textColor = [UIColor whiteColor];
    
    self.contactTxt.textAlignment = NSTextAlignmentLeft;
    self.nameTxt.textAlignment = NSTextAlignmentLeft;
    self.textView.textAlignment = NSTextAlignmentLeft;
    
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
            self.contactTxt.textAlignment = NSTextAlignmentRight;
            self.nameTxt.textAlignment = NSTextAlignmentRight;
            self.textView.textAlignment = NSTextAlignmentRight;
            
            
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
            // [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            self.contactTxt.textAlignment = NSTextAlignmentRight;
            self.nameTxt.textAlignment = NSTextAlignmentRight;
            self.textView.textAlignment = NSTextAlignmentRight;
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
            // [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
    }
    else
    {
        if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            
        }
        else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            for (UIView *tempView in [self.view allSubViews])
            {
                [self changeViewRTL:tempView];
            }
            self.contactTxt.textAlignment = NSTextAlignmentRight;
            self.nameTxt.textAlignment = NSTextAlignmentRight;
            self.textView.textAlignment = NSTextAlignmentRight;
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            for (UIView *tempView in [self.view allSubViews])
            {
                [self changeViewRTL:tempView];
            }
            self.contactTxt.textAlignment = NSTextAlignmentRight;
            self.nameTxt.textAlignment = NSTextAlignmentRight;
            self.textView.textAlignment = NSTextAlignmentRight;
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            
        }
    }
    
    
    
}
# pragma Mark - TextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];// this will do the trick
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [GlobalClass animateTextField:textField txt:self.view val:80 up:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [GlobalClass animateTextField:textField txt:self.view val:80 up:NO];
}

# pragma Mark - TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:LocalizedString(@"Message")])
    {
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
    [textView becomeFirstResponder];
    
    [self animateTextView: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        textView.text =LocalizedString(@"Message");
        textView.textColor = [UIColor whiteColor];
    }
    [textView resignFirstResponder];
    
    [self animateTextView:NO];
}

- (void) animateTextView:(BOOL) up
{
    const int movementDistance = -110; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? movementDistance : -movementDistance);
    
    [UIView beginAnimations: @"animateTextField" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit:(id)sender
{
    if ([GlobalClass isEmptyString:self.nameTxt.text])
    {
        [GlobalClass showToast:@"" message:LocalizedString(@"Please enter your name") view:self];
    }
    else if ([GlobalClass isEmptyString:self.contactTxt.text])
    {
        [GlobalClass showToast:@"" message:LocalizedString(@"Please enter your contact number") view:self];
    }
    else if ([self.textView.text isEqualToString:LocalizedString(@"Message")])
    {
        [GlobalClass showToast:@"" message:LocalizedString(@"Please enter your message") view:self];
    }
    else
    {
        
    }
}
@end
