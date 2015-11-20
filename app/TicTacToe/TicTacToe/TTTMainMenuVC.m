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
    
    [self cleanupStoryboardStubs];
    [self setupColours];
}

-(void)setupColours
{
    id<TTTMenuTheme> theme = [[TTTColorThemeBuilder currentTheme] menuTheme];
}

-(void)setupLocalizations
{
    
}

-(void)cleanupStoryboardStubs
{
    self.view              .backgroundColor = [UIColor clearColor];
    self.firstPlayerButton .backgroundColor = [UIColor clearColor];
    self.secondPlayerButton.backgroundColor = [UIColor clearColor];
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
