//
//  SchoolsListPage.h
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PrefixHeader.pch"

@interface SchoolsListPage : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>

{
    UISearchBar *searchBar;
    UISearchDisplayController *controller;
    NSMutableArray *filteredResult;
    NSMutableArray *tableData;
    
    UITableView *searchTableView;
    BOOL isSearch;
}
@property(strong ,nonatomic)IBOutlet NSString *subtitleStr;

@property (strong, nonatomic) IBOutlet UIImageView *subNavigationBarImg;
@property (strong, nonatomic) IBOutlet UITableView *courseTable;
@property (strong, nonatomic) IBOutlet UIButton *searchBtn;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *dotLineImg;
@property (strong, nonatomic) IBOutlet UIImageView *bottonTabbarImg;
@property (strong, nonatomic) IBOutlet UIButton *homeBtn;
@property (strong, nonatomic) IBOutlet UIButton *contactusBtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UILabel *subTitleLbl;

- (IBAction)search:(id)sender;
- (IBAction)contactUs:(id)sender;
- (IBAction)home:(id)sender;
- (IBAction)back:(id)sender;


@end
