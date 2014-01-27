//
//  MultipleImageTestViewController.m
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "MultipleImageTestViewController.h"
#import "ImageUtils.h"
#include <mach/mach_time.h>

@interface MultipleImageTestViewController ()

@end

@implementation MultipleImageTestViewController

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
    textView.text = @"";
    // Do any additional setup after loading the view from its nib.
}

-(void)imageDump:(UIImage *)image
{
    CGImageRef cgimage = image.CGImage;
    
    size_t width  = CGImageGetWidth(cgimage);
    size_t height = CGImageGetHeight(cgimage);
    
    size_t bpr = CGImageGetBytesPerRow(cgimage);
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);

    CGColorRenderingIntent rintent = CGImageGetRenderingIntent(cgimage);
    
    CGBitmapInfo info = CGImageGetBitmapInfo(cgimage);
    
    NSLog(
          @"\n"
          "CGImageGetHeight: %d\n"
          "CGImageGetWidth:  %d\n"
          "CGImageGetColorSpace: %@\n"
          "CGImageGetBitsPerPixel:     %d\n"
          "CGImageGetBitsPerComponent: %d\n"
          "CGImageGetBytesPerRow:      %d\n"
          "CGImageGetBitmapInfo: 0x%.8X\n"
          "  kCGBitmapAlphaInfoMask     = %s\n"
          "  kCGBitmapFloatComponents   = %s\n"
          "  kCGBitmapByteOrderMask     = 0x%.8X\n"
          "  kCGBitmapByteOrderDefault  = %s\n"
          "  kCGBitmapByteOrder16Little = %s\n"
          "  kCGBitmapByteOrder32Little = %s\n"
          "  kCGBitmapByteOrder16Big    = %s\n"
          "  kCGBitmapByteOrder32Big    = %s\n"
          "ColorRenderingIntent = %u",
          (int)width,
          (int)height,
          CGImageGetColorSpace(cgimage),
          (int)bpp,
          (int)bpc,
          (int)bpr,
          (unsigned)info,
          (info & kCGBitmapAlphaInfoMask)     ? "YES" : "NO",
          (info & kCGBitmapFloatComponents)   ? "YES" : "NO",
          (info & kCGBitmapByteOrderMask),
          ((info & kCGBitmapByteOrderMask) == kCGBitmapByteOrderDefault)  ? "YES" : "NO",
          ((info & kCGBitmapByteOrderMask) == kCGBitmapByteOrder16Little) ? "YES" : "NO",
          ((info & kCGBitmapByteOrderMask) == kCGBitmapByteOrder32Little) ? "YES" : "NO",
          ((info & kCGBitmapByteOrderMask) == kCGBitmapByteOrder16Big)    ? "YES" : "NO",
          ((info & kCGBitmapByteOrderMask) == kCGBitmapByteOrder32Big)    ? "YES" : "NO",
          rintent
          );
}

- (IBAction)startButtonClicked:(id)sender{
    textView.text = @"";
    ImageUtils *utils = [[ImageUtils alloc]init];
        textView.text=[NSString stringWithFormat:@"%@\n%@", textView.text, @"----AspectFill True----"];
    for(int i=0;i<10;i++){
        uint64_t startTime = mach_absolute_time( );
        UIImage *twomb = [UIImage imageWithContentsOfFile:@"twomb.jpg"];
    
        [utils resizeImage:twomb toAspectWidth:3 andAspectHeight:4 isAspectFill:TRUE ignoresRotation:NO];
        
        uint64_t endTime = mach_absolute_time( );
        uint64_t elapsedTime = endTime - startTime;
        static double ticksToNanoseconds = 0.0;
        if (0.0 == ticksToNanoseconds) {
            mach_timebase_info_data_t timebase;
            mach_timebase_info(&timebase);
            ticksToNanoseconds = (double)timebase.numer / timebase.denom;
        }
        double elapsedTimeInSeconds = elapsedTime * ticksToNanoseconds/1000000;
        NSString *str = [NSString stringWithFormat:@"Image:%d processing time: %f ms",i,elapsedTimeInSeconds];
        textView.text=[NSString stringWithFormat:@"%@\n%@", textView.text, str];
    }
    textView.text=[NSString stringWithFormat:@"%@\n%@", textView.text, @"----AspectFill False----"];
    for(int i=0;i<1000;i++){
        @autoreleasepool {
        uint64_t startTime = mach_absolute_time( );
        
        UIImage *twomb = [UIImage imageWithContentsOfFile:@"twomb.jpg"];
        //[UIImage imageNamed:@"twomb.jpg"];
        
        [utils resizeImage:twomb toAspectWidth:3 andAspectHeight:4 isAspectFill:FALSE ignoresRotation:NO];
        
        uint64_t endTime = mach_absolute_time( );
        uint64_t elapsedTime = endTime - startTime;
        static double ticksToNanoseconds = 0.0;
        if (0.0 == ticksToNanoseconds) {
            mach_timebase_info_data_t timebase;
            mach_timebase_info(&timebase);
            ticksToNanoseconds = (double)timebase.numer / timebase.denom;
        }
        double elapsedTimeInSeconds = elapsedTime * ticksToNanoseconds/1000000;
        NSString *str = [NSString stringWithFormat:@"Image:%d processing time: %f ms",i,elapsedTimeInSeconds];
        textView.text=[NSString stringWithFormat:@"%@\n%@", textView.text, str];
            [textView setNeedsDisplay];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
