//
//  MasterViewController.m
//  assignment
//
//  Created by Apple on 19/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "OrganizationViewController.h"
#import "Organization.h"
#import "TMProfOrgVC.h"

@interface OrganizationViewController ()

- (IBAction)logout:(id)sender;

@end

@implementation OrganizationViewController
@synthesize orgArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    TMProfOrgVC *prof = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"OrgProfile"]){
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        prof.organization = [orgArray objectAtIndex:indexPath.row];
    }
}


#pragma mark - Table View


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [orgArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    // Check for a reusable cell first, use that if it exists
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = [[orgArray objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"OrgProfile" sender:(nil)];
}

#pragma mark - IBActions

- (IBAction)logout:(id)sender {
    NSLog(@"Logout Button Clicked");
}
@end
