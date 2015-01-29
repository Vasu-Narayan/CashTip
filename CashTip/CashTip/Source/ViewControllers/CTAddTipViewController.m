//
//  CTAddTipViewController.m
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTAddTipViewController.h"
#import "UIAlertView+MKBlockAdditions.h"

@interface CTAddTipViewController ()

@property (weak, nonatomic) IBOutlet UIView *inputFieldContainer;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *dollar1Button;
@property (weak, nonatomic) IBOutlet UIButton *dollar2Button;
@property (weak, nonatomic) IBOutlet UIButton *dollar5Button;

@property (strong, nonatomic) MBProgressHUD *progressHUD;

@end

@implementation CTAddTipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Add Tip";
    
    self.inputFieldContainer.layer.borderWidth = 1.0;
    self.inputFieldContainer.layer.borderColor = [[UIColor colorWithRed:39.0/255.0 green:173.0/255.0 blue:204.0/255.0 alpha:1.0] CGColor];
    self.dollar1Button.layer.borderColor = [UIColor blackColor].CGColor;
    self.dollar2Button.layer.borderColor = [UIColor blackColor].CGColor;
    self.dollar5Button.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.dollar1Button.layer.borderWidth = 0.5;
    self.dollar2Button.layer.borderWidth = 0.5;
    self.dollar5Button.layer.borderWidth = 0.5;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendTip:(id)sender {
    
    if ((self.inputTextField.text.length > 0) && (self.inputTextField.text.floatValue <= 100.0)) {
        [self.inputTextField resignFirstResponder];
        
        self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.view addSubview:self.progressHUD];
        
        // Set determinate mode
        self.progressHUD.mode = MBProgressHUDModeAnnularDeterminate;
        
        self.progressHUD.delegate = self;
        self.progressHUD.labelText = @"Sending...";
        
        // myProgressTask uses the HUD instance to update progress
        __weak typeof(self) weakSelf = self;
        [self.progressHUD showAnimated:YES whileExecutingBlock:^{
            [weakSelf myProgressTask:10000];
        } completionBlock:^{
            [weakSelf.progressHUD removeFromSuperview];
            weakSelf.progressHUD = nil;
            
            [weakSelf showCheckMarkProgress];
        }];
        
    }else {
        NSString *message = (self.inputTextField.text.floatValue > 100.0) ? @"Maximum allowed Tip amount is $100. Please enter amount less than $100." : @"Please enter valid amount";
        
        [UIAlertView alertViewWithTitle:@"Invalid amount" message:message cancelButtonTitle:@"OK" otherButtonTitles:nil onDismiss:^(int buttonIndex) {
            [self.inputTextField becomeFirstResponder];
        } onCancel:^{
            [self.inputTextField becomeFirstResponder];
        }];
    }
}


- (IBAction)dollar1Selected:(id)sender {
    self.inputTextField.text = @"1";
}

- (IBAction)dollar2Selected:(id)sender {
    self.inputTextField.text = @"2";
}

- (IBAction)dollar3Selected:(id)sender {
    self.inputTextField.text = @"5";
}

- (void)showCheckMarkProgress
{
    self.progressHUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.view addSubview:self.progressHUD];
    self.progressHUD.mode = MBProgressHUDModeCustomView;
    
    self.progressHUD.delegate = self;
    UIImage *image = [UIImage imageNamed:@"37x-Checkmark.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    self.progressHUD.customView = imageView;
    self.progressHUD.labelText = @"Tip Paid";
    self.progressHUD.animationType = MBProgressHUDAnimationZoomOut;
    
    __weak typeof(self) weakSelf = self;
    [self.progressHUD showAnimated:YES whileExecutingBlock:^{
        [weakSelf myProgressTask:5000];
    } completionBlock:^{
        [weakSelf.progressHUD removeFromSuperview];
        weakSelf.progressHUD = nil;
        [UIAlertView alertViewWithTitle:@"Suceess!!" message:[NSString stringWithFormat:@"Tip paid to %@ successfully.", self.employee.name] cancelButtonTitle:@"OK"];
    }];
}

- (void)myProgressTask:(NSInteger)interval {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        self.progressHUD.progress = progress;
        usleep((useconds_t)interval);
    }
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
