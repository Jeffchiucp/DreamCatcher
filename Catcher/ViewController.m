//
//  ViewController.m
//  Catcher
//
//  Created by JeffChiu on 3/1/16.
//  Copyright © 2016 JeffChiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *titles;
@property NSMutableArray *descriptions;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titles = [NSMutableArray new];
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
        [self.titles addObject:textField1.text];
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
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.descriptions objectAtIndex:indexPath.row];
    return cell;
    
}

//count the number of titles

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.titles.count;
}



- (IBAction)onEditButtonPressed:(UIBarButtonItem *)sender {
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



@end
