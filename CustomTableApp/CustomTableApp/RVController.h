#import <UIKit/UIKit.h>

#import "MyData.h"
#import "RVControllerDelegate.h"

@interface RVController : UITableViewController <RVControllerDelegate,UITextFieldDelegate>{
    
    UITextField *textTemp;
    
    UILabel *labelTemp;
    
    UIBarButtonItem *addButton;
    
    MyData *dataObject;
}

- (IBAction)addButtonPressed:(id)sender;

- (IBAction)textFieldEditing:(UITextField *)textField;

@property (nonatomic, retain) IBOutlet UITextField *textTemp;

@property (nonatomic, retain) IBOutlet UILabel *labelTemp;

@property (nonatomic, retain) IBOutlet UIBarButtonItem *addButton;

@end