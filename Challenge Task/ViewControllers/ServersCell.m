//
//  ServersCell.m
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import "ServersCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ServersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.cellView.layer.masksToBounds = NO;
    self.cellView.layer.shadowOffset = CGSizeMake(1, 0);
    self.cellView.layer.shadowRadius = 1;
    self.cellView.layer.shadowOpacity = 0.2;
    self.circleImage.layer.cornerRadius = self.circleImage.frame.size.width / 2;
    self.circleImage.layer.masksToBounds = YES;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ServersCell" owner:nil options:nil]
                lastObject];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (IBAction)checkButton:(id)sender {
    [self.delegate didTappedCheckInButtonAtCell:self];
}

- (IBAction)phoneClicked:(id)sender {
    [self.delegate didTappedPhoneButtonAtCell:self];
}

- (IBAction)timerClicked:(id)sender {
    [self.delegate didTappedAlarmButtonAtCell:self];
}


- (IBAction)muteClicekd:(id)sender {
    [self.delegate didTappedMuteButtonAtCell:self];
}
@end
