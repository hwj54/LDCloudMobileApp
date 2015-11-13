//
//  ClassRoomTableViewCell.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassRoomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *image;
@property (strong, nonatomic) IBOutlet UILabel *roomLabel;
@property (nonatomic) NSString *roomNo;
@end
