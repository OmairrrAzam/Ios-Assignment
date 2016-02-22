////
//  TMProfOrgVC.m
//  assignment
//
//  Created by Apple on 20/02/2016.
//  Copyright © 2016 Apple. All rights reserved.
//

#import "TMProfOrgVC.h"

@interface TMProfOrgVC ()


@end

@implementation TMProfOrgVC

@synthesize ivPic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:[_organization objectForKey:@"name"]];
    
    NSString *ImageURL = [self.organization objectForKey:@"image_url"];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
    
    self.ivPic.image = [UIImage imageWithData:imageData];
    self.teDesc.text = [self.organization objectForKey:@"description"];
    
    // download this image to local directory as well .. This is yet to be done...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
