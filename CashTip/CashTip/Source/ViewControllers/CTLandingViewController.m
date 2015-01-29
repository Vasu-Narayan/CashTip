//
//  CTLandingViewController.m
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTLandingViewController.h"
#import "CTEngine.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "CTEmployeeViewController.h"

@interface CTLandingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tipCodeInputTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerBottomSpaceConstraint;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) MBProgressHUD *progressHUD;
@property (strong, nonatomic) CTEmployee *selectedEmployee;

@end

@implementation CTLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Welcome";
    self.tipCodeInputTextField.layer.borderColor = [[UIColor colorWithRed:39.0/255.0 green:173.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    self.tipCodeInputTextField.layer.borderWidth = 1.0;
    self.containerWidthConstraint.constant = self.view.frame.size.width;
    self.containerHeightConstraint.constant = self.view.frame.size.height-20;
    [self.view layoutIfNeeded];
    [self registerForKeyboardNotifications];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent
- (void)keyboardWasShown:(NSNotification*)aNotification {
    [self.containerView addGestureRecognizer:self.tapGestureRecognizer];    
    self.containerBottomSpaceConstraint.constant = 100;
    [self.view layoutIfNeeded];
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [self.containerView removeGestureRecognizer:self.tapGestureRecognizer];
    self.containerBottomSpaceConstraint.constant = 0.f;
    [self.view layoutIfNeeded];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tapGestureRecognized:(UITapGestureRecognizer *)tapGestureRecognier
{
    [self.view endEditing:YES];
}

- (IBAction)verifyTipCode:(id)sender {
    
//    if (self.tipCodeInputTextField.text.length <= 0) {
//        [UIAlertView alertViewWithTitle:@"Invalid Tip Code" message:@"Tip Code can't be empty. Please enter valid Tip Code." cancelButtonTitle:@"OK" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
//            [self.tipCodeInputTextField becomeFirstResponder];
//        } onCancel:^{
//            [self.tipCodeInputTextField becomeFirstResponder];
//        }];
//    }
//    else {
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.view addSubview:self.progressHUD];
        
        self.selectedEmployee = [[CTEngine sharedEngine] employeeWithTipCode:self.tipCodeInputTextField.text];
        
        // Set determinate mode
        self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
        
        self.progressHUD.delegate = self;
        self.progressHUD.labelText = @"Checking In";
        
        // myProgressTask uses the HUD instance to update progress
        __weak typeof(self) weakSelf = self;
        [self.progressHUD showAnimated:YES whileExecutingBlock:^{
            [weakSelf myProgressTask];
        } completionBlock:^{
            [weakSelf.progressHUD removeFromSuperview];
            weakSelf.progressHUD = nil;
            
            [weakSelf performSegueWithIdentifier:@"showEmployeeList" sender:nil];
            [weakSelf.navigationController setNavigationBarHidden:NO animated:YES];
        }];
//    }*/
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [self.progressHUD removeFromSuperview];
    self.progressHUD = nil;
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.progressHUD.progress = progress;
        usleep(10000);
    }
}

- (void)codesSelected:(id)sender
{
    [self performSegueWithIdentifier:@"showTipCodes" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEmployeeDetails"]) {
        CTEmployeeViewController *empViewController = (CTEmployeeViewController *)[segue destinationViewController];
        empViewController.employee = self.selectedEmployee;
    }
}

@end
