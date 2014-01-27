//
//  ImageUtils.h
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtils : NSObject

/*
Important note : For improved performance with this utility, do not cache images in memory.
 Load UIImages by using [UIImage imageWithContentsOfFile:] instead of [UIImage imageNamed:]
*/

-(UIImage *)imageWithImage:(UIImage *)image
             scaledToWidth:(int)width;

-(UIImage *)imageWithImage:(UIImage *)image
            scaledToHeight:(int)height;

-(UIImage *)imageWithImage:(UIImage *)image
             scaledToScale:(int)scale;

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight;

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight
           isAspectFill:(BOOL)isAspectFill;

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight
           isAspectFill:(BOOL)isAspectFill
        ignoresRotation:(BOOL)ignoresRotataion;

@end
