//
//  CTEmployeeViewController.m
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTEmployeeViewController.h"
#import "CTAddTipViewController.h"

@interface CTEmployeeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *organizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;

@end

@implementation CTEmployeeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Employee Details";
    self.nameLabel.text = self.employee.name;
    self.tipCodeLabel.text = self.employee.tipCode;
    self.organizationLabel.text = [NSString stringWithFormat:@"Works @ %@", self.employee.company];
    self.locationLabel.text = self.employee.location;
    
    self.profilePicImageView.clipsToBounds = YES;
    self.profilePicImageView.layer.cornerRadius = 75.0;
    self.profilePicImageView.image = [UIImage imageNamed:self.employee.profilePicName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showAddTip"]) {
        CTAddTipViewController *addTipVC = (CTAddTipViewController *)[segue destinationViewController];
        addTipVC.employee = self.employee;
    }
}

@end
