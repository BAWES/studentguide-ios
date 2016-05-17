//
//  IntroPage.h
//  StudentsGuide
//
//  Created by Karthick on 12/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@interface HomePage : UIViewController
{
    
}

//set Getter Setter Outlet
@property (strong, nonatomic) IBOutlet UIButton *arabicBtn;
@property (strong, nonatomic) IBOutlet UIButton *englishBtn;
@property (strong, nonatomic) IBOutlet UIButton *termsCondotion;

// set Button Action
- (IBAction)arabicChoose:(id)sender;
- (IBAction)englishChoose:(id)sender;
- (IBAction)termsAndCodition:(id)sender;



@end
