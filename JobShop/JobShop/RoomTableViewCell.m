//
//  RoomTableViewCell.m
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "RoomTableViewCell.h"

@implementation RoomTableViewCell
@synthesize image;
@synthesize tableLabel;
@synthesize tableNo;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
