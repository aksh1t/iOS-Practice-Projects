#import "RVController.h"
#import "DVController.h"

@interface RVController ()

@end

@implementation RVController

@synthesize addButton,textTemp,labelTemp;

- (void)reloadDataProtocolMethod{
    
    [self.tableView reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dataObject = [[MyData alloc]init];
    
    dataObject.userDefault = [NSUserDefaults standardUserDefaults];

    dataObject.data = [dataObject.userDefault objectForKey:@"data"];

    if(dataObject.data == NULL){
        dataObject.data = [[NSMutableArray alloc]init];
    }

    self.navigationItem.title = @"Home";
    
    self.navigationItem.rightBarButtonItem = self.addButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)updateData:(UITextField *)textField{
    
    [[dataObject.data objectAtIndex:dataObject.currentlyEditingRow] setObject:textField.text forKey:@"Name"];
    [dataObject.userDefault setObject:dataObject.data forKey:@"data"];
    [dataObject.userDefault synchronize];
}

- (void)addButtonPressed:(id)sender{
    
    NSArray *objectArray = [[NSArray alloc]initWithObjects:@"",@"",@"",@"",@"",@"",nil];
    NSArray *keyArray = [[NSArray alloc]initWithObjects:@"Name",@"First",@"Middle",@"Last",@"Contact",@"Birthdate",nil];
    
    dataObject.tempDict = [[NSMutableDictionary alloc]initWithObjects:objectArray forKeys:keyArray];
    
    [dataObject.data addObject:dataObject.tempDict];
    
    [self.tableView reloadData];
}


#pragma Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataObject.data count];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"aBTFRAIP:accessory tapped");
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"CellView";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *cellarray = [[NSBundle mainBundle] loadNibNamed:@"CellView" owner:self options:nil];
    cell = [cellarray objectAtIndex:0];
    
    [textTemp addTarget:self action:@selector(textFieldEditing:) forControlEvents:UIControlEventEditingChanged];

    textTemp.tag = indexPath.row;
    textTemp.text = [[dataObject.data objectAtIndex:indexPath.row] objectForKey:@"Name"];
    
    labelTemp.text = [NSString stringWithFormat:@"%d.",(indexPath.row+1)];

    return cell;
}

#pragma Text Field Delegate

- (void) textFieldDidBeginEditing:(UITextField *)textField{

    dataObject.currentlyEditingRow = textField.tag;
    dataObject.selectedRow = dataObject.currentlyEditingRow;
}

- (void) textFieldEditing:(UITextField *)textField{
    [self updateData:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textTemp resignFirstResponder];
    
    DVController *detailViewController = [[DVController alloc]initWithNibName:@"DVController" bundle:nil];
    
    detailViewController.titleString = [[dataObject.data objectAtIndex:dataObject.selectedRow]objectForKey:@"Name"];
    detailViewController.dataObject = dataObject;
    
    [self.navigationController pushViewController:detailViewController animated:YES];

    return YES;
}


#pragma Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    dataObject.selectedRow = indexPath.row;

    [textTemp resignFirstResponder];
    
    
    DVController *detailViewController = [[DVController alloc]initWithNibName:@"DVController" bundle:nil];
    
    detailViewController.delegate = self;
    detailViewController.titleString = [[dataObject.data objectAtIndex:dataObject.selectedRow]objectForKey:@"Name"];
    detailViewController.currentRow = dataObject.selectedRow;
    detailViewController.dataObject = dataObject;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [dataObject.data removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadData];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    
    }   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
