//
//  detailViewController.h
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/13/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@interface detailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *caption;
@property (nonatomic, strong) Post *detailPost;


@end
