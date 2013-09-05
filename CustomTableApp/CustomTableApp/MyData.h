//
//  MyData.h
//  CustomTableApp
//
//  Created by Vishal on 11/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyData : NSObject{
    
    NSInteger currentlyEditingRow;
    
    NSInteger selectedRow;
    
    NSUserDefaults *userDefault;
    
    NSMutableArray *data;
    
    NSMutableDictionary *tempDict;

}

@property (readwrite) NSInteger currentlyEditingRow;

@property (readwrite) NSInteger selectedRow;

@property (nonatomic, retain) NSUserDefaults *userDefault;

@property (nonatomic, retain) NSMutableArray *data;

@property (nonatomic, retain) NSMutableDictionary *tempDict;

@end
