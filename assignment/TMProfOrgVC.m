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
   /* [self.ivPic setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell setNeedsLayout];
                                       
                                   } failure:nil];*/
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
