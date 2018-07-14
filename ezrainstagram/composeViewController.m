//
//  composeViewController.m
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/10/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import "composeViewController.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "picsViewController.h"
#import "picsViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>"

@interface composeViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UIImage *thePhoto;


@end

@implementation composeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    
    
    //editedImage = [self resizeImage:editedImage withSize:<#(CGSize)#>]
    //self.imageView.image = originalImage;
    
    // Do something with the images (based on your use case)
    /*Post *post = [Post object];
    post.text = @"Ezra";
    //post.image = [];
    
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"succeed");*/
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [picker dismissViewControllerAnimated:YES completion:^{
        self.imageView.image = editedImage;
    }];
    
}


//- (IBAction)didShare:(id)sender {
//    [self dismissViewControllerAnimated:true completion:nil];
////
////    UIImage *pic = [UIImage imageNamed:@"image_placeholder"];
////    [self.imageView setImage:pic];
////    [self dismissViewControllerAnimated:true completion:nil];
//}

- (IBAction)didTapShare:(id)sender {
    //[self dismissViewControllerAnimated:true completion:nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [Post postUserImage:self.imageView.image withCaption:self.textViewstuff.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            [MBProgressHUD hideHUDForView:self.view animated:true];
            NSLog(@"posted image");
            [self dismissViewControllerAnimated:true completion:nil];
        }
        else{
            NSLog(@"unsuccessful in posting image");
        }
    }];
}

//- (void) postPost
//{
//    Post *post = [Post object];
//    post.text = self.description;
//    post.image = self.imageView.image;
//    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        NSLog(@"succeed");
//    }];
//}

- (IBAction)didTap:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    //imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}




//- (IBAction)tapShare:(id)sender {
//    if (![self.imageView.image isEqual:[UIImage imageNamed:@"image_placeholder"]])
//    {
//        [Post postUserImage:self.imageView.image withCaption:self.description.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
//            if (succeeded)
//            {
//                self.imageView.image = [UIImage imageNamed:@"image_placeholder"];
//            }
//        }];
//
//    }
//}


     /*
- (IBAction)tapImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navigationController = [segue destinationViewController];
    UIImagePickerController *imagePickerController = (UIImagePickerController*)navigationController.topViewController;
    imagePickerController.delegate = self;
}

- (IBAction)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}



@end
