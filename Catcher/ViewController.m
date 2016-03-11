//
//  ViewController.m
//  Catcher
//
//  Created by JeffChiu on 3/1/16.
//  Copyright © 2016 JeffChiu. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *titlesArray;
@property NSMutableArray *descriptions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlesArray = [NSMutableArray new];
    self.descriptions = [[NSMutableArray alloc]init];

}

//Show the Alert at Entry

-(void)presentEntryAlert
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Description";
    }];
    

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //get our title and description for our picker
        UITextField *textField1 = alertController.textFields.firstObject;
        [self.titlesArray addObject:textField1.text];
        [self.descriptions addObject:alertController.textFields.lastObject.text];
        [self.tableView reloadData];
    }];
    
    //Create alert option for new dream
    //help us to presentViewController
    
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

//implement the code to display my dreams on a list.
// give us the corresponding row that is reponding to the object.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    return cell;
    
}

//count the number of titles

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titlesArray.count;
}




- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
    if (self.editing){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }
    else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Done";
    }
        
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return true;
    
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *title = [self.titlesArray objectAtIndex:sourceIndexPath.row];
    [self.titlesArray removeObject:title];
    [self.titlesArray insertObject:title atIndex:destinationIndexPath.row];
    NSString *description = [self.descriptions objectAtIndex:sourceIndexPath.row];
    [self.descriptions removeObject:title];
    [self.descriptions insertObject:title atIndex:destinationIndexPath.row];
    
}

- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    [self presentEntryAlert];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = segue.destinationViewController;
    
    detailVC.titleString = [self.titlesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailVC.descriptionString = [self.descriptions objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titlesArray removeObjectAtIndex:indexPath.row];
    [self.descriptions removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end
