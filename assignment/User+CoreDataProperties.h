//
//  User+CoreDataProperties.h
//  assignment
//
//  Created by Apple on 19/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *phone_number;
@property (nullable, nonatomic, retain) NSString *fname;
@property (nullable, nonatomic, retain) NSString *lname;
@property (nullable, nonatomic, retain) Organization *organizations;

@end

NS_ASSUME_NONNULL_END
