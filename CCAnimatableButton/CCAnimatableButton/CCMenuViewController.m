//
//  CCMenuViewController.m
//  CCAnimatableButton
//
//  Created by 陈 爱彬 on 14-7-16.
//  Copyright (c) 2014年 陈爱彬. All rights reserved.
//

#import "CCMenuViewController.h"
#import "CCAnimatedButton.h"
#import "CCArrowButton.h"

@interface CCMenuViewController ()

@end

@implementation CCMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:57.0/255.0 green:135.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    CCAnimatedButton *button = [[CCAnimatedButton alloc] initWithFrame:CGRectMake(100, 80, 50, 40)];
//    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    CCArrowButton *arrowButton = [[CCArrowButton alloc] initWithFrame:CGRectMake(100, 180, 40, 40)];
//    arrowButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:arrowButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
