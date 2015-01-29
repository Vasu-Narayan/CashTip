//
//  CTTipCodeListViewController.m
//  CashTip
//
//  Created by Vasu Narayan on 16/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTTipCodeListViewController.h"
#import "CTEngine.h"

@interface CTTipCodeListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CTTipCodeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Tip Codes";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneSelected:)];
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doneSelected:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[CTEngine sharedEngine] employees] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tipCodeTableViewCellID";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }

    NSArray *employees = [[CTEngine sharedEngine] employees];
    if (indexPath.row < employees.count) {
        CTEmployee *employee = [employees objectAtIndex:indexPath.row];
        cell.textLabel.text = employee.name;
        cell.detailTextLabel.text = employee.tipCode;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods -

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:))
    {
        NSArray *employees = [[CTEngine sharedEngine] employees];
        if (indexPath.row < employees.count) {
            CTEmployee *employee = [employees objectAtIndex:indexPath.row];
            [[UIPasteboard generalPasteboard] setString:employee.tipCode];
        }
        
    }
}


@end
