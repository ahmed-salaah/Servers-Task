//
//  ServersViewController.m
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import "ServersViewController.h"

#import "ServersCell.h"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@interface ServersViewController ()<ServersCellDelegate,UITableViewDataSourcePrefetching,UISearchBarDelegate>
@end

@implementation ServersViewController
bool finishedLoading = NO;
NSMutableArray *tempServers;
- (void)customizeUI {
    self.tableView.layer.masksToBounds = NO;
    self.tableView.layer.shadowOffset = CGSizeMake(1, 0);
    self.tableView.layer.shadowRadius = 1;
    self.tableView.layer.shadowOpacity = 0.2;
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
    self.userImage.layer.masksToBounds = YES;
    [self.tableView setBackgroundColor: [UIColor colorWithRed:(245.f/255.f) green:(245.f/255.f) blue:(245.f/255.f) alpha:1]];
    
    self.headerView.layer.masksToBounds = NO;
    self.headerView.layer.shadowOffset = CGSizeMake(1, 0);
    self.headerView.layer.shadowRadius = 1;
    self.headerView.layer.shadowOpacity = 0.2;
    
    self.allBtn.layer.cornerRadius = 20;
    self.allBtn.layer.masksToBounds = YES;
    self.activeBtn.layer.cornerRadius = 20;
    self.activeBtn.layer.masksToBounds = YES;
    self.downBtn.layer.cornerRadius = 20;
    self.downBtn.layer.masksToBounds = YES;
    
    self.locationView.layer.cornerRadius = 20;
    self.locationView.layer.masksToBounds = YES;
    self.locationView.layer.masksToBounds = NO;
    self.locationView.layer.shadowOffset = CGSizeMake(1, 0);
    self.locationView.layer.shadowRadius = 1;
    self.locationView.layer.shadowOpacity = 0.2;
   
    self.TotalNumberView.layer.cornerRadius = 15;
    self.TotalNumberView.layer.masksToBounds = YES;
    self.TotalNumberView.layer.masksToBounds = NO;
    self.TotalNumberView.layer.shadowOffset = CGSizeMake(1, 0);
    self.TotalNumberView.layer.shadowRadius = 1;
    self.TotalNumberView.layer.shadowOpacity = 0.2;


    self.iconsView.layer.masksToBounds = NO;
    self.iconsView.layer.shadowOffset = CGSizeMake(1, 0);
    self.iconsView.layer.shadowRadius = 1;
    self.iconsView.layer.shadowOpacity = 0.2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customizeUI];

    self.PageCount = 0;
    self.servers = [NSMutableArray new];
    [self fetchData];
    
}

-(void)fetchData{
    @try {
        finishedLoading = NO;
        WebServiceCalling *getUser = [[WebServiceCalling alloc]initWithURLString:login withID:[NSString stringWithFormat:@"%i",self.PageCount] andDomainURL:KServer];
        [getUser getData:^(id responseData) {
            [self.servers addObjectsFromArray:((Server *)responseData).content] ;
            self.TotalPages = ((Server *)responseData).totalPages;
            self.filteredServers = self.servers;
            
            dispatch_async(dispatch_get_main_queue(), ^{
//                int count = 0;
//                for (Content *wp in self.Servers ) {
//                    if (!self.Servers.count || ![self.Servers containsObject:wp]) {
//                        [self.Servers addObject:wp];
//                        count++;
//                    }
//                }
//
//                if(count > 0) {
//                    [self.tableView beginUpdates];
//                    [self.tableView insertSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.Servers.count-count, count)] withRowAnimation:UITableViewRowAnimationBottom];
//                     [self.tableView endUpdates];
//                }else
                    [self->_tableView reloadData];
                [self.totalLabel setText:[NSString stringWithFormat:@"%li", (long)((Server *)responseData).totalElements]];
            });
            finishedLoading = YES;
            self.PageCount ++;
        }];
    } @catch (NSException *exception) {
        [SVProgressHUD showErrorWithStatus:exception.description];
        finishedLoading = YES;
    } @finally {
       
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filteredServers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    ServersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ServersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundColor = [UIColor clearColor];
        [cell.imageView setBackgroundColor:[UIColor clearColor]];
        cell.imageView.contentMode =UIViewContentModeLeft;
        cell.delegate = self;
        
    }
    Content *server = [self.filteredServers objectAtIndex:indexPath.section];
    [cell.nameLabel setText:server.name];
    [cell.subtitle setText:server.serialNumber];
    [cell.ipLabbel setText:server.ipAddress];
    [cell.ipDomainLabel setText:server.ipSubnetMask];
    switch (server.status.id) {
        case 1:
            [cell.statusImage setImage:[UIImage imageNamed:@"green"]];
            break;
        case 2:
            [cell.statusImage setImage:[UIImage imageNamed:@"orange"]];
            break;
        case 3:
            [cell.statusImage setImage:[UIImage imageNamed:@"yellow"]];
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}


- (void)didTappedAlarmButtonAtCell:(nonnull ServersCell *)cell {
    cell.timerBtn.selected = !cell.timerBtn.selected;
}

- (void)didTappedCheckInButtonAtCell:(nonnull ServersCell *)cell {
    cell.checkBtn.selected = !cell.checkBtn.selected;

}

- (void)didTappedMuteButtonAtCell:(nonnull ServersCell *)cell {
    cell.muteBtn.selected = !cell.muteBtn.selected;

}

- (void)didTappedPhoneButtonAtCell:(nonnull ServersCell *)cell {
    cell.phoneBtn.selected = !cell.phoneBtn.selected;

}




- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    
    if(self.PageCount<self.TotalPages && finishedLoading){
        [self fetchData];
    }
}


- (IBAction)FilterACtion:(id)sender {
    @try {

        UIButton *btn = (UIButton*)sender;
        tempServers = [self.servers mutableCopy];
        switch (btn.tag) {
            case 1:{
                [self.allBtn setBackgroundColor:[UIColor colorWithRed:(73.f/255.f) green:(165.f/255.f) blue:(248.f/255.f) alpha:1]];
                [self.allBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
                [self.activeBtn setBackgroundColor:[UIColor clearColor]];
                [self.activeBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1] forState: UIControlStateNormal];
                [self.downBtn setBackgroundColor:[UIColor clearColor]];
                [self.downBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1] forState: UIControlStateNormal];
                _filteredServers = _servers;
            }
                break;
            case 2:{
                [self.allBtn setBackgroundColor:[UIColor clearColor]];
                [self.allBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1] forState: UIControlStateNormal];
                [self.activeBtn setBackgroundColor:[UIColor colorWithRed:(73.f/255.f) green:(165.f/255.f) blue:(248.f/255.f) alpha:1]];
                [self.activeBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
                [self.downBtn setBackgroundColor:[UIColor clearColor]];
                [self.downBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1] forState: UIControlStateNormal];
                NSPredicate *filterActive = [NSPredicate predicateWithFormat:@"SELF.status.id.intValue = 1"];
                [tempServers filterUsingPredicate:filterActive];
                _filteredServers = tempServers;
                break;
            }
            case 3:{
                [self.allBtn setBackgroundColor:[UIColor clearColor]];
                [self.allBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1]forState: UIControlStateNormal];
                [self.activeBtn setBackgroundColor:[UIColor clearColor]];
                [self.activeBtn setTitleColor:[UIColor colorWithRed:(195.f/255.f) green:(195.f/255.f) blue:(195.f/255.f) alpha:1] forState: UIControlStateNormal];
                [self.downBtn setBackgroundColor:[UIColor colorWithRed:(73.f/255.f) green:(165.f/255.f) blue:(248.f/255.f) alpha:1]];
                [self.downBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
                NSPredicate *filterDown = [NSPredicate predicateWithFormat:@"SELF.status.id.intValue > 3"];
                [tempServers filterUsingPredicate:filterDown];
                _filteredServers = tempServers;
            }
                break;
            default:
                break;
        }
        
    } @catch (NSException *exception) {
        [SVProgressHUD showErrorWithStatus:exception.description];
    } @finally {
        [self.tableView reloadData];

    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    @try {
        if ([allTrim( searchText ) length] != 0) {
            NSPredicate *namesStartingWithK = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF.name CONTAINS[c] '%@'",searchText]];
            
            tempServers = [self.servers mutableCopy];
            [tempServers filterUsingPredicate:namesStartingWithK];
            _filteredServers = tempServers;
            
        }else{
            _filteredServers = _servers;
        }

    } @catch (NSException *exception) {
        [SVProgressHUD showErrorWithStatus:exception.description];
    } @finally {
        [self.tableView reloadData];

    }
}

@end
