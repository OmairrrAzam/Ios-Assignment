//
//  Clogin.h
//  FailedBankCD
//
//  Created by Apple on 18/02/2016.
//  Copyright © 2016 Adam Burkepile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

@interface Clogin : UIViewController <UserManagerDelegate, UITextFieldDelegate> {
    NSString *email;
    NSString *pass;
   
    
}

@property (readwrite) NSString* email;
@property (readwrite) NSString* pass;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;

@property (weak, nonatomic) IBOutlet UITextField *tfPass;
- (IBAction)btnLogin:(id)sender;

@end
