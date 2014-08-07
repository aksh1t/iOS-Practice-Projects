#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(60, 0, 60, 79);
    CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
    maskLayer.path = path;
    CGPathRelease(path);
    label2.layer.mask = maskLayer;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    label2.layer.mask.frame = CGRectMake([touch locationInView:self.view].x - 70, 0, 60, 79);
}

@end