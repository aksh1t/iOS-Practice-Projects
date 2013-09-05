//
//  ViewController.m
//  Components
//
//  Created by Vishal on 7/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController1.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

@synthesize myLabel, scrollView1,scrollView2,sliderlabel,slider,ai,myswitch;

- (IBAction)sliderValueChanged:(UISlider *)sender{
    
    sliderlabel.text = [NSString stringWithFormat:@"%f",slider.value];

}

- (IBAction)switchValueChanged:(UISlider *)sender{
    
    if(myswitch.isOn){
        sliderlabel.text = @"Switch is on.";}
    else {
        sliderlabel.text = @"Switch is off.";
    }
    
}

- (IBAction)segmentclick:(id)sender{
   
    UISegmentedControl * sc = (UISegmentedControl *)sender;
    
    if(sc.selectedSegmentIndex==1){
        [scrollView1 removeFromSuperview];
    
        [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [slider setValue:0.5];
        
        NSLog(@"%f",slider.value);
        
        [myswitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [scrollView2 addSubview:slider];    
        [scrollView2 addSubview:sliderlabel];
        [scrollView2 addSubview:ai];
        [scrollView2 addSubview:myswitch];
        
        self.scrollView2.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.scrollView2.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+500);
        self.scrollView2.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-215);
    
        [self.view addSubview:scrollView2];
    }
    else{
        [scrollView2 removeFromSuperview];
        [self.view addSubview:scrollView1];
    }
}

- (IBAction)doneButtonClicked:(id)sender{
    
    [sender resignFirstResponder];
    
}

- (IBAction)textFieldEdited:(UITextField *)sender{
    
    [myLabel setText:sender.text];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//Slider init
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(20,20,250,20)];
    sliderlabel = [[UILabel alloc]initWithFrame:CGRectMake(20,50,200,25)];
    [sliderlabel setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
    sliderlabel.text = @"temp label";
    scrollView2 = [[UIScrollView alloc]init];

//UIActivityView init
    
    ai = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(30, 100, 30, 30)];
    [ai setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [ai startAnimating];
    
//UISwitch
    
    myswitch = [[UISwitch alloc]initWithFrame:CGRectMake(80, 100, 0, 0)];
    
//UILabel properties and stuff
    
    NSLog(@"Available Font Families: %@", [UIFont familyNames]);
    
    myLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 115, 300, 35)];
    myLabel.text = @"Custom Font";
    [myLabel setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
    [myLabel setFont:[UIFont fontWithName:@"appleberry" size:25.0]];
    myLabel.textAlignment = UITextAlignmentCenter;
	myLabel.textColor = [UIColor darkGrayColor];
    myLabel.lineBreakMode = UILineBreakModeWordWrap;
	myLabel.numberOfLines = 3;
    myLabel.adjustsFontSizeToFitWidth = YES;
    

//UITextField properties and stuff
    
    UITextField * myTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 230, 200, 25)];
    [myTextField addTarget:self action:@selector(textFieldEdited:) forControlEvents:UIControlEventEditingChanged];
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.returnKeyType = UIReturnKeyDone;
    [myTextField addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventEditingDidEndOnExit];
    myTextField.text = @"TextField added programmatically";
    
    [myTextField setFont:[UIFont fontWithName:@"Saumil_guj2" size:16]];
    
    UIImageView * myView = [[UIImageView  alloc]initWithImage:[UIImage  imageNamed : @"apple.gif" ]];
    [myTextField setLeftView :myView];
    [myTextField setLeftViewMode: UITextFieldViewModeAlways];
    [myTextField setBackgroundColor:[UIColor lightTextColor]];
    [myTextField setTextColor:[UIColor darkGrayColor]];
    
    
//UIButton properties and stuff
    
    UIButton * myButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myButton setTitle:@"Button" forState:UIControlStateNormal];
    [myButton setTitle:@"Buttonsel" forState:UIControlStateHighlighted];
    
    myButton.frame = CGRectMake(20,10, 160.0, 40.0);
    [myButton setTintColor:[UIColor redColor]];
    
    
    
    CAGradientLayer* gradientLayer = [[CAGradientLayer alloc] init];
    [gradientLayer setBounds:[myButton bounds]];
    [gradientLayer setPosition:
     CGPointMake([myButton bounds].size.width/2,
                 [myButton bounds].size.height/2)];
    [gradientLayer setColors:
     [NSArray arrayWithObjects:
      (id)[[UIColor purpleColor] CGColor],
      (id)[[UIColor blueColor] CGColor],
      (id)[[UIColor cyanColor] CGColor],
      (id)[[UIColor greenColor] CGColor],
      (id)[[UIColor yellowColor] CGColor],
      (id)[[UIColor orangeColor] CGColor],
      (id)[[UIColor redColor] CGColor], nil]];
    
    [[myButton layer] insertSublayer:gradientLayer atIndex:0]; 
    [[myButton layer] setCornerRadius:10];
    [[myButton layer] setMasksToBounds:YES];
    [[myButton layer] setBorderWidth:1];
    
    [myButton addTarget:self action:@selector(rainbowButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    
//Setting components in scrollview and properties of scrollview
    
    self.scrollView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView1.contentSize = CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+500);
    self.scrollView1.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-215);
    
    [self.scrollView1 addSubview:myLabel];
    [self.scrollView1 addSubview:myButton];
    [self.scrollView1 addSubview:myTextField];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)rainbowButtonClicked{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ButtonClicked" message:@"Rainbow Coloured weird button has been clicked!" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];

    [alert show];
}

@end
