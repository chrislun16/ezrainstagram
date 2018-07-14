//
//  LoginViewController.m
//  
//
//  Created by Ezra Bekele on 7/9/18.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(id)sender {
    [self loginUser];

}
- (IBAction)signupButton:(id)sender {
    [self registerUser];

}



- (void)loginUser {
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"firstSegue" sender:nil];
            // display view controller that needs to shown after successful login
        }
    }];
    


}

// temp

- (void)registerUser {
    
    NSString *userName = self.username.text;
    NSString *password = self.password.text;
    
    if (userName.length == 0 || password.length == 0) { return; }
    
    PFUser *newUser = [PFUser new];
    newUser.username = userName;
    newUser.password = password;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
            NSLog(@"%ld: %@", error.code, error.localizedDescription);
    }];
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
