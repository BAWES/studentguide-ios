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
    BOOL isFirst;
}
@property (strong, nonatomic) IBOutlet UITableView *courseTable;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dotLineImg;
@property (strong, nonatomic) IBOutlet UIImageView *bottonTabbarImg;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *contactusBtn;

- (IBAction)search:(id)sender;
- (IBAction)contactUs:(id)sender;
- (IBAction)home:(id)sender;

@end
