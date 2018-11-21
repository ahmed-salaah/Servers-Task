//
//  ServersCell.h
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ServersCell;
@protocol ServersCellDelegate
- (void) didTappedAlarmButtonAtCell:(ServersCell *)cell ;
- (void) didTappedCheckInButtonAtCell:(ServersCell *)cell ;
- (void) didTappedMuteButtonAtCell:(ServersCell *)cell ;
- (void) didTappedPhoneButtonAtCell:(ServersCell *)cell ;
@end

@interface ServersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipLabbel;
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UILabel *ipDomainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *circleImage;
@property (weak, nonatomic) IBOutlet UIImageView *statusImage;
@property (weak, nonatomic) id<ServersCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *muteBtn;
@property (weak, nonatomic) IBOutlet UIButton *timerBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

- (IBAction)checkButton:(id)sender;
- (IBAction)phoneClicked:(id)sender;
- (IBAction)timerClicked:(id)sender;
- (IBAction)muteClicekd:(id)sender;

@end

NS_ASSUME_NONNULL_END
