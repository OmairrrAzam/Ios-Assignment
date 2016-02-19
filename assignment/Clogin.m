//
//  Clogin.m
//  FailedBankCD
//
//  Created by Apple on 18/02/2016.
//  Copyright © 2016 Adam Burkepile. All rights reserved.
//

#import "Clogin.h"
#import "UserManager.h"
//#import "FBCDMasterViewController.h"
@interface Clogin ()

@property (strong, nonatomic) UserManager *manager;

@end


@implementation Clogin
@synthesize email;
@synthesize pass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Entered View Did Load of Login Controller");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogin:(id)sender {
    
    NSLog(@"Login Btn Clicked");
    
    email = self.tfEmail.text;
    pass = self.tfPass.text;
    
    if (!self.manager) {
        self.manager = [[UserManager alloc] init];
        self.manager.delegate = self;
    }
    
    [self.manager authenticateWithEmail:self.email password:self.pass];
    //self.btnLogin.loading = YES;
    //self.btnLogin.enabled = NO;
    // NSLog(@"Email : %@", email);
    // NSLog(@"Password : %@", pass);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UserManagerDelegate Methods

- (void)userManager:(UserManager *)userManager didAuthenticateWithUser:(User *)user
                    organizations:(NSArray *)organizations{
    NSLog(@"i m in clogin.h in usermanater success delegate message");
    //[user save];
    
    // UINavigationController *orgNavigator = [self.storyboard instantiateViewControllerWithIdentifier:@"Org_Nc"];
    
    /*FBCDMasterViewController *organizationsVC = (FBCDMasterViewController *)[orgNavigator.viewControllers objectAtIndex:0];
    //organizationsVC.isInitialFlow = YES;
    organizationsVC.orgArray = organizations;
    self.view.window.rootViewController = orgNavigator;*/
    //AppDelegate *appDelegate = [AppDelegate globalDelegate];
    
}

- (void)userManager:(UserManager *)userManager didFailToAuthenticateWithMessage:(NSString *)message {
    
}
@end
