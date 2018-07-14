//
//  picsViewCell.m
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/10/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import "picsViewCell.h"
#import "Post.h"
@implementation picsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost:(Post *)post
{
    self.feedDescription.text = post.text;
    
    PFFile *userImageFile = post.image;
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            UIImage *convertedImage = [UIImage imageWithData:imageData];
            self.cellImage.image = convertedImage;

        }
    }];
    
}

@end
