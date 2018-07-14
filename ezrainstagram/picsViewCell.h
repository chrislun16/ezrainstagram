//
//  picsViewCell.h
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/10/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface picsViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *feedDescription;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

- (void) setPost:(Post *)post;

@end
