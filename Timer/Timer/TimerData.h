#import <Foundation/Foundation.h>

@protocol TimerProtocol <NSObject>

-(void)remainingTimeForIndex:(int)index is:(long)remainingTime;

@end

@interface TimerData : NSObject{
    int index;
}

@property long totalTime;
@property long remainingTime;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) id <TimerProtocol> delegate;

-(id)initWithTime:(long)time andIndex:(int)i;
-(void)toggleTimer;

@end