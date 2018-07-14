//
//  Post.m
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/10/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic text;
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}


+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.text = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFile fileWithName:@"image.png" data:imageData];
}



@end
