//
//  Organization+CoreDataProperties.h
//  assignment
//
//  Created by Apple on 19/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Organization.h"

NS_ASSUME_NONNULL_BEGIN

@interface Organization (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) id image_url;
@property (nullable, nonatomic, retain) NSString *desc;
@property (nullable, nonatomic, retain) NSString *country;
@property (nullable, nonatomic, retain) id avatar;
@property (nullable, nonatomic, retain) NSManagedObject *users;

@end

NS_ASSUME_NONNULL_END
