//
//  WorkerUIView.h
//  JobShop
//
//  Created by 何文戟 on 15/11/12.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkerUIView : UIView
@property(nonatomic,strong)IBOutlet UIImageView *logo;
@property(nonatomic,strong)IBOutlet UIView *p1;
@property(nonatomic,strong)IBOutlet UIView *p2;
@property(nonatomic,strong)IBOutlet UIView *p3;
@property(nonatomic,strong)IBOutlet UIView *p4;
@property(nonatomic,strong)IBOutlet UILabel *l1;
@property(nonatomic,strong)IBOutlet UILabel *l2;
@property(nonatomic,strong)IBOutlet UILabel *l3;
@property(nonatomic,strong)IBOutlet UILabel *l4;
@property(nonatomic) int *count1;
@property(nonatomic) int *count2;
@property(nonatomic) int *count3;
@property(nonatomic) int *count4;
@end
