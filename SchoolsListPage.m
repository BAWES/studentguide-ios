//
//  SchoolsListPage.m
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "SchoolsListPage.h"

@interface SchoolsListPage ()
{
SearchDisplayController *search;
NSArray *recipes;
NSArray *searchResults;
    BOOL isSelect;
    UIView *filterView;
    UITableView *filterTbl;
    NSMutableArray *cellSelected;
}
@end

@implementation SchoolsListPage

@synthesize courseTable,titleLbl,searchBtn,dotLineImg,bottonTabbarImg,subtitleStr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cellSelected = [NSMutableArray array];
    
    self.subNavigationBarImg.backgroundColor = [UIColor customNavigationColor];
    
    filterView = [[UIView alloc]init];
    filterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filterView];
    
    UIImageView *bgImage = [[UIImageView alloc]init];
    bgImage.image = [UIImage imageNamed:@"ContactUsBG"];
    [filterView addSubview:bgImage];
    
    UILabel *headingLbl = [[UILabel alloc]init];
    headingLbl.text = LocalizedString(@"FILTER BY AREA");
    headingLbl.numberOfLines = 2;
    headingLbl.font = [UIFont customEnglishFontBold10];
    headingLbl.lineBreakMode = NSLineBreakByWordWrapping;
    headingLbl.textColor = [UIColor whiteColor];
    [filterView addSubview:headingLbl];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"crosscircle"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeFilter) forControlEvents:UIControlEventTouchUpInside];
    [filterView addSubview:closeBtn];
    
    filterTbl = [[UITableView alloc]init];
    filterTbl.backgroundColor = [UIColor clearColor];
    filterTbl.delegate = self;
    filterTbl.dataSource = self;
    [filterView addSubview:filterTbl];
    
    filterView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width/2, self.view.frame.size.height);
    bgImage.frame = CGRectMake(0, 0,filterView.frame.size.width, filterView.frame.size.height);
    [closeBtn setFrame:CGRectMake(filterView.frame.size.width-50, 10, 50, 50)];
    filterTbl.frame = CGRectMake(0,closeBtn.frame.origin.y+closeBtn.frame.size.height+20, filterView.frame.size.width, filterView.frame.size.height-closeBtn.frame.origin.y-closeBtn.frame.size.height-20);
    headingLbl.frame = CGRectMake(5, closeBtn.frame.origin.y, filterView.frame.size.width - closeBtn.frame.size.width-5 , 35);
    headingLbl.textAlignment = NSTextAlignmentLeft;
    
    
    if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
    {
    filterView.frame = CGRectMake(-self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height);
        bgImage.frame = CGRectMake(0, 0,filterView.frame.size.width, filterView.frame.size.height);
        [closeBtn setFrame:CGRectMake(0,10, 50, 50)];
        filterTbl.frame = CGRectMake(0,closeBtn.frame.origin.y+closeBtn.frame.size.height+20, filterView.frame.size.width, filterView.frame.size.height-closeBtn.frame.origin.y-closeBtn.frame.size.height-20);
        headingLbl.frame = CGRectMake(closeBtn.frame.origin.x+closeBtn.frame.size.width+5, closeBtn.frame.origin.y, filterView.frame.size.width - closeBtn.frame.origin.x-closeBtn.frame.size.width-5 , 50);
        headingLbl.textAlignment = NSTextAlignmentRight;
        headingLbl.font = [UIFont customArabicFontBold10];
    }
    
    
    
    
    isSearch = NO;
    isSelect = NO;
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    
    courseTable.delegate = self;
    courseTable.dataSource = self;
    
    titleLbl.text = LocalizedString(@"I'm looking for");
    [GlobalClass setTopTitleLabel:titleLbl];
    
    self.subTitleLbl.text = subtitleStr;
    [GlobalClass setupLabel:self.subTitleLbl];
    
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
            //            [_backBtn setImage:[UIImage imageNamed:@"Rightarrow"] forState:UIControlStateNormal];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            //             [_backBtn setImage:[UIImage imageNamed:@"Leftarrow"] forState:UIControlStateNormal];
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
#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == filterTbl)
    return [recipes count];
    
    else
    return [recipes count];
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableView == filterTbl)
    {
        if(!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [[UITableViewCell appearance] setTintColor:[UIColor whiteColor]];
        filterTbl.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor];

       
        [[cell viewWithTag:420]removeFromSuperview];
        
        UILabel  *filterLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, filterView.frame.size.width-40, 20)];
        filterLbl.text = [recipes objectAtIndex:indexPath.row];
        filterLbl.tag = 420;
        filterLbl.font = [UIFont customEnglishFontRegular10];
        filterLbl.textColor = [UIColor whiteColor];
        filterLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:filterLbl];
        
        if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
        {
            filterLbl.font = [UIFont customArabicFontRegular10];
            filterLbl.textAlignment = NSTextAlignmentRight;
            filterLbl.frame = CGRectMake(30, 5,filterView.frame.size.width-35 , 20);
        }
        
        if ([cellSelected containsObject:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
        
    }
    else
    {
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        AsyncImageView *imageView = [[AsyncImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100;
        
        [cell.contentView addSubview:imageView];
        
        UILabel *tablTitleLbl = [[UILabel alloc]init];
        tablTitleLbl.tag = 101;
        [GlobalClass setSearchTableTitleLbl:tablTitleLbl];
        [cell.contentView addSubview:tablTitleLbl];
        
        UIImageView *loactionImage = [[UIImageView alloc]init];
        loactionImage.contentMode = UIViewContentModeScaleAspectFit;
        loactionImage.tag = 103;
        [cell.contentView addSubview:loactionImage];
        
        UILabel *subTitleLbl = [[UILabel alloc]init];
        subTitleLbl.tag = 102;
        [GlobalClass setSearchTableSubTitleLbl:subTitleLbl];
        [cell.contentView addSubview:subTitleLbl];
        
    }
    AsyncImageView *imageView = (AsyncImageView *) [cell.contentView viewWithTag:100];
    UILabel *titleLbl = (UILabel *) [cell.contentView viewWithTag:101];
    UILabel *subTitleLbl = (UILabel *) [cell.contentView viewWithTag:102];
    UIImageView *loactionImage = (UIImageView *) [cell.contentView viewWithTag:103];
    
    
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [subTitleLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [loactionImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
     NSDictionary *views = NSDictionaryOfVariableBindings(imageView,titleLbl,loactionImage,subTitleLbl);
    if ([[GlobalClass getLanguage] isEqualToString:@"ar"])
    {
//        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:0]];
         [cell addConstraint: [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-8]];

        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(50)]-8-[titleLbl]-10-|" options:0 metrics:nil views:views]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(50)]-8-[loactionImage(20)]-[subTitleLbl]-10-|" options:0 metrics:nil views:views]];
        
        
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(50)]" options:0 metrics:nil views:views]];
        
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-10-[subTitleLbl(20)]-10-|" options:0 metrics:nil views:views]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-8-[loactionImage(20)]" options:0 metrics:nil views:views]];
        
    }
    else
    {
//        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:0]];
         [cell addConstraint: [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:8]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(50)]-[titleLbl]-10-|" options:0 metrics:nil views:views]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(50)]-[loactionImage(20)]-[subTitleLbl]-10-|" options:0 metrics:nil views:views]];
        
         [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(50)]" options:0 metrics:nil views:views]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-5-[subTitleLbl(20)]" options:0 metrics:nil views:views]];
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-5-[loactionImage(20)]" options:0 metrics:nil views:views]];
    }
        loactionImage.image = [UIImage imageNamed:@"location"];
        titleLbl.text = [recipes objectAtIndex:indexPath.row];
        imageView.image = [UIImage imageNamed:@"img"];
        subTitleLbl.text = @"subtitle";
    }
    return cell;
}
#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == filterTbl)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if ([cellSelected containsObject:indexPath])
        {
            [cellSelected removeObject:indexPath];
        }
        else
        {
            [cellSelected addObject:indexPath];
        }
        [tableView reloadData];
    }
    else
    {
    DetaliPage *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliPage"];
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"selected %ld row", (long)indexPath.row);
    }
}
// set uitableview cell height manually
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == filterTbl)
        return 30;
        else
            return 70;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.courseTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.courseTable setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.courseTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.courseTable setLayoutMargins:UIEdgeInsetsZero];
    }
}


# pragma  Mark - Button Actions
- (IBAction)search:(id)sender // search bar biutton action
{
    
    if (!isSearch) // isSearch = no means open popup
    {
        isSearch = YES;
        
        dotLineImg.hidden = YES;
        [searchBtn setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
        search = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDisplayController"];
        search.view.frame = CGRectMake(0, 55, self.view.frame.size.width, courseTable.frame.size.height+55);
        //        search.view.frame = courseTable.frame; // set frame for searchvontroller view
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

- (IBAction)back:(id)sender // back to root view
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)filter:(id)sender
{
    if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
    {
   
        CGRect basketTopFrame = filterView.frame;
        basketTopFrame.origin.x = 0;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{ filterView.frame = basketTopFrame; } completion:^(BOOL finished){ }];
    
    }
    else
    {
            [UIView animateWithDuration:0.7f
                             animations:^ {
                                 CGRect frame = filterView.frame;
                                 frame.origin.x = self.view.frame.size.width/2;
                                 filterView.frame = frame;
                                 filterView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                             }
                             completion:^(BOOL finished)
             {
                 [UIView beginAnimations:nil context:nil];
                 [UIView setAnimationDuration:5.3];
                 [UIView commitAnimations];
             }];
       
            }
}
-(void)closeFilter
{
    if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
    {
            CGRect napkinBottomFrame = filterView.frame;
            napkinBottomFrame.origin.x = -filterView.frame.size.width;
            [UIView animateWithDuration:0.3 delay:0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{ filterView.frame = napkinBottomFrame; } completion:^(BOOL finished){/*done*/}];
    }
    else
    {
                        [UIView animateWithDuration:0.7f
                             animations:^ {
                                 CGRect frame = filterView.frame;
                                 frame.origin.x = self.view.frame.size.width;
                                 filterView.frame = frame;
                                 filterView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                             }
                             completion:^(BOOL finished)
             {
                 [UIView beginAnimations:nil context:nil];
                 [UIView setAnimationDuration:5.3];
                 [UIView commitAnimations];
             }];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
@end
