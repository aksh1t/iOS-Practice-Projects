//
//  DVController.m
//  CustomTableApp
//
//  Created by Vishal on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DVController.h"

@implementation DVController

@synthesize titleString,trashButton,confirmButton,confirmView,cellLabel,cellTextField,currentRow,picker,dataObject,delegate;

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
    self.title = titleString;
    self.tableView.tableFooterView = confirmView;
    
    NSArray *s1 = [[NSArray alloc]initWithObjects:@"First",@"Middle",@"Last",nil];
    NSArray *s2 = [[NSArray alloc]initWithObjects:@"Contact No.",nil];
    NSArray *s3 = [[NSArray alloc]initWithObjects:@"Birthdate",nil];
    
    cellDataArray = [[NSArray alloc]initWithObjects:s1,s2,s3,nil];
    dateString = [[NSString alloc]init];
    tempDict = [[NSMutableDictionary alloc]initWithDictionary:[dataObject.data objectAtIndex:currentRow]];
    
    [self.navigationItem setRightBarButtonItem:trashButton];
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) textFieldEditing:(UITextField *)textField{
    
    if(textField.tag==0){[tempDict setObject:textField.text forKey:@"First"];}
    else if(textField.tag==1){[tempDict setObject:textField.text forKey:@"Middle"];}
    else if(textField.tag==2){[tempDict setObject:textField.text forKey:@"Last"];}
    else if(textField.tag==3){[tempDict setObject:textField.text forKey:@"Contact"];}
    else if(textField.tag==4){[tempDict setObject:textField.text forKey:@"Birthdate"];}
    
}

- (void) textFieldDidBeginEditing:(UITextField *)textField{
    if(textField.tag==4)
    {
        pickerTextField = [[UITextField alloc] init];
        pickerTextField = textField;
    }
}

- (void) pickerValueChanged:(UIDatePicker *)thisPicker{

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    
    dateString = [formatter stringFromDate:thisPicker.date];
    
    [pickerTextField setText:dateString];
}

- (void)saveButtonClicked:(id)sender{
    
    [self resignFirstResponder];
    
    [dataObject.data replaceObjectAtIndex:currentRow withObject:tempDict];
    
    [dataObject.userDefault setObject:dataObject.data forKey:@"data"];
    [dataObject.userDefault synchronize];

    UIAlertView *saveAlert = [[UIAlertView alloc]initWithTitle:@"Save Successful" message:@"Contact has been saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [saveAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)trashButtonClicked:(id)sender{
    UIActionSheet *del = [[UIActionSheet alloc]initWithTitle:@"Confirm Deletion" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:nil];
    [del showInView:[self view]];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        [dataObject.data removeObjectAtIndex:currentRow];
            NSLog(@"%d",[dataObject.data count]);
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"calling rdpm");
        [delegate reloadDataProtocolMethod];
        NSLog(@"after call");
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)return 3;
    if(section==1)return 1;
    if(section==2)return 1;
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{ 
    if(section==0)return @"Full Name";
    if(section==1)return @"Contact Number";
    if(section==2)return @"Birthdate";
    
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DVCellView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *cellarray = [[NSBundle mainBundle] loadNibNamed:@"DVCellView" owner:self options:nil];
    cell = [cellarray objectAtIndex:0];

    cellLabel.text = [[cellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
  
    if(indexPath.row==0&&indexPath.section==0){
        cellTextField.text = [tempDict objectForKey:@"First"];
        cellTextField.tag=0;
    }
    if(indexPath.row==1&&indexPath.section==0){
        cellTextField.text = [tempDict objectForKey:@"Middle"];
        cellTextField.tag=1;
    }
    if(indexPath.row==2&&indexPath.section==0){
        cellTextField.text = [tempDict objectForKey:@"Last"];
        cellTextField.tag=2;
    }
    if(indexPath.row==0&&indexPath.section==1){
        cellTextField.text = [tempDict objectForKey:@"Contact"];
        cellTextField.tag=3;
    }
    if(indexPath.row==0&&indexPath.section==2){
        cellTextField.text = [tempDict objectForKey:@"Birthdate"];
        cellTextField.tag=4;
    }
    
    [cellTextField addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];
    
    if(indexPath.section==1){
        [cellTextField setKeyboardType:UIKeyboardTypePhonePad];
    }
    if(indexPath.section==2){
        [cellTextField setInputView:picker];
    }
    return cell;
}

#pragma Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
