//
//  TMProfOrgVC.h
//  assignment
//
//  Created by Apple on 20/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMProfOrgVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *teDesc;
@property (weak, nonatomic) IBOutlet UIImageView *ivPic;

@property (nonatomic, readwrite) NSDictionary *organization;
@end
