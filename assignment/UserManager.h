

#import <Foundation/Foundation.h>
#import "User.h"

@class UserManager;

@protocol UserManagerDelegate

@optional
- (void)userManager:(UserManager *)userManager didAuthenticateWithUser:(User *)user  organizations:(NSArray *)organizations;
- (void)userManager:(UserManager *)userManager didFailToAuthenticateWithMessage:(NSString *)message;

@end

@interface UserManager: NSObject

@property (weak, nonatomic) id<UserManagerDelegate> delegate;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password ;
@end
