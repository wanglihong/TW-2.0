//
//  LoginViewController.m
//  TW+(iPhone)
//
//  Created by Dennis Yang on 13-8-23.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "LoginViewController.h"
#import "AppAPIClient.h"
#import "SIAlertView.h"
#import "MBProgressHUD.h"
#import "JsonAnalyzer.h"
#import "UIViewController+Loaders.h"
#import "NSObject+Helpers.h"



@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIColor* darkColor = THEME_COLOR_DARK;
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldFontName = @"Avenir-Black";
    
    self.view.backgroundColor = THEME_COLOR_FULL;
    
    self.usernameField.backgroundColor = [UIColor whiteColor];
    self.usernameField.layer.cornerRadius = 3.0f;
    self.usernameField.placeholder = @"Email Address";
    self.usernameField.font = [UIFont fontWithName:fontName size:16.0f];
    
    
    UIImageView* usernameIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    usernameIconImage.image = [UIImage imageNamed:@"mail"];
    UIView* usernameIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    usernameIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [usernameIconContainer addSubview:usernameIconImage];
    
    self.usernameField.leftViewMode = UITextFieldViewModeAlways;
    self.usernameField.leftView = usernameIconContainer;
    
    
    self.passwordField.backgroundColor = [UIColor whiteColor];
    self.passwordField.layer.cornerRadius = 3.0f;
    self.passwordField.placeholder = @"Password";
    self.passwordField.font = [UIFont fontWithName:fontName size:16.0f];
    self.passwordField.secureTextEntry = YES;
    
    
    UIImageView* passwordIconImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 24, 24)];
    passwordIconImage.image = [UIImage imageNamed:@"lock"];
    UIView* passwordIconContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 41, 41)];
    passwordIconContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    [passwordIconContainer addSubview:passwordIconImage];
    
    self.passwordField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordField.leftView = passwordIconContainer;
    
    self.loginButton.backgroundColor = darkColor;
    self.loginButton.layer.cornerRadius = 3.0f;
    self.loginButton.titleLabel.font = [UIFont fontWithName:boldFontName size:20.0f];
    [self.loginButton setTitle:@"SIGN UP HERE" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.5f] forState:UIControlStateHighlighted];
    
    self.forgotButton.backgroundColor = [UIColor clearColor];
    self.forgotButton.titleLabel.font = [UIFont fontWithName:fontName size:12.0f];
    [self.forgotButton setTitle:@"Forgot Password?" forState:UIControlStateNormal];
    [self.forgotButton setTitleColor:darkColor forState:UIControlStateNormal];
    [self.forgotButton setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
    
    self.titleLabel.textColor =  [UIColor whiteColor];
    self.titleLabel.font =  [UIFont fontWithName:boldFontName size:24.0f];
    self.titleLabel.text = @"GOOD TO SEE YOU";
    
    self.subTitleLabel.textColor =  [UIColor whiteColor];
    self.subTitleLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.subTitleLabel.text = @"Welcome back, please login below";
    
    self.usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    self.passwordField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

- (IBAction)login:(id)sender
{
    if (self.usernameField.text == nil || self.usernameField.text.length == 0)
    {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Empty username." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        alert(@"Empty username.", @"OK");
    }
    else if (self.passwordField.text == nil || self.passwordField.text.length == 0)
    {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Empty password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        alert(@"Empty password.", @"OK");
    }
    else
    {
        [self loginWithUserName:self.usernameField.text password:self.passwordField.text];
    }
}

- (void)swipeHandler:(UIPanGestureRecognizer *)sender
{
    [super swipeHandler:sender];
    
    if ([self.usernameField isFirstResponder] || [self.passwordField isFirstResponder])
    {
        [self.usernameField performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.25];
        [self.passwordField performSelector:@selector(resignFirstResponder) withObject:nil afterDelay:0.25];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark -
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self login:nil];
    return NO;
}

@end
