//
//  CTEmployeeListViewController.m
//  CashTip
//
//  Created by Vasu Narayan on 29/01/15.
//  Copyright (c) 2015 Synclovis. All rights reserved.
//

#import "CTEmployeeListViewController.h"
#import "CTEngine.h"
#import "CTEmployeeViewController.h"

@interface CTEmployeeListViewController ()
@property (strong, nonatomic) CTEmployee *selectedEmployee;

@end

@implementation CTEmployeeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [[[CTEngine sharedEngine] employees] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSArray *employees = [[CTEngine sharedEngine] employees];
    if (indexPath.row < employees.count) {
        CTEmployee *employee = [employees objectAtIndex:indexPath.row];
        UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
        recipeImageView.image = [UIImage imageNamed:employee.profilePicName];
        
        [(UILabel *)[cell viewWithTag:200] setText:employee.name];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *employees = [[CTEngine sharedEngine] employees];
    if (indexPath.row < employees.count) {
        self.selectedEmployee = [employees objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showEmployeeDetails" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showEmployeeDetails"]) {
        CTEmployeeViewController *empViewController = (CTEmployeeViewController *)[segue destinationViewController];
        empViewController.employee = self.selectedEmployee;
    }
}

@end
