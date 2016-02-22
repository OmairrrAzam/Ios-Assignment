

#import "UserManager.h"
#import "User.h"
#import "Organization.h"
#import "CoreDataStack.h"
#import "AFNetworking.h"

@implementation UserManager

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password  cdataFlag:(BOOL)flag {
    
    NSLog(@"inside authenticate manager");
    
    CoreDataStack *coreData = [[CoreDataStack alloc] init];
    
    if(flag){
         //get Data from local Database ... This task is yet to be done
    }else{
        [self getServerData:email password:password managedObjectContext:coreData.managedObjectContext];
    }
}

#pragma mark - Private Functions

-(void)getServerData: (NSString *)email password:(NSString *)password managedObjectContext:(NSManagedObjectContext *)context{
    
    NSLog(@"inside http data loading %@, %@", email,password);
    
    NSDictionary *params = @{@"email": email,@"password": password};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://www.splicked.com/api/users/authenticate/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(self.delegate){
            
            NSDictionary *dictUser = [responseObject objectForKey:@"user"];
            NSArray *arrOrg        = (NSArray *)[responseObject objectForKey:@"organization"];
            
            User *user          = [NSEntityDescription
                                   insertNewObjectForEntityForName:@"User"
                                   inManagedObjectContext:context];
            
            user.id             = [dictUser objectForKey:@"id"];
            user.email          = [dictUser objectForKey:@"email"];
            user.phone_number   = [dictUser objectForKey:@"phone_number"];
            user.fname          = [dictUser objectForKey:@"first_name"];
            user.lname          = [dictUser objectForKey:@"last_name"];
            
            
            
            //Core Data segment, needs to be improved.
            /*for (NSArray *or in arrOrg) {
             
             NSError *error;
             Organization *org       =  [NSEntityDescription
             insertNewObjectForEntityForName:@"Organization"
             inManagedObjectContext:coreData.managedObjectContext];
             
             org.id                  =  [or valueForKey:@"id"];
             org.name                =  [or valueForKey:@"name"];
             org.image_url           =  [or valueForKey:@"image_url"];
             org.desc                =  [or valueForKey:@"description"] != [NSNull null] ? [or valueForKey:@"description"] : @"Unknown Description" ;
             org.country             =  [or valueForKey:@"country"] != [NSNull null]? [or valueForKey:@"country"] : @"Unknown Country";
             org.avatar              = [or valueForKey:@"avatar"];
             org.users               = user;
             
             
             if (![coreData.managedObjectContext save:&error]) {
             NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
             }
             
             }*/
            
            
            [self.delegate userManager:self didAuthenticateWithUser:user organizations:arrOrg];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success"
                                                          message:@"Data Successfully Recieved"
                                                          delegate:nil
                                                          cancelButtonTitle:@"Ok"
                                                          otherButtonTitles:nil];
            [alertView show];
            
        } // if ends here
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        if (self.delegate) {
            [self.delegate userManager:self didFailToAuthenticateWithMessage:@"Some error @ afhttprequestoperation failure"];
        }
        
    }];
}

@end
