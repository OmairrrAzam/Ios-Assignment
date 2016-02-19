//
//  User.m
//  assignment
//
//  Created by Apple on 19/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "User.h"
#import "Organization.h"

@implementation User


-(void)save{
    NSUserDefaults *nuDefault = [NSUserDefaults standardUserDefaults];
    [nuDefault setObject:self.email forKey:@"email_id"];
    [nuDefault synchronize];
}

// Insert code here to add functionality to your managed object subclass

@end
