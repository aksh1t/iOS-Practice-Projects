//
//  TGCaptureTableItem.h
//  TGCapture
//
//  Created by Akshat on 25/03/14.
//  Copyright (c) 2014 Akshat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGCaptureTableItem : NSObject

@property (nonatomic) BOOL isSelected;
@property (nonatomic) int index;
@property (nonatomic, retain) NSString *title;

@end