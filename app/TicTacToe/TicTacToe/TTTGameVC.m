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


// TODO : extract to the model library
// TODO : rename
struct MyCellPoint
{
    unsigned char x;
    unsigned char y;
};

-(void)viewModel:(id)viewModel
didChangeCellState:(struct MyCellPoint)cellPosition
{
    // TODO : set a proper image
}

#pragma mark - row0
-(IBAction)onButton00Tapped:(id)sender {
    
    struct MyCellPoint cellPosition = {0, 0};
    [self.viewModel didTapOnCell: cellPosition];
}

-(IBAction)onButton01Tapped:(id)sender {
}

-(IBAction)onButton02Tapped:(id)sender {
}

#pragma mark - row1
- (IBAction)onButton10Tapped:(id)sender {
}
- (IBAction)onButton11Tapped:(id)sender {
}
- (IBAction)onButton12Tapped:(id)sender {
}

@end
