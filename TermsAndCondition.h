//
//  TermsAndCondition.h
//  StudentsGuide
//
//  Created by Karthick on 13/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@interface TermsAndCondition : UIViewController<UIWebViewDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UIImageView *navigationImageView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;

//
- (IBAction)back:(id)sender;
@end
