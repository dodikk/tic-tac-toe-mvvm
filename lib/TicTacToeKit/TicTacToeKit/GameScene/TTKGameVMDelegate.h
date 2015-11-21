//
//  TTKGameVMDelegate.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/Types/TTKCellPoint.h>

@protocol TTKGameVM;

@protocol TTKGameVMDelegate <NSObject>

-(void)viewModelDidDetectGameOver:(id<TTKGameVM>)viewModel;

-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition;

-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition;

@end
