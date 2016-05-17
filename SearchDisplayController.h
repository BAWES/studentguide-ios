//
//  SearchDisplayController.h
//  StudentsGuide
//
//  Created by Karthick on 14/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrefixHeader.pch"

@interface SearchDisplayController : UIViewController<UISearchBarDelegate>

{
    NSArray *searchResultsArray;
    NSMutableArray *userMutableArray;
    BOOL isActive;
}
@property (strong, nonatomic) IBOutlet UITextField *searchText;

@property (strong, nonatomic) IBOutlet UIView *searchBackView;
@property (strong, nonatomic) IBOutlet UIView *searchLineImg;

@property (strong, nonatomic) IBOutlet UITableView *searchTableView;

@end
