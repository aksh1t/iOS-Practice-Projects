//
//  HomeViewController.m
//  CocoaPodsExample
//
//  Created by Akshat on 07/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "HomeViewController.h"
#import "TraktAPIClient.h"
#import <ConciseKit.h>
#import <SSCategories.h>
#import <AFNetworking.h>
#import <NIAttributedLabel.h>

@interface HomeViewController (){
    NSArray *jsonResponse;
    BOOL pageControlUsed;
    int previousPage;
    NSMutableSet *loadedPages;
}
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    [scrollView setBackgroundColor:[UIColor lightGrayColor]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 1 - Create trakt API client
    TraktAPIClient *client = [TraktAPIClient sharedClient];
    // 2 - Create date instance with today's date
    NSDate* today = [NSDate date];
    // 3 - Create date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSString* todayString = [formatter stringFromDate:today];
    // 4 - Create API query request
    NSString *path = [NSString stringWithFormat:@"user/calendar/shows.json/%@/%@/%@/%d", kTraktAPIKey, @"marcelofabri", todayString, 3];
    NSURLRequest *request = [client requestWithMethod:@"GET" path:path parameters:nil];
    
    loadedPages = [NSMutableSet set];
    previousPage = -1;
    
    // 5 - Create JSON request operation
    AFJSONRequestOperation* operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // 6.1 - Load JSON into internal variable
        jsonResponse = JSON;
        // 6.2 - Get the number of shows
        int shows = 0;
        for (NSDictionary* day in jsonResponse) {
            shows += [[day $for: @"episodes"] count];
            // $for: above is the same as objectForKey: - we're using ConciseKit here.
        }
        // 6.3 - Set up page control
        showPageControl.numberOfPages = shows;
        showPageControl.currentPage = 0;
        // 6.4 - Set up scroll view
        scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * shows, scrollView.frame.size.height);
        // 6.5 - Load first show
        [self loadShow:0];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // 7 - Request failed block
    }];
    // 8 - Start request
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadShow:(int)index {
    // 1 - Does the pages array contain the specified page?
    if (![loadedPages containsObject:$int(index)]) {
        // $int(x) is the same as [NSNumber numberWithInt:x]
        // 2 - Find the show for the given index
        int shows = 0;
        NSDictionary *show = nil;
        for (NSDictionary *day in jsonResponse) {
            int count = [[day $for: @"episodes"] count];
            // 3 - Did we find the right show?
            if (index < shows + count) {
                show = [[day $for:@"episodes"] $at: index-shows];
                break;
            }
            // 4 - Increment the shows counter
            shows += count;
        }
        // 5 - Load the show information
        NSDictionary *episodeDict = [show $for:@"episode"];
        NSDictionary *showDict = [show $for:@"show"];
        // 6 - Display the show information
        NIAttributedLabel* label = [[NIAttributedLabel alloc] initWithFrame:CGRectMake(index * scrollView.bounds.size.width, 40, scrollView.bounds.size.width, 40)];
        label.text = [showDict $for: @"title"];
        label.backgroundColor = [UIColor clearColor];
        label.linkColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        [label addLink: [NSURL URLWithString:[showDict $for: @"url"]] range:NSMakeRange(0, label.text.length)];
        label.delegate = self;
        [scrollView addSubview:label];
        
        static NSDateFormatter *formatter = nil;
        if (!formatter) {
            formatter = $new(NSDateFormatter);
            formatter.dateStyle = NSDateFormatterLongStyle;
            formatter.timeStyle = NSDateFormatterShortStyle;
            formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"PST"];
        }
        NSTimeInterval showAired = [[episodeDict $for: @"first_aired_localized"] doubleValue];
        NSString *showDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970: showAired]];
        // 6.2 - Create label to display episode info
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(index * scrollView.bounds.size.width, 360, scrollView.bounds.size.width, 80)];
        lbl.numberOfLines = 2;
        NSString* episode  = [NSString stringWithFormat:@"%02dx%02d - \"%@\"",
                              [[episodeDict valueForKey:@"season"] intValue],
                              [[episodeDict valueForKey:@"number"] intValue],
                              [episodeDict objectForKey:@"title"]];
        lbl.text = [NSString stringWithFormat:@"%@\n%@", episode, showDate];
        NSLog(@"%@",[NSString stringWithFormat:@"%@\n%@", episode, showDate]);
        lbl.numberOfLines = 0;
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        
        
        
        [scrollView addSubview:lbl];
        
        // 6.3 - Get image
        NSString *posterUrl = [[showDict $for: @"images"] $for: @"poster"];
        if ([[UIScreen mainScreen] isRetinaDisplay]) {
            posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-300.jpg"];
        } else {
            posterUrl = [posterUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@"-138.jpg"];
        }
        // 6.4 - Display image using image view
        UIImageView *posterImage = $new(UIImageView);
        // $new(class) is the same as [[class alloc] init] - courtesy of ConciseKit
        posterImage.frame = CGRectMake(index * scrollView.bounds.size.width + 90, 80, 150, 225);
        [scrollView addSubview:posterImage];
        // 6.5 - Asynchronously load the image
        [posterImage setImageWithURL:[NSURL URLWithString:posterUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        // 7 - Add the new page to the loadedPages array
        [loadedPages addObject:$int(index)];
    }
}

-(IBAction)pageChanged:(id)sender {
    // Set flag
    pageControlUsed = YES;
    // Get previous page number
    int page = showPageControl.currentPage;
    previousPage = page;
    // Call loadShow for the new page
    [self loadShow:page];
    // Scroll scroll view to new page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [UIView animateWithDuration:.5 animations:^{
        [scrollView scrollRectToVisible:frame animated:NO];
    } completion:^(BOOL finished) {
        pageControlUsed = NO;
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)sender {
    // Was the scrolling initiated via page control?
    if (pageControlUsed) {
        return;
    }
    // Figure out page to scroll to
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // Do not do anything if we're trying to go beyond the available page range
    if (page == previousPage || page < 0 || page >= showPageControl.numberOfPages)
    return;
    previousPage = page;
    // Set the page control page display
    showPageControl.currentPage = page;
    // Load the page
    [self loadShow:page];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    [[UIApplication sharedApplication] openURL:result.URL];
}

@end