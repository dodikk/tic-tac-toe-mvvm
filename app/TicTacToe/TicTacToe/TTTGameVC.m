//
//  TTTGameVC.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTGameVC.h"

@interface TTTGameVC ()

@property (weak, nonatomic) IBOutlet UIButton* cell00;
@property (weak, nonatomic) IBOutlet UIButton* cell01;
@property (weak, nonatomic) IBOutlet UIButton* cell02;
@property (weak, nonatomic) IBOutlet UIButton* cell10;
@property (weak, nonatomic) IBOutlet UIButton* cell11;
@property (weak, nonatomic) IBOutlet UIButton* cell12;
@property (weak, nonatomic) IBOutlet UIButton* cell20;
@property (weak, nonatomic) IBOutlet UIButton* cell21;
@property (weak, nonatomic) IBOutlet UIButton* cell22;

@property (weak, nonatomic) IBOutlet UILabel* turnIndicator;

@end

@implementation TTTGameVC
{
    NSArray* _buttonRows;
}


-(void)setViewModel:(id<TTKGameVM>)viewModel
{
    NSParameterAssert(nil == self->_viewModel);
    
    self->_viewModel = viewModel;
    [viewModel setVcDelegate: self];
}

-(void)viewDidLoad
{
    NSParameterAssert(nil != self.viewModel);
    
    [super viewDidLoad];
    
    [self setupButtonGrid];
    [self cleanupStoryboardStubs];
    [self updateTurnIndicator];
}

-(void)setupButtonGrid
{
    self->_buttonRows =
    @[
      @[self.cell00, self.cell01, self.cell02],
      @[self.cell10, self.cell11, self.cell12],
      @[self.cell20, self.cell21, self.cell22]
    ];
}

-(void)cleanupStoryboardStubs
{
    for (NSArray* row in self->_buttonRows)
    {
        for (UIButton* button in row)
        {
            button.backgroundColor = [UIColor clearColor];
            [button setTitle: @""
                    forState: UIControlStateNormal];
        }
    }
}

-(void)navigateToMainMenu
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}


-(void)updateTurnIndicator
{
    self.turnIndicator.text = [self.viewModel turnIndicatorMessage];
}

#pragma mark - TTKGameVMDelegate
-(void)viewModelDidDetectGameOver:(id<TTKGameVM>)viewModel
{
    __weak TTTGameVC* weakSelf = self;
    
    NSString* message = [self.viewModel gameOverMessage];
    
    UIAlertControllerButtonHandler onOkTapped = ^void(UIAlertAction *action)
    {
        TTTGameVC* strongSelf = weakSelf;
        [strongSelf navigateToMainMenu];
    };

    
    UIAlertController* alert = [TTTAlertHelper gameOverMessage: message
                                            withButtonCallback: onOkTapped];
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition
{
    UIButton* button = self->_buttonRows[cellPosition.row][cellPosition.column];
    UIImage* image = [self.viewModel imageForCell: cellPosition];
    
    [button setImage: image
            forState: UIControlStateNormal];
    
    [self updateTurnIndicator];
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition
{
    UIAlertControllerButtonHandler onOkTapped = ^void(UIAlertAction *action)
    {
        // IDLE
    };
    
    NSString* message = NSLocalizedString(@"BAD_TURN__POSESSED_FIELD", nil);
    
    UIAlertController* alert = [TTTAlertHelper badTurnMessage: message
                                           withButtonCallback: onOkTapped];
    
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapCellAfterGameOver:(struct TTKCellPoint)cellPosition
{
    UIAlertControllerButtonHandler onOkTapped = ^void(UIAlertAction *action)
    {
        // IDLE
    };
    
    NSString* message = NSLocalizedString(@"BAD_TURN__AFTER_GAME_OVER", nil);
    
    UIAlertController* alert = [TTTAlertHelper badTurnMessage: message
                                           withButtonCallback: onOkTapped];
    
    [self presentViewController: alert
                       animated: YES
                     completion: nil];
}

#pragma mark - row0
-(IBAction)onButton00Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {0, 0};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton01Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {0, 1};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton02Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {0, 2};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

#pragma mark - row1
-(IBAction)onButton10Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {1, 0};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton11Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {1, 1};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton12Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {1, 2};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

#pragma mark - row2
-(IBAction)onButton20Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {2, 0};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton21Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {2, 1};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

-(IBAction)onButton22Tapped:(id)sender
{
    static const struct TTKCellPoint cellPosition = {2, 2};
    
    [self.viewModel view: self
            didTapOnCell: cellPosition];
}

@end
