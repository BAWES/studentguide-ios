//
//  DetaliPage.m
//  StudentsGuide
//
//  Created by Karthick on 17/05/16.
//  Copyright © 2016 sadeeshmac. All rights reserved.
//

#import "DetaliPage.h"
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "HCYoutubeParser.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>


@interface DetaliPage ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate,UITextViewDelegate,AVPlayerViewControllerDelegate>
{
    MKMapView * mapView;
    NSString *text;
    iCarousel *carousel;
    AVPlayer *avPlayer;
    AVPlayerItem *player;
    
    NSURL *_urlToLoad;
}
@end

@implementation DetaliPage

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor customTopNavigationbarColor];
    self.table.backgroundColor = [UIColor clearColor];
    
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

    
    self.table.delegate = self;
    self.table.dataSource = self;
    text = @"This optimization doesn't impact scrolling performance, but it does affect the way the row height cache is primed. New in iOS 7 is a UITableViewDelegate method tableView:estimatedHeightForRowAtIndexPath:, which is used by the table view to defer the calculation of row heights until just before the cell will become visible during scrolling. The estimated height value will be used to provide an approximation for the table view's scroll bars, which is then adjusted to the real value when the cell becomes visible. Small data sets won't see any noticeable improvement from implementing this method, however tables with hundreds or thousands of rows will certainly see an improvement in their initial load times.";

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
    return 6;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DetailCell";
     DetailCell *cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (!cell)
    {
        cell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row ==0)
    {
        cell.contentView.backgroundColor = [UIColor customNavigationColor];
        cell.backgroundColor = [UIColor customNavigationColor];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.tag =101;
        [backBtn setImage:[UIImage imageNamed:@"Leftarrow"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:backBtn];
        
        UIButton *callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        callBtn.tag =102;
        [callBtn setImage:[UIImage imageNamed:@"callcircle"] forState:UIControlStateNormal];
        [callBtn addTarget:self action:@selector(gotoCall) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:callBtn];
        
        AsyncImageView *imageView = [[AsyncImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.tag = 103;
        imageView.image = [UIImage imageNamed:@"img"];
        [cell.contentView addSubview:imageView];
        
        UIButton *loctaionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loctaionBtn.tag =1042;
        [loctaionBtn setImage:[UIImage imageNamed:@"locationcirclegreen"] forState:UIControlStateNormal];
        [loctaionBtn addTarget:self action:@selector(gotoLocation) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:loctaionBtn];
        
        UILabel *titleLbl = [[UILabel alloc]init];
        titleLbl.tag = 101;
        titleLbl.textColor = [UIColor whiteColor];
        titleLbl.text = @"Address";
        titleLbl.font = [UIFont customEnglishTitleFont];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLbl];
        
        loctaionBtn.translatesAutoresizingMaskIntoConstraints = NO;
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        callBtn.translatesAutoresizingMaskIntoConstraints = NO;
        titleLbl.translatesAutoresizingMaskIntoConstraints = NO;
        backBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(loctaionBtn,imageView,callBtn,titleLbl,backBtn);
        
        
        
        [cell addConstraint: [NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:imageView.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:-8]];

        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[backBtn(35)]-[callBtn(50)]-[imageView(80)]" options:0 metrics:nil views:views]];
        
//         [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(80)]" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[titleLbl]-|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(80)]-[loctaionBtn(50)]" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[backBtn(35)]" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[callBtn(50)]" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[loctaionBtn(50)]" options:0 metrics:nil views:views]];
        
         [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView(80)]-[titleLbl(20)]" options:0 metrics:nil views:views]];
        
           }
    else if(indexPath.row ==1)
    {
        [[cell viewWithTag:101]removeFromSuperview];
        [[cell viewWithTag:102]removeFromSuperview];
        [[cell viewWithTag:103]removeFromSuperview];
        
        UILabel *addressLbl = [[UILabel alloc]init];
        addressLbl.tag = 101;
        addressLbl.textColor = [UIColor blackColor];
        addressLbl.text =  LocalizedString(@"ADDRESS");
        addressLbl.font = [UIFont customEnglishFontBold10];
        [cell.contentView addSubview:addressLbl];
        
        mapView = [[MKMapView alloc] init];
        mapView.tag = 102;
        mapView.delegate = self;
        [cell.contentView addSubview:mapView];
        
        CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(11.0168, 76.9558);
        MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
        [mapView setRegion:adjustedRegion animated:YES];
        
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:startCoord];
        [annotation setTitle:@"Title"]; //You can set the subtitle too
        [mapView addAnnotation:annotation];
        
        UILabel *addresslistLbl = [[UILabel alloc]init];
        addresslistLbl.tag = 103;
        addresslistLbl.text = @"asdgasdbgasd\njkasgbdajksdvaks\njdbgvashjkdabsvh\ndasvhdasv";
        addresslistLbl.textColor = [UIColor blackColor];
        addresslistLbl.font = [UIFont customEnglishFontRegular10];
        addresslistLbl.numberOfLines = 0;
        addresslistLbl.lineBreakMode = NSLineBreakByWordWrapping;
        addresslistLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:addresslistLbl];
        [addresslistLbl sizeToFit];
        
        addresslistLbl.textAlignment = NSTextAlignmentLeft;
        addressLbl.textAlignment = NSTextAlignmentLeft;
        
        if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
        {
            addresslistLbl.textAlignment = NSTextAlignmentRight;
            addresslistLbl.font = [UIFont customArabicFontRegular10];
            
            addressLbl.textAlignment = NSTextAlignmentRight;
            addressLbl.font = [UIFont customArabicFontBold10];
        }
        
        addressLbl.translatesAutoresizingMaskIntoConstraints = NO;
        addresslistLbl.translatesAutoresizingMaskIntoConstraints = NO;
        mapView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(addressLbl,addresslistLbl,mapView);
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[addressLbl]-[mapView(50)]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[addresslistLbl]-[mapView(50)]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[addressLbl(20)]-[addresslistLbl]-|" options:0 metrics:nil views:views]];
        
        
    }
    else if(indexPath.row == 2)
    {
        [[cell viewWithTag:201]removeFromSuperview];
        [[cell viewWithTag:202]removeFromSuperview];
        [[cell viewWithTag:203]removeFromSuperview];
        [[cell viewWithTag:204]removeFromSuperview];
        
        UILabel *contactLbl = [[UILabel alloc]init];
        contactLbl.tag =201;
        contactLbl.textColor = [UIColor blackColor];
        contactLbl.text =  LocalizedString(@"CONTACT");
        contactLbl.font = [UIFont customEnglishFontBold10];
        [cell.contentView addSubview:contactLbl];
        
        UIButton *fbBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        fbBtn.tag =202;
        [fbBtn setImage:[UIImage imageNamed:@"img"] forState:UIControlStateNormal];
        [fbBtn addTarget:self action:@selector(callFB) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:fbBtn];
        
        UIButton *twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        twitterBtn.tag =203;
        [twitterBtn addTarget:self action:@selector(callTwitter) forControlEvents:UIControlEventTouchUpInside];
        [twitterBtn setImage:[UIImage imageNamed:@"img"] forState:UIControlStateNormal];
        [cell.contentView addSubview:twitterBtn];
        
        
        UILabel *noLbl = [[UILabel alloc]init];
        noLbl.tag = 204;
        noLbl.text = @"asdgasdbgasd\njkasgbdajksdvaks\njdbgvashjkdabsvh\ndasvhdasv\nefrhneqrheqirehqrierer\nqerqerqre\nqrqwrqwr\nqwrqwr\nqwrqw\nrqwr\nqrw\nqwer\nrq\nqwr";
        noLbl.textColor = [UIColor blackColor];
        noLbl.font = [UIFont customEnglishFontRegular10];
        noLbl.numberOfLines = 0;
        noLbl.lineBreakMode = NSLineBreakByWordWrapping;
        noLbl.textAlignment = NSTextAlignmentLeft;
        [cell.contentView addSubview:noLbl];
        [noLbl sizeToFit];
        
        noLbl.textAlignment = NSTextAlignmentLeft;
        contactLbl.textAlignment = NSTextAlignmentLeft;
        
        if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
        {
            contactLbl.textAlignment = NSTextAlignmentRight;
            noLbl.font = [UIFont customArabicFontRegular10];
            
            noLbl.textAlignment = NSTextAlignmentRight;
            contactLbl.font = [UIFont customArabicFontBold10];
        }

        
        contactLbl.translatesAutoresizingMaskIntoConstraints = NO;
        noLbl.translatesAutoresizingMaskIntoConstraints = NO;
        twitterBtn.translatesAutoresizingMaskIntoConstraints = NO;
        fbBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(contactLbl,noLbl,fbBtn,twitterBtn);
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[contactLbl]-[fbBtn(50)]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[noLbl]-[twitterBtn(50)]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[fbBtn(50)]-[twitterBtn(50)]|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[contactLbl(20)]-[noLbl]-|" options:0 metrics:nil views:views]];
        
        
    }
    else if(indexPath.row == 3)
    {
        
        [[cell viewWithTag:301]removeFromSuperview];
        [[cell viewWithTag:302]removeFromSuperview];
        
        
        UILabel *descripLbl = [[UILabel alloc]init];
        descripLbl.textColor = [UIColor blackColor];
        descripLbl.tag = 301;
        descripLbl.text =  LocalizedString(@"DESCRIPTION");
        descripLbl.font = [UIFont customEnglishFontBold10];
        [cell.contentView addSubview:descripLbl];
        
        UITextView *dercriptionTxt = [[UITextView alloc]init];
        descripLbl.tag = 302;
        dercriptionTxt.textColor = [UIColor lightGrayColor];
        dercriptionTxt.editable = NO;
        dercriptionTxt.userInteractionEnabled = NO;
        dercriptionTxt.scrollEnabled = NO;
        dercriptionTxt.delegate = self;
        dercriptionTxt.text =text;
        [cell.contentView addSubview:dercriptionTxt];
        
        dercriptionTxt.font = [UIFont customEnglishFontRegular10];
        dercriptionTxt.textAlignment = NSTextAlignmentLeft;
        descripLbl.textAlignment = NSTextAlignmentLeft;
        descripLbl.font = [UIFont customEnglishFontRegular10];
        if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
        {
            descripLbl.textAlignment = NSTextAlignmentRight;
            descripLbl.font = [UIFont customArabicFontRegular10];
            
            dercriptionTxt.textAlignment = NSTextAlignmentRight;
            dercriptionTxt.font = [UIFont customArabicFontRegular10];
        }
        
        descripLbl.translatesAutoresizingMaskIntoConstraints = NO;
        dercriptionTxt.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(dercriptionTxt,descripLbl);
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[descripLbl]-|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dercriptionTxt]-|" options:0 metrics:nil views:views]];
        
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[descripLbl(20)]-[dercriptionTxt]-|" options:0 metrics:nil views:views]];
    }
    else if (indexPath.row ==4)
    {
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width, 20)];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.tag = 501;
        titleLbl.text = LocalizedString(@"GALLERY");
        titleLbl.font = [UIFont customEnglishFontBold10];
        [cell.contentView addSubview:titleLbl];
        
        [carousel removeFromSuperview];
        carousel = [[iCarousel alloc]init];
        carousel.backgroundColor = [UIColor orangeColor];
        carousel.tag = 401;
        carousel.delegate = self;
        carousel.dataSource = self;
        carousel.frame = CGRectMake(0, 40, self.view.frame.size.width, 200);
        carousel.type = iCarouselTypeRotary;
        [cell.contentView addSubview:carousel];
    }
    else if (indexPath.row ==5)
    {
        UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, self.view.frame.size.width, 20)];
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.tag = 501;
        titleLbl.text = LocalizedString(@"VIDEO");
        titleLbl.font = [UIFont customEnglishFontBold10];
        [cell.contentView addSubview:titleLbl];

        
        cell.backgroundColor = [UIColor customNavigationColor];
        cell.contentView.backgroundColor = [UIColor customNavigationColor];
        
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [playButton addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
        
        playButton.layer.shadowColor = [UIColor blackColor].CGColor;
        playButton.layer.shadowOffset = CGSizeMake(0, 0);
        playButton.layer.shadowOpacity = 0.7;
        playButton.layer.shadowPath = [UIBezierPath bezierPathWithRect:playButton.bounds].CGPath;
        playButton.layer.shadowRadius = 2;
        playButton.backgroundColor = [UIColor redColor];
        [playButton setFrame:CGRectMake(0, 30,self.view.frame.size.width , 200)];
        [cell.contentView addSubview:playButton];
        
        [playButton setImage:nil forState:UIControlStateNormal];
        
        UIActivityIndicatorView *activityIndicator= [[UIActivityIndicatorView alloc] initWithFrame: CGRectMake(playButton.frame.size.width/2-15, playButton.frame.size.height/2, 30, 30)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [playButton addSubview: activityIndicator];
        [activityIndicator startAnimating];
        
        NSURL *url = [NSURL URLWithString:@"https://youtu.be/wqXE_es_I3M"];
        activityIndicator.hidden = NO;
        [HCYoutubeParser thumbnailForYoutubeURL:url thumbnailSize:YouTubeThumbnailDefaultHighQuality completeBlock:^(UIImage *image, NSError *error) {
            
            if (!error) {
                [playButton setBackgroundImage:image forState:UIControlStateNormal];
                
                [HCYoutubeParser h264videosWithYoutubeURL:url completeBlock:^(NSDictionary *videoDictionary, NSError *error) {
                    
                    playButton.hidden = NO;
                    activityIndicator.hidden = YES;
                    
                    NSDictionary *qualities = videoDictionary;
                    
                    NSString *URLString = nil;
                    if ([qualities objectForKey:@"small"] != nil) {
                        URLString = [qualities objectForKey:@"small"];
                    }
                    else if ([qualities objectForKey:@"live"] != nil) {
                        URLString = [qualities objectForKey:@"live"];
                    }
                    else {
                        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Couldn't find your video" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
                        return;
                    }
                    _urlToLoad = [NSURL URLWithString:URLString];
                    
                    [playButton setImage:[UIImage imageNamed:@"play_button"] forState:UIControlStateNormal];
                }];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                [alert show];
            }
        }];
        
        UIView *buttonBgView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-self.view.frame.size.width/4,playButton.frame.origin.y+playButton.frame.size.height, self.view.frame.size.width/2,35)];
        buttonBgView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:buttonBgView];

        UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        homeBtn.tag =202;
        [homeBtn setImage:[UIImage imageNamed:@"home-circle"] forState:UIControlStateNormal];
        [homeBtn addTarget:self action:@selector(callHome) forControlEvents:UIControlEventTouchUpInside];
        [buttonBgView addSubview:homeBtn];
        
        UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        contactBtn.tag =202;
        [contactBtn setImage:[UIImage imageNamed:@"messagecircle"] forState:UIControlStateNormal];
        [contactBtn addTarget:self action:@selector(callContact) forControlEvents:UIControlEventTouchUpInside];
        [buttonBgView addSubview:contactBtn];
        
        homeBtn.translatesAutoresizingMaskIntoConstraints = NO;
        contactBtn.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(homeBtn,contactBtn);
        
        [buttonBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[homeBtn(50)]-10-[contactBtn(50)]-30-|" options:0 metrics:nil views:views]];
        
        [buttonBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-20)-[homeBtn(50)]-|" options:0 metrics:nil views:views]];
        
        [buttonBgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-20)-[contactBtn(50)]-|" options:0 metrics:nil views:views]];
        
        
    }
    return cell;
}

- (void)playVideo:(id)sender
{
    if (_urlToLoad)
    {
        MPMoviePlayerViewController *mp = [[MPMoviePlayerViewController alloc] initWithContentURL:_urlToLoad];
        [self presentViewController:mp animated:YES completion:NULL];
//                AVPlayer *player = [[AVPlayer alloc] initWithURL:_urlToLoad];
//                AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
//                controller.player = player;
//                controller.delegate = self;// if you want to use delegates...
//                controller.showsPlaybackControls=YES;
//                controller.view.frame = self.view.bounds;
//                [self.view addSubview:controller.view];
//                [player play];
    }
}
- (CGFloat)textViewHeightForRowAtIndexPath: (NSIndexPath*)indexPath
{
    UITextView *calculationView = [[UITextView alloc]init];
    CGFloat textViewWidth = self.view.frame.size.width;
    calculationView.font = [UIFont customEnglishFontRegular10];
    if ([[GlobalClass getLanguage]isEqualToString:@"ar"])
    {
        calculationView.font = [UIFont customArabicFontRegular10];
    }
    calculationView.text = text;
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    return size.height+60;
}
#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}

// set uitableview cell height manually
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
    return 135;
    }
    else if (indexPath.row == 1)
    {
        return 100;
    }
    else if (indexPath.row == 2)
    {
        return 100;
    }
    else if (indexPath.row == 3)
    {
        return [self textViewHeightForRowAtIndexPath:indexPath];
    }
    else if (indexPath.row == 4)
    {
        return 280;
    }
    else if (indexPath.row == 5)
    {
        return 265;
    }
    return 100;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.table respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.table setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.table respondsToSelector:@selector(setLayoutMargins:)])
    {
        [self.table setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(void)callHome
{
    HomePage *homepage = [self.storyboard instantiateViewControllerWithIdentifier:@"HomePage"];
    [self presentViewController:homepage animated:YES completion:nil];
    
}
-(void)callContact
{
    ContactUsPage *contactPage = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactUsPage"];
    [self.navigationController pushViewController:contactPage animated:YES];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)gotoLocation
{
    float locLat;
    float locLng;
    NSString *locName;
    
//    locLat = [latitude floatValue];
//    locLng = [longitude floatValue];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/maps?saddr=%f,%f&daddr=%f,%f",locLat,locLng,@"address1",@"address1"]];
    if (![[UIApplication sharedApplication] canOpenURL:url])
    {
        NSLog(@"Google Maps app is not installed");
    }
    else
    {
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/maps?saddr=%f,%f&daddr=%f,%f",locLat,locLng,[[GlobalAccessClass sharedResources].latVal floatValue],[[GlobalAccessClass sharedResources].lngVal floatValue]]];
         NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/maps?saddr=%f,%f&daddr=%f,%f",locLat,locLng,@"address1",@"address1"]];
        [[UIApplication sharedApplication] openURL:url];
    }

}
-(void)gotoCall
{
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",@"9715168081"]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl])
    {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        [GlobalClass showToast:@"" message:LocalizedString(@"Call facility is not available!!!") view:self];
    }

}
-(void)callTwitter
{
    NSLog(@"sdf");
}
-(void)callFB
{
    NSLog(@"sdf");
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
//    return (NSInteger)[self.items count];
    return 8;
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 300.0f)];
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width-80, 200)];

        ((UIImageView *)view).image = [UIImage imageNamed:@"Bg"];
        //view.contentMode = UIViewContentModeCenter;
        view.contentMode = UIViewContentModeScaleToFill;
    }
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 600.0f, 600.0f)];
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 200)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"img"];
        //view.contentMode = UIViewContentModeCenter;
        view.contentMode = UIViewContentModeScaleToFill;
    }
    return view;
}

//- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
//{
//    //implement 'flip3D' style carousel
//    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
//    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
//}

- (CGFloat)carousel:(__unused iCarousel *)carousel1 valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
//            return self.wrap;
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

//- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
//{
//    NSNumber *item = (self.items)[(NSUInteger)index];
//    NSLog(@"Tapped view number: %@", item);
//}
//
//- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
//{
//    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
//}


@end
