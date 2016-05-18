//
//  DetailCell.m
//  StudentsGuide
//
//  Created by Karthick on 18/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

@synthesize backBtn,callBtn,image,bgImage,titleLbl,locationBtn;

- (void)awakeFromNib
{
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)back:(id)sender {
}

- (IBAction)location:(id)sender {
}

- (IBAction)call:(id)sender {
}
@end
