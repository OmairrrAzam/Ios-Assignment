//
//  Clogin.m
//  FailedBankCD
//
//  Created by Apple on 18/02/2016.
//  Copyright © 2016 Adam Burkepile. All rights reserved.
//

#import "Clogin.h"
#import "UserManager.h"
#import "User.h"
#import "AJWValidator.h"
#import "OrganizationViewController.h"



@interface Clogin ()<UITextFieldDelegate, AJWValidatorDelegate>
    

@property (strong, nonatomic) UserManager *manager;
@property (strong, nonatomic) AJWValidator *emailValidator;
@property (strong, nonatomic) AJWValidator *passValidator;
@property (readwrite) NSString* email;
@property (readwrite) NSString* pass;
@property (readwrite) BOOL tfEmailValid;
@property (readwrite) BOOL tfPassValid;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPass;
@property (weak, nonatomic) IBOutlet UITextView *errorTextView;
@property (weak, nonatomic) IBOutlet UITextView *errorTextViewPass;
- (IBAction)btnLogin:(id)sender;

@end


@implementation Clogin
@synthesize email;
@synthesize pass;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Entered View Did Load of Login Controller");
    
    self.tfEmailValid = FALSE;
    self.tfPassValid = FALSE;
    
    self.emailValidator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [self.emailValidator addValidationToEnsurePresenceWithInvalidMessage:NSLocalizedString(@"This is required!", nil)];
    self.passValidator = [AJWValidator validatorWithType:AJWValidatorTypeString];
    [self.passValidator addValidationToEnsurePresenceWithInvalidMessage:NSLocalizedString(@"This is required!", nil)];

    [self.tfEmail ajw_attachValidator:self.emailValidator];
    [self.tfPass ajw_attachValidator:self.passValidator];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self.tfEmail becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - setting accessors 

- (void)setEmailValidator:(AJWValidator *)validator
{
    _emailValidator = validator;
    _emailValidator.delegate = self;
    
    __typeof__(self) __weak weakSelf = self;
    
    _emailValidator.validatorStateChangedHandler = ^(AJWValidatorState newState) {
        
        switch (newState) {
            case AJWValidatorValidationStateValid: {
               
                weakSelf.tfEmailValid = TRUE;
                UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
                //self.tfEmail.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
                NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
                self.tfEmail.attributedPlaceholder = str;
                self.errorTextView.text = @"";
                

                break;
            }
            case AJWValidatorValidationStateInvalid: {
                weakSelf.tfEmailValid = FALSE;
                UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
                //self.tfEmail.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
                NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
                self.tfEmail.attributedPlaceholder = str;
                self.errorTextView.text = [self.emailValidator.errorMessages componentsJoinedByString:@" 💣\n"];
                self.errorTextView.textColor = invalidRed;

                break;
            }
            case AJWValidatorValidationStateWaitingForRemote: {
                //[weakSelf handleWaiting];
                break;
            }
        }
    };
    
    
}

- (void)setPassValidator:(AJWValidator *)validator
{
    _passValidator = validator;
    _passValidator.delegate = self;
    
    __typeof__(self) __weak weakSelf = self;
    
    _passValidator.validatorStateChangedHandler = ^(AJWValidatorState newState) {
        
        switch (newState) {
            case AJWValidatorValidationStateValid: {
                
                weakSelf.tfPassValid = TRUE;
                UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
                //self.tfEmail.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
                NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
                self.tfPass.attributedPlaceholder = str;
                self.errorTextViewPass.text = @"";
                

                break;
            }
            case AJWValidatorValidationStateInvalid: {
                
                weakSelf.tfPassValid = FALSE;
                UIColor *invalidRed = [UIColor colorWithRed:0.89 green:0.18 blue:0.16 alpha:1];
                //self.tfEmail.backgroundColor = [invalidRed colorWithAlphaComponent:0.3];
                NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor redColor] }];
                self.tfPass.attributedPlaceholder = str;
                self.errorTextViewPass.text = [self.passValidator.errorMessages componentsJoinedByString:@" 💣\n"];
                self.errorTextViewPass.textColor = invalidRed;
               
                
                break;
            }
            case AJWValidatorValidationStateWaitingForRemote: {
                //[weakSelf handleWaiting];
                break;
            }
        }
    };
    
    
}





#pragma mark - IBAction Callbacks

-(IBAction)switchChanged:(id)sender{
    // dont delete me
    // switch handler
    
}


- (IBAction)btnLogin:(id)sender {
    
    NSLog(@"Login Btn Clicked");
    
    [self.emailValidator validate:self.tfEmail.text];
    [self.passValidator validate:self.tfPass.text];
    
    if(!self.tfEmailValid || !self.tfPassValid){
        NSLog(@"Validation Failed");
        return;
    }
    
    
    email = self.tfEmail.text;
    pass = self.tfPass.text;
    
    if (!self.manager) {
        self.manager = [[UserManager alloc] init];
        self.manager.delegate = self;
    }
  
    [self.manager authenticateWithEmail:self.email password:self.pass  cdataFlag:cDataFlag.isOn];
}

- (IBAction)cDataFlag:(id)sender {
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
    
    [user save];
    
    UINavigationController *orgNavigator = [self.storyboard instantiateViewControllerWithIdentifier:@"Org_Nc"];
    
    OrganizationViewController *organizationsVC = (OrganizationViewController *)[orgNavigator.viewControllers objectAtIndex:0];
   
    organizationsVC.orgArray = organizations;
    self.view.window.rootViewController = orgNavigator;
    
}

- (void)userManager:(UserManager *)userManager didFailToAuthenticateWithMessage:(NSString *)message {
    NSLog(@"message from userManager Delegate didFailToAuthenticateWithMessage method");
}
@end
