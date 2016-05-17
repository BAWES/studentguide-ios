//
//  ContactUsPage.h
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"


@interface ContactUsPage : UIViewController<UITextViewDelegate,UITextFieldDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIImageView *naviagationImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;

@property (strong, nonatomic) IBOutlet UIView *nameTxtBg;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIView *textViewBg;
@property (strong, nonatomic) IBOutlet UIImageView *textViewBgLineImg;
@property (strong, nonatomic) IBOutlet UIView *contactBgView;
@property (strong, nonatomic) IBOutlet UIImageView *contactBgLineImg;
@property (strong, nonatomic) IBOutlet UIImageView *nameBGLineImg;

@property (strong, nonatomic) IBOutlet UITextField *nameTxt;

@property (strong, nonatomic) IBOutlet UITextField *contactTxt;


- (IBAction)back:(id)sender;
- (IBAction)submit:(id)sender;



@end
