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
    
    IBOutlet UISwitch *cDataFlag;
    
}


@end
