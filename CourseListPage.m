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
    NSArray *recipes;
    NSArray *searchResults;
}
@end

@implementation CourseListPage

@synthesize courseTable,titleLbl,searchBtn,dotLineImg,bottonTabbarImg;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isSearch = NO;
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    

    courseTable.delegate = self;
    courseTable.dataSource = self;
    courseTable.backgroundColor = [UIColor clearColor];
    courseTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    titleLbl.text = LocalizedString(@"I'm looking for");
    [GlobalClass setTopTitleLabel:titleLbl];
    
    
    bottonTabbarImg.backgroundColor = [UIColor customTabbarColor];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
    return [recipes count];
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
        tilteLbl.text = [recipes objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
