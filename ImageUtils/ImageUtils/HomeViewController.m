//
//  HomeViewController.m
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "HomeViewController.h"
#import "ImageUtils.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *aspectX = [[NSArray alloc]initWithObjects:[NSNumber numberWithFloat:4],[NSNumber numberWithFloat:6],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:5],[NSNumber numberWithFloat:7],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:4],[NSNumber numberWithFloat:3], nil];
    NSArray *aspectY = [[NSArray alloc]initWithObjects:[NSNumber numberWithFloat:6],[NSNumber numberWithFloat:4],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:7],[NSNumber numberWithFloat:5],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:4],[NSNumber numberWithFloat:3],[NSNumber numberWithFloat:3], nil];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scrollView.pagingEnabled = YES;
    ImageUtils *util = [[ImageUtils alloc]init];
    
    for(int i=0;i<9;i++){
        UIImage *image = [util imageWithImage:[UIImage imageNamed:@"twomb.jpg"] scaledToHeight:140];

        UIImage *newImage = [util resizeImage:image toAspectWidth:[[aspectX objectAtIndex:i] floatValue] andAspectHeight:[[aspectY objectAtIndex:i] floatValue] isAspectFill:YES ignoresRotation:NO];
        UIImage *newImageNo = [util resizeImage:image toAspectWidth:[[aspectX objectAtIndex:i] floatValue] andAspectHeight:[[aspectY objectAtIndex:i] floatValue] isAspectFill:NO ignoresRotation:NO];
        
        CGFloat xOrigin = i * self.view.frame.size.width;
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:
                                   CGRectMake(xOrigin, 30,
                                              image.size.width,
                                              image.size.height)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:
                                   CGRectMake(xOrigin, 170,
                                              newImage.size.width,
                                              newImage.size.height)];
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:
                                   CGRectMake(xOrigin, 300,
                                              newImageNo.size.width,
                                              newImageNo.size.height)];
        imageView1.image = image;
        imageView2.image = newImage;
        imageView3.image = newImageNo;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(xOrigin, 400, 300, 30)];
        label.text = [NSString stringWithFormat:@"Size = %.1fx%.1f aspect ratio = %.1fx%.1f",newImage.size.width,newImage.size.height,[[aspectX objectAtIndex:i] floatValue],[[aspectY objectAtIndex:i] floatValue]];
        label.font = [UIFont systemFontOfSize:12];
        
        [scrollView addSubview:imageView1];
        [scrollView addSubview:imageView2];
        [scrollView addSubview:imageView3];
        [scrollView addSubview:label];
    }
    //set the scroll view content size
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 9,
                                        self.view.frame.size.height);
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
