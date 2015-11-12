//
//  ViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/12.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Product_1;
@synthesize Product_2;
@synthesize Product_3;
@synthesize Product_4;
@synthesize Worker_A;
@synthesize Worker_B;
@synthesize Worker_C;
@synthesize Worker_D;
@synthesize dragImage;
@synthesize dragObject;
@synthesize touchOffset;
@synthesize homePosition;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches count] == 1) {
        
        // one finger
        CGPoint touchPoint = [[touches anyObject]locationInView:self.view];
        if (touchPoint.x > Product_1.frame.origin.x &&
            touchPoint.x < Product_1.frame.origin.x +
            Product_1.frame.size.width &&
            touchPoint.y > Product_1.frame.origin.y &&
            touchPoint.y < Product_1.frame.origin.y +
            Product_1.frame.size.height)
        {
            self.dragImage = Product_1;
            self.dragObject = @"1";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_1.frame.origin.x,
                                           touchPoint.y - Product_1.frame.origin.y);
            self.homePosition = CGPointMake(Product_1.frame.origin.x,
                                            Product_1.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_2.frame.origin.x &&
            touchPoint.x < Product_2.frame.origin.x +
            Product_2.frame.size.width &&
            touchPoint.y > Product_2.frame.origin.y &&
            touchPoint.y < Product_2.frame.origin.y +
            Product_2.frame.size.height)
        {
            self.dragImage = Product_2;
            self.dragObject = @"2";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_2.frame.origin.x,
                                           touchPoint.y - Product_2.frame.origin.y);
            self.homePosition = CGPointMake(Product_2.frame.origin.x,
                                            Product_2.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_3.frame.origin.x &&
            touchPoint.x < Product_3.frame.origin.x +
            Product_3.frame.size.width &&
            touchPoint.y > Product_3.frame.origin.y &&
            touchPoint.y < Product_3.frame.origin.y +
            Product_3.frame.size.height)
        {
            self.dragImage = Product_3;
            self.dragObject = @"3";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_3.frame.origin.x,
                                           touchPoint.y - Product_3.frame.origin.y);
            self.homePosition = CGPointMake(Product_3.frame.origin.x,
                                            Product_3.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_4.frame.origin.x &&
            touchPoint.x < Product_4.frame.origin.x +
            Product_4.frame.size.width &&
            touchPoint.y > Product_4.frame.origin.y &&
            touchPoint.y < Product_4.frame.origin.y +
            Product_4.frame.size.height)
        {
            self.dragImage = Product_4;
            self.dragObject = @"4";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_4.frame.origin.x,
                                           touchPoint.y - Product_4.frame.origin.y);
            self.homePosition = CGPointMake(Product_4.frame.origin.x,
                                            Product_4.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        //NSLog(self.dragObject);
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject]
                          locationInView:self.view];
    CGRect newDragObjectFrame = CGRectMake(touchPoint.x -
                                           touchOffset.x,
                                           touchPoint.y - touchOffset.y,
                                           self.dragImage.frame.size.width,
                                           self.dragImage.frame.size.height);
    self.dragImage.frame = newDragObjectFrame;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject]
                          locationInView:self.view];
    if (touchPoint.x > self.Worker_A.frame.origin.x &&
        touchPoint.x < self.Worker_A.frame.origin.x +
        self.Worker_A.frame.size.width &&
        touchPoint.y > self.Worker_A.frame.origin.y &&
        touchPoint.y < self.Worker_A.frame.origin.y +
        self.Worker_A.frame.size.height )
    {
        if([self.dragObject isEqualToString:@"1"]){
            int count1 = [self.Worker_A.l1.text intValue];
            count1 += 1;
            self.Worker_A.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"2"]){
            int count2 = [self.Worker_A.l2.text intValue];
            count2 += 1;
            self.Worker_A.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"3"]){
            int count3 = [self.Worker_A.l3.text intValue];
            count3 += 1;
            self.Worker_A.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"4"]){
            int count4 = [self.Worker_A.l4.text intValue];
            count4 += 1;
            self.Worker_A.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }
    
    if (touchPoint.x > self.Worker_B.frame.origin.x &&
        touchPoint.x < self.Worker_B.frame.origin.x +
        self.Worker_B.frame.size.width &&
        touchPoint.y > self.Worker_B.frame.origin.y &&
        touchPoint.y < self.Worker_B.frame.origin.y +
        self.Worker_B.frame.size.height )
    {
        if([self.dragObject isEqualToString:@"1"]){
            int count1 = [self.Worker_B.l1.text intValue];
            count1 += 1;
            self.Worker_B.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"2"]){
            int count2 = [self.Worker_B.l2.text intValue];
            count2 += 1;
            self.Worker_B.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"3"]){
            int count3 = [self.Worker_B.l3.text intValue];
            count3 += 1;
            self.Worker_B.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"4"]){
            int count4 = [self.Worker_B.l4.text intValue];
            count4 += 1;
            self.Worker_B.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }
    
    if (touchPoint.x > self.Worker_C.frame.origin.x &&
        touchPoint.x < self.Worker_C.frame.origin.x +
        self.Worker_C.frame.size.width &&
        touchPoint.y > self.Worker_C.frame.origin.y &&
        touchPoint.y < self.Worker_C.frame.origin.y +
        self.Worker_C.frame.size.height )
    {
        if([self.dragObject isEqualToString:@"1"]){
            int count1 = [self.Worker_C.l1.text intValue];
            count1 += 1;
            self.Worker_C.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"2"]){
            int count2 = [self.Worker_C.l2.text intValue];
            count2 += 1;
            self.Worker_C.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"3"]){
            int count3 = [self.Worker_C.l3.text intValue];
            count3 += 1;
            self.Worker_C.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"4"]){
            int count4 = [self.Worker_C.l4.text intValue];
            count4 += 1;
            self.Worker_C.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }

    if (touchPoint.x > self.Worker_D.frame.origin.x &&
        touchPoint.x < self.Worker_D.frame.origin.x +
        self.Worker_D.frame.size.width &&
        touchPoint.y > self.Worker_D.frame.origin.y &&
        touchPoint.y < self.Worker_D.frame.origin.y +
        self.Worker_D.frame.size.height )
    {
        if([self.dragObject isEqualToString:@"1"]){
            int count1 = [self.Worker_D.l1.text intValue];
            count1 += 1;
            self.Worker_D.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"2"]){
            int count2 = [self.Worker_D.l2.text intValue];
            count2 += 1;
            self.Worker_D.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"3"]){
            int count3 = [self.Worker_D.l3.text intValue];
            count3 += 1;
            self.Worker_D.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"4"]){
            int count4 = [self.Worker_D.l4.text intValue];
            count4 += 1;
            self.Worker_D.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }

    
    self.dragImage.frame = CGRectMake(self.homePosition.x,
                                       self.homePosition.y,
                                       self.dragImage.frame.size.width,
                                       self.dragImage.frame.size.height);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
