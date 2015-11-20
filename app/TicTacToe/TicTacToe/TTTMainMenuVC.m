//
//  ViewController.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTMainMenuVC.h"

@interface TTTMainMenuVC ()

@property (nonatomic, weak) IBOutlet UIButton* firstPlayerButton;
@property (nonatomic, weak) IBOutlet UIButton* secondPlayerButton;

@end

@implementation TTTMainMenuVC



-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions
-(IBAction)onFirstPlayerButtonTapped:(id)sender
{
    NSAssert(NO, @"not implemented");
}

-(IBAction)secondPlayerButtonTapped:(id)sender
{
    NSAssert(NO, @"not implemented");
}

@end
