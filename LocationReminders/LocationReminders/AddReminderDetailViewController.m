//
//  AddReminderDetailViewController.m
//  LocationReminders
//
//  Created by Benjamin Laddin on 9/3/15.
//  Copyright (c) 2015 Benjamin Laddin. All rights reserved.
//

#import "AddReminderDetailViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface AddReminderDetailViewController ()<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *reminderTextField;
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *longTextField;



@end



@implementation AddReminderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)doneButtonPressed:(id)sender {
  NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                            self.reminderTextField.text, @"reminderTextfield",
                            self.latTextField.text, @"latTextField",
                            self.longTextField.text, @"longTextField",
                            nil];
  
  [[NSNotificationCenter defaultCenter]postNotificationName:@"textNotification" object:self userInfo:userInfo];
  [self.navigationController popViewControllerAnimated:true];
  
}

- (IBAction)signUpButtonPressed:(id)sender {
  PFSignUpViewController *signUpVC = [[PFSignUpViewController alloc] init];
  signUpVC.delegate = self;
  [self presentViewController:signUpVC animated:true completion:nil];
}

-(void)signUpViewController:(PFSignUpViewController * __nonnull)signUpController didSignUpUser:(PFUser * __nonnull)user{
  [signUpController dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)loginButtonPress:(id)sender {
  PFLogInViewController *logInVC = [[PFLogInViewController alloc] init];
  logInVC.delegate = self;
  [self presentViewController:logInVC animated:true completion:nil];
  
}

-(void)logInViewController:(PFLogInViewController * __nonnull)logInController didLogInUser:(PFUser * __nonnull)user{
  [logInController dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)logOutButtonPress:(id)sender {
  [PFUser logOut];
}
- (IBAction)reminderNameTextField:(id)sender {
  
}
- (IBAction)latCoordinateTextField:(id)sender {
  
}
- (IBAction)longCoordinateTextField:(id)sender {
  
}



@end
