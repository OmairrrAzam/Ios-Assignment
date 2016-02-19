//
//  User.h
//  assignment
//
//  Created by Apple on 19/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Organization;

NS_ASSUME_NONNULL_BEGIN

@interface User : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
-  (void)save;
@end

NS_ASSUME_NONNULL_END

#import "User+CoreDataProperties.h"
