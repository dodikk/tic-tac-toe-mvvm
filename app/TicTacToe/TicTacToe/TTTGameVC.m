//
//  TTTGameVC.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTGameVC.h"

@interface TTTGameVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineOffset;

// TODO : rename later
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightButtonOffset2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upperLineOffset;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLineOffset;

@end

@implementation TTTGameVC
{
}


-(void)setViewModel:(id<TTKGameVM>)viewModel
{
    NSParameterAssert(nil == self->_viewModel);
    
    self->_viewModel = viewModel;
    [viewModel setVcDelegate: self];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupEqualLineSizeConstraints];
}

-(void)setupEqualLineSizeConstraints
{
    // TODO : rewrite declaratively
    
    static const CGFloat lineWidth = 3.f;
    
    CGFloat horizontalOffset = (self.view.frame.size.width - 2.f*lineWidth) / 3.f;
    
    CGFloat verticalOffset = (self.view.frame.size.height - 2.f*lineWidth) / 3.f;
    
    
    self.leftLineOffset.constant = horizontalOffset;
    self.rightButtonOffset2.constant = horizontalOffset;
    
    self.upperLineOffset.constant = verticalOffset;
    self.bottomLineOffset.constant = verticalOffset;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TTKGameVMDelegate
-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition
{
    NSAssert(NO, @"not implemented");
}

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition
{
    NSAssert(NO, @"not implemented");
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
