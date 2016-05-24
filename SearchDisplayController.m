//
//  SearchDisplayController.m
//  StudentsGuide
//
//  Created by Karthick on 14/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "SearchDisplayController.h"

@interface SearchDisplayController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation SearchDisplayController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
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
            self.searchText.textAlignment = NSTextAlignmentRight;
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
            // [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            self.searchText.textAlignment = NSTextAlignmentRight;
            [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
            // [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
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
            self.searchText.textAlignment = NSTextAlignmentRight;
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"ar"])
        {
            for (UIView *tempView in [self.view allSubViews])
            {
                [self changeViewRTL:tempView];
            }
            self.searchText.textAlignment = NSTextAlignmentRight;
        }
        else if ([language isEqualToString:@"en"]&&[[GlobalClass getLanguage] isEqualToString:@"en"])
        {
            
        }
    }
    

    self.view.backgroundColor = [UIColor customNavigationColor];
    self.searchBackView.layer.cornerRadius = self.searchBackView.frame.size.height/2;
    self.searchBackView.clipsToBounds = YES;
    self.searchText.placeholder = LocalizedString(@"Type to search");
    [self.searchText setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];

    
    userMutableArray = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    _searchTableView.delegate = self;
    _searchTableView.dataSource = self;
    _searchText.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    isActive = YES;
    NSString *searchString;
    if (string.length > 0) {
        searchString = [NSString stringWithFormat:@"%@%@",textField.text, string];
    } else {
        searchString = [textField.text substringToIndex:[textField.text length] - 1];
    }
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchString];
    searchResultsArray = [[userMutableArray filteredArrayUsingPredicate:filter] mutableCopy];
    
    if (!searchString || searchString.length == 0)
    {
        searchResultsArray = [userMutableArray mutableCopy];
        NSLog(@"searchResultsArray=%@",searchResultsArray);
    }
    else
    {
        if (searchResultsArray.count == 0)
        {
            NSLog(@"No data From Search");
        }
    }    
    [_searchTableView reloadData];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isActive)
    {
        return [searchResultsArray count];
    }
    else
    {
        return [userMutableArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
//        AsyncImageView *imageView = [[AsyncImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 50)];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
//        imageView.tag = 100;
//        
//        [cell addSubview:imageView];
//        
//        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, 5,self.view.frame.size.width-imageView.frame.origin.x-imageView.frame.size.width-10 ,22)];
//        titleLbl.tag = 101;
//        [GlobalClass setSearchTableTitleLbl:titleLbl];
//        [cell addSubview:titleLbl];
//        
//        UIImageView *loactionImage = [[UIImageView alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+10, titleLbl.frame.origin.y+titleLbl.frame.size.height+5, 20, 22)];
//        loactionImage.contentMode = UIViewContentModeScaleAspectFit;
//        loactionImage.tag = 103;
//        [cell addSubview:loactionImage];
//        
//        UILabel *subTitleLbl = [[UILabel alloc]initWithFrame:CGRectMake(loactionImage.frame.origin.x+loactionImage.frame.size.width+10, titleLbl.frame.origin.y+titleLbl.frame.size.height+5,self.view.frame.size.width-loactionImage.frame.origin.x-loactionImage.frame.size.width-10 ,22)];
//        subTitleLbl.tag = 102;
//        [GlobalClass setSearchTableSubTitleLbl:subTitleLbl];
//        [cell addSubview:subTitleLbl];
        

        AsyncImageView *imageView = [[AsyncImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 100;
        
        [cell.contentView addSubview:imageView];
        
        UILabel *titleLbl = [[UILabel alloc]init];
        titleLbl.tag = 101;
        [GlobalClass setSearchTableTitleLbl:titleLbl];
        [cell.contentView addSubview:titleLbl];
        
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
    // define the container in relation
    
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imageView(50)]|" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-[titleLbl]-10-|" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-70-[loactionImage(20)]-|" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[loactionImage]-[subTitleLbl]-10-|" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(50)]-8-[titleLbl(20)]-5-[loactionImage(20)]" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(50)]-8-[titleLbl(20)]-5-[subTitleLbl(20)]" options:0 metrics:nil views:views]];
    
    
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(50)]" options:0 metrics:nil views:views]];
   //    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[loactionImage(20)]" options:0 metrics:nil views:views]];
//    
//    [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeftMargin relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeLeftMargin multiplier:1.0 constant:0]];
//     [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    if ([[GlobalClass getLanguage] isEqualToString:@"ar"])
    {
         //[cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRightMargin relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeRightMargin multiplier:1.0 constant:0]];
        
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

        
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView(50)]-[titleLbl]-10-|" options:0 metrics:nil views:views]];
    
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView(50)]-[loactionImage(20)]-[subTitleLbl]-10-|" options:0 metrics:nil views:views]];
    
    
    
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageView(50)]" options:0 metrics:nil views:views]];
    
    [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-5-[subTitleLbl(20)]" options:0 metrics:nil views:views]];
    
    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLbl(20)]-5-[loactionImage(20)]" options:0 metrics:nil views:views]];
    }
    
    
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(50)]-8-[titleLbl(20)]-5-[loactionImage(20)]" options:0 metrics:nil views:views]];
//    [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[imageView(50)]-8-[titleLbl(20)]-5-[subTitleLbl(20)]" options:0 metrics:nil views:views]];
    
//    [cell  layoutIfNeeded];

    
    loactionImage.image = [UIImage imageNamed:@"location"];
    
    if(isActive)
    {
        titleLbl.text = [searchResultsArray objectAtIndex:indexPath.row];
        imageView.image = [UIImage imageNamed:@"img"];
        subTitleLbl.text = @"subtitle";
    }
    else
    {
        titleLbl.text = [userMutableArray objectAtIndex:indexPath.row];
        imageView.image = [UIImage imageNamed:@"img"];
        subTitleLbl.text = @"subtitle";
    }
    return cell;
}
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetaliPage *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetaliPage"];
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"selected %ld row", (long)indexPath.row);
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
    if ([self.searchTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.searchTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.searchTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.searchTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


@end
