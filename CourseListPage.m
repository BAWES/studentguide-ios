//
//  CourseListPage.m
//  StudentsGuide
//
//  Created by Karthick on 13/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "CourseListPage.h"
#import "SearchDisplayController.h"

@interface CourseListPage ()
{
    SearchDisplayController *search;
    NSMutableArray *categoryListArray;
    NSArray *searchResults;
}
@end

@implementation CourseListPage

@synthesize courseTable,titleLbl,searchBtn,dotLineImg,bottonTabbarImg;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString *msgFullString = ([[GlobalClass getLanguage] isEqualToString:@"ar"])? @"ar" : @"en" ;
//     NSString *msgFullString =[NSString stringWithFormat:@"Message: %@", [GlobalClass getLanguage]  ? [GlobalClass getLanguage]  : @"en"];
// NSString *str = [GlobalClass getLanguage] ? @"ar" : @"en";
   
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"isFirst"] == NULL)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isFirst"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    isFirst = [[NSUserDefaults standardUserDefaults]objectForKey:@"isFirst"];
    isSearch = NO;
   
    courseTable.delegate = self;
    courseTable.dataSource = self;
    courseTable.backgroundColor = [UIColor clearColor];
    courseTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    titleLbl.text = LocalizedString(@"I'm looking for");
    [GlobalClass setTopTitleLabel:titleLbl];
    
    
    bottonTabbarImg.backgroundColor = [UIColor customTabbarColor];
    
    // set background Image
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"ListBG"];
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack: bgImageView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self getData];
    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *language = [userLanguage substringToIndex:2];
    
    NSLog(@"language=%@ ==%@",userLanguage,language);
    
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
    
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0"))
    {
        if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
            //        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        }
    }
    else
    {
        if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            
        }
        else if ([language isEqualToString:@"ar"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            for (UIView *tempView in [self.view allSubViews])
            {
                [self changeViewRTL:tempView];
            }
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            for (UIView *tempView in [self.view allSubViews])
            {
                [self changeViewRTL:tempView];
            }
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            
        }
    }
    
}
// get data from api or local DB
-(void)getData
{
    
     categoryListArray  =[[NSMutableArray alloc]initWithArray:[[CoreDataHelper sharedontabeeDB]fetchShopListFromDB:@"CategoriesDB"]];
    
    if (categoryListArray.count >0)
        [courseTable reloadData];
    
    if ([GlobalClass networkConnectAvailable])
    {
        if (isFirst)
        [GlobalClass showGlobalProgressHUDWithTitle:@"" controller:self.view];
        
        [[APICall sharedInstance]getMethod:[NSString stringWithFormat:@"%@",CategoryList] user:@"" PostBody:@"" method:@"GET" View:self boolean:isFirst completion:^(NSDictionary *jsonDict)
     {
         if (isFirst)
         {
             [GlobalClass dismissGlobalHUD:self.view];
//             isFirst = NO;
             [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"isFirst"];
             [[NSUserDefaults standardUserDefaults]synchronize];
         }
         
         NSLog(@"Dict value =%@",jsonDict);
         if([[[jsonDict objectForKey:@"code"]description] isEqualToString:@"200"])
         {
             if ([[jsonDict valueForKeyPath:@"data.categories"]count]>0)
             {
                 [[CoreDataHelper sharedontabeeDB]clearShopListDB:@"CategoriesDB"];
                 
                 for (int categoryCount=0; categoryCount<[[jsonDict valueForKeyPath:@"data.categories"]count]; categoryCount++)
                 {
                     [[CoreDataHelper sharedontabeeDB]safeSetValuesForKeysWithDictionary:[[jsonDict valueForKeyPath:@"data.categories"] objectAtIndex:categoryCount] EntityName:@"CategoriesDB"];
                 }
             }
             categoryListArray  =[[NSMutableArray alloc]initWithArray:[[CoreDataHelper sharedontabeeDB]fetchShopListFromDB:@"CategoriesDB"]];
             [courseTable reloadData];
             NSLog(@"categoryArray =%@",categoryListArray);
         }
     }];
    }
    else
    {
        if (isFirst)
        {
            isFirst = NO;
            [GlobalClass showToast:@"" message:LocalizedString(@"Please check your internet connection") view:self];
        }
    }
    
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[categoryListArray valueForKey:@"category"]count];
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            UILabel *tilteLbl = [[UILabel alloc]initWithFrame:CGRectMake(20,10 ,self.view.frame.size.width-40 ,50)];
            tilteLbl.tag = 100;
            [GlobalClass setTableLbl:tilteLbl];
            [cell addSubview:tilteLbl];
        }
        UILabel *tilteLbl = (UILabel *) [cell viewWithTag:100];
    
        tilteLbl.text = ([[GlobalClass getLanguage] isEqualToString:@"ar"])? [[categoryListArray valueForKey:@"category_ar"] objectAtIndex:indexPath.row] : [[categoryListArray valueForKey:@"category_en"] objectAtIndex:indexPath.row];
    
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubCategoryListPage *subCat = [self.storyboard instantiateViewControllerWithIdentifier:@"SubCategoryListPage"];
    
    subCat.subtitleStr = ([[GlobalClass getLanguage] isEqualToString:@"ar"])? [[categoryListArray valueForKey:@"category_ar"] objectAtIndex:indexPath.row] : [[categoryListArray valueForKey:@"category_en"] objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:subCat animated:YES];
    
    NSLog(@"selected %ld row", (long)indexPath.row);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


# pragma mark Button Action
- (IBAction)search:(id)sender // search bar biutton action
{
    
    if (!isSearch) // isSearch = no means open popup
    {
        isSearch = YES;

        dotLineImg.hidden = YES;
        [searchBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        search = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDisplayController"];
        search.view.frame = courseTable.frame; // set frame for searchvontroller view
        [self.view addSubview:search.view]; // set popup
    }
    else // isSearch == yes means remove popup
    {
        dotLineImg.hidden = NO;
        [search.view removeFromSuperview];
        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        isSearch = NO;
    }
    
  }

- (IBAction)contactUs:(id)sender  // open contact us page
{
    ContactUsPage *contactPage = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsPage"];
    [self.navigationController pushViewController:contactPage animated:YES];
    
}

- (IBAction)home:(id)sender // open home page 
{
    HomePage *homepage = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
    [self presentViewController:homepage animated:YES completion:nil];
}



@end
