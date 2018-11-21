//
//  ServersViewController.h
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServersViewController : UIViewController
@property (nonatomic, strong)NSMutableArray *servers;
@property (nonatomic, strong)NSMutableArray *filteredServers;
@property(nonatomic, assign) int PageCount;
@property(nonatomic, assign) int TotalPages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *activeBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
- (IBAction)FilterACtion:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UIView *TotalNumberView;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIView *iconsView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@end

NS_ASSUME_NONNULL_END
