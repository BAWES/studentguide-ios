//
//  DetailCell.h
//  StudentsGuide
//
//  Created by Karthick on 18/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
{
    
}

@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *callBtn;
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UIButton *locationBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;


- (IBAction)back:(id)sender;
- (IBAction)location:(id)sender;
- (IBAction)call:(id)sender;

@end
