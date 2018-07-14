//
//  detailViewController.m
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/13/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import "detailViewController.h"
#import "picsViewController.h"
#import "picsViewCell.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.caption.text = self.detailPost.text;
    
    PFFile *userImageFile = self.detailPost.image;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *convertedImage = [UIImage imageWithData:imageData];
            self.image.image = convertedImage;
            
        }}];
    
    NSDate *newDate = self.detailPost.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd/yy";
    
    NSString *dateString =  [dateFormatter stringFromDate:newDate];
    
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    
    timeFormatter.dateFormat = @"HH/mm/ss";
    NSString *timeString = [timeFormatter stringFromDate:newDate];
    
    self.timestamp.text = [[dateString stringByAppendingString:@"   "] stringByAppendingString:timeString];
    
//    self.image = [self.detailPost imag];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}
*/

@end
