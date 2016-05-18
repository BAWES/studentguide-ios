//
//  DetaliPage.h
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"
#import "DetailCell.h"
#import "iCarousel.h"

@interface DetaliPage : UIViewController <UITextViewDelegate,UITextFieldDelegate,iCarouselDataSource, iCarouselDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *table;

//@property (nonatomic, strong) IBOutlet iCarousel *carousel;




@end
