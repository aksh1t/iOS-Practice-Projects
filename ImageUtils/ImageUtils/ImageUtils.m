//
//  ImageUtils.m
//  ImageUtils
//
//  Created by Akshat on 16/01/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

-(UIImage *)imageWithImage:(UIImage *)image
             scaledToWidth:(int)newWidth{
    if(newWidth <= 0) return nil;
    
    //Calculating newHeight
    float newHeight = newWidth * image.size.height / image.size.width;
    
    //Scaling image
    @autoreleasepool {
        CGSize newSize = CGSizeMake(newWidth, newHeight);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //Returning scaled image
        return newImage;
    }
}

-(UIImage *)imageWithImage:(UIImage *)image
            scaledToHeight:(int)newHeight{
    if(newHeight <= 0) return nil;
    
    //Calculating newWidth
    float newWidth = newHeight * image.size.width / image.size.height;
    
    //Scaling image
    @autoreleasepool {
        CGSize newSize = CGSizeMake(newWidth, newHeight);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //Returning scaled image
        UIGraphicsEndImageContext();
        return newImage;
    }
}

-(UIImage *)imageWithImage:(UIImage *)image
             scaledToScale:(int)scale{
    if(scale <= 0) return nil;
    
    //Calculating new dimensions of image
    float newWidth = image.size.width * scale / 100;
    float newHeight = image.size.height * scale / 100;
    
    //Scaling image
    @autoreleasepool {
        CGSize newSize = CGSizeMake(newWidth, newHeight);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        //Returning scaled image
        UIGraphicsEndImageContext();
        return newImage;
    }
}

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight{
    //Use detailed method with AspectFill YES and ignoresRotation YES
    return [self resizeImage:image toAspectWidth:aspectWidth andAspectHeight:aspectHeight isAspectFill:YES ignoresRotation:YES];
}

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight
           isAspectFill:(BOOL)isAspectFill{
    //Use detailed method with ignoresRotation YES
    return [self resizeImage:image toAspectWidth:aspectWidth andAspectHeight:aspectHeight isAspectFill:isAspectFill ignoresRotation:YES];
}

-(UIImage *)resizeImage:(UIImage *)image
          toAspectWidth:(int)aspectWidth
        andAspectHeight:(int)aspectHeight
           isAspectFill:(BOOL)isAspectFill
        ignoresRotation:(BOOL)ignoresRotataion{
    @autoreleasepool {
        if(aspectWidth <=0 || aspectHeight<=0) return nil;
        
        float imageWidth = image.size.width;
        float imageHeight = image.size.height;
        float finalWidth,finalHeight;
        float offsetX,offsetY;
        
        //Simplifying aspect ratio
        int g = gcd(aspectWidth,aspectHeight);
        aspectWidth = aspectWidth/g;
        aspectHeight = aspectHeight/g;
        
        if(ignoresRotataion){
            //Aligning longest edge to the longest aspect ratio (not changing if image or ratio is square)
            if((imageWidth>imageHeight&&aspectWidth<aspectHeight)||(imageWidth<imageHeight&&aspectWidth>aspectHeight)){
                aspectWidth=aspectWidth+aspectHeight;
                aspectHeight=aspectWidth-aspectHeight;
                aspectWidth=aspectWidth-aspectHeight;
            }
            
            //If image is square, aligning longest aspect ratio to width
            if(imageWidth==imageHeight&&aspectWidth<aspectHeight){
                aspectWidth=aspectWidth+aspectHeight;
                aspectHeight=aspectWidth-aspectHeight;
                aspectWidth=aspectWidth-aspectHeight;
            }
        }
        
        if(isAspectFill){
            //Calculating final imagesize in pixels if aspectFill is true
            float factor = MIN((imageWidth/aspectWidth),(imageHeight/aspectHeight));
            finalWidth = (int)(aspectWidth*factor);
            finalHeight = (int)(aspectHeight*factor);
            
            //Offset for drawing the final image (so as to crop center portion)
            offsetX = (fabsf(imageWidth-finalWidth)/2);
            offsetY = (fabsf(imageHeight-finalHeight)/2);
            
            //Setting up the cropped UIImage from the source UIImage for aspectFill
            //CGRect for the crop
            CGRect rect = CGRectMake(offsetX*image.scale,offsetY*image.scale,finalWidth*image.scale,finalHeight*image.scale);
            CGImageRef ref = CGImageCreateWithImageInRect(image.CGImage, rect);
            UIImage *finalImage = [UIImage imageWithCGImage:ref scale:image.scale orientation:image.imageOrientation];
            //Returning final image
            return finalImage;
            
        }else{
            //Calculating final imagesize in pixels if aspectFill is false (aspectFit is true)
            float factor = MAX((imageWidth/aspectWidth),(imageHeight/aspectHeight));
            finalWidth = (int)(aspectWidth*factor);
            finalHeight = (int)(aspectHeight*factor);
            
            //Offset for drawing the final image (so as to crop center portion)
            offsetX = (fabsf(imageWidth-finalWidth)/2);
            offsetY = (fabsf(imageHeight-finalHeight)/2);
            
            //Setting up the cropped UIImage from the source UIImage for aspectFit
            //CGRect for the final Image
            CGRect rect = CGRectMake(0, 0, finalWidth, finalHeight);
            //Drawing original image inside context
            UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0);
            [image drawInRect:CGRectMake(offsetX, offsetY, image.size.width, image.size.height)];
            UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //Returning Image
            return finalImage;
        }
        return nil;
    }
}

//Helper method to find GCD of two numbers
int gcd(int m, int n) {
    int t, r;
    if (m < n) {
        t = m;
        m = n;
        n = t;
    }
    r = m % n;
    if (r == 0) {
        return n;
    } else {
        return gcd(n, r);
    }
}

@end
