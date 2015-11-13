//
//  ChoiceRoleViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "ChoiceRoleViewController.h"
#import "ViewController.h"
#import "WorkerTableViewController.h"

@interface ChoiceRoleViewController (){
    NSString *target;
}

@end

@implementation ChoiceRoleViewController
@synthesize userAccount;
//@synthesize boss;
//@synthesize workerA;
//@synthesize workerB;
//@synthesize workerC;
//@synthesize workerD;
//@synthesize userAccount;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)boss:(id)sender{
    target = @"boss";
    [self performSegueWithIdentifier:@"gotoBoss" sender:self];
}

-(IBAction)workerA:(id)sender{
    target = @"A";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerB:(id)sender{
    target = @"B";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerC:(id)sender{
    target = @"C";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerD:(id)sender{
    target = @"D";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    userAccount.role = target;
    if([target isEqualToString:@"boss"]){
        ViewController *targetScene = segue.destinationViewController;
        [targetScene setValue:userAccount forKey:@"userAccount"];
    }else{
        WorkerTableViewController *targetScene = segue.destinationViewController;
        [targetScene setValue:userAccount forKey:@"userAccount"];
        [targetScene setValue:userAccount.role forKey:@"role"];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
