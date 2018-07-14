//
//  picsViewController.m
//  ezrainstagram
//
//  Created by Ezra Bekele on 7/10/18.
//  Copyright © 2018 ezrainstagram. All rights reserved.
//

#import "picsViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "picsViewCell.h"
#import "detailViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>"

@interface picsViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property NSArray *posts;

@end

@implementation picsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    /*Post *post = [Post object];
    post.text = @"Ezra";
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"succeed");
    }];*/
    
//    PFQuery *query = [Post query];
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
////        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
////
////        }
//        // objects.description == post.text;
//        //NSLog(objects);
//    }];
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    //self.refreshControl = localRefreshControl;
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self.activityIndicator startAnimating];
    [self.refreshControl beginRefreshing];
    [self fetchPosts];
}


-(void) fetchPosts{
    
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query addDescendingOrder:@"createdAt"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            [self.activityIndicator stopAnimating];
            NSLog(@"fetchedDATA");
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

//getPosts
//setCell

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutUser:(id)sender {
    //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate logOutCurrentUser];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    picsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"abc" forIndexPath:indexPath];
    Post *latestPost = self.posts[indexPath.row];
    [cell setPost:latestPost];
    //cell.feedDescription.text = latestPost.text;
    //cell.feedDescription.text = posts.
    
    return cell;
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    self.currentPost = self.posts[indexPath.row];
    
    
    
    if ([segue.identifier isEqualToString:@"detailsSegue"])
    {
//        UINavigationController *newController = segue.destinationViewController;
        detailViewController *detailedController = [segue destinationViewController];
        detailedController.detailPost = self.currentPost;
    }
    else{
        UINavigationController *composeController = segue.destinationViewController;
        detailViewController *newComposeController = composeController.topViewController;
        //detailedController.detailPost = self.currentPost;
    }
    
//    UINavigationController *newController = segue.destinationViewController;
//    detailViewController *detailedController = newController.topViewController;
//    detailedController.detailPost = self.currentPost;
//
    //newController.image = self.tableView.
}


@end
