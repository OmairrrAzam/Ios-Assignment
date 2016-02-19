

#import "UserManager.h"
#import "User.h"
#import "Organization.h"
#import "CoreDataStack.h"
#import "AFNetworking.h"

@implementation UserManager

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password  {
    
    CoreDataStack *coreData = [[CoreDataStack alloc] init];

   // NSLog(@"user :%@", email);
   // NSLog(@"pss :%@", password);
    // 1
    //NSString *string = [NSString stringWithFormat:@"%@users/authenticate/", BaseURLString];
    //NSURL *url = [NSURL URLWithString:string];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSDictionary *params = @{@"email": email,
                             @"password": password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://www.splicked.com/api/users/authenticate/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(self.delegate){
            
            NSDictionary *dictUser = [responseObject objectForKey:@"user"];
            
           // NSLog(@"user-id is :%@", [dictUser objectForKey:@"id"]);
            
             NSArray *arrOrg = (NSArray *)[responseObject objectForKey:@"organization"];
             //NSArray *organizations = [TMOrganizationModel loadFromArray:arrOrganizations];
            
            
           
            
            User *user          = [NSEntityDescription
                                        insertNewObjectForEntityForName:@"User"
                                            inManagedObjectContext:coreData.managedObjectContext];
            user.id             = [dictUser objectForKey:@"id"];
            user.email          = [dictUser objectForKey:@"email"];
            user.phone_number   = [dictUser objectForKey:@"phone_number"];
            user.fname      = [dictUser objectForKey:@"first_name"];
            user.lname       = [dictUser objectForKey:@"last_name"];
            
            
    
            
            for (Organization *or in arrOrg) {
                
                Organization *org = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Organization"
                                     inManagedObjectContext:coreData.managedObjectContext];
                
                org.id          = [or valueForKey:@"id"];
                org.name        = [or valueForKey:@"name"];
                org.image_url    = [or valueForKey:@"image_url"];
                org.desc        = [or valueForKey:@"description"];
                org.country     = [or valueForKey:@"country"];
                org.avatar      = [or valueForKey:@"avatar"];
                
                //connecting relationships
                org.users = user;
                user.organizations = org;
            }
            
            NSError *error;
            if (![coreData.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
            [self.delegate userManager:self didAuthenticateWithUser:user organizations:arrOrg];
           // User *userInfo = [[User alloc] initWithDict:dictUser];
            
            // userInfo.id = dictUser.id;
            //UserModel *user = [[TMUserModel alloc] initWithDictionary:dictUser];
            
           // NSArray *arrOrganizations = (NSArray *)[responseObject objectForKey:@"organization"];
            // NSArray *organizations = [TMOrganizationModel loadFromArray:arrOrganizations];
            
            
            // NSLog(@"JSON: %lu", (unsigned long)[dictUser count]);
            
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:@"Data Successfully Recieved"
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
       //  [self.delegate userManager:self didAuthenticateWithUser:userInfo];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    //    NSString *message = [self extractMessageFromTask:operation andError:error];
        if (self.delegate) {
            [self.delegate userManager:self didFailToAuthenticateWithMessage:@"Some error @ afhttprequestoperation failure"];
        }
    }];
}

@end
