//
//  CourseListPage.h
//  StudentsGuide
//
//  Created by Karthick on 13/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrefixHeader.pch"

@interface CourseListPage : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>

{
    UISearchBar *searchBar;
    UISearchDisplayController *controller;
    NSMutableArray *filteredResult;
    NSMutableArray *tableData;
    
    UITableView *searchTableView;
    BOOL isSearch;
}
@property (strong, nonatomic) IBOutlet UITableView *courseTable;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dotLineImg;

- (IBAction)search:(id)sender;

@end
