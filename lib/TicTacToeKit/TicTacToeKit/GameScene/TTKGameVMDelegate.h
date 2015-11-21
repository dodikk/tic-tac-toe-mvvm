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

/**
 Invoked when the game engine detects the win or loss for one of the players.
 [TTKGameVMDelegate viewModel:didChangeCellState:] must be invoked first.
 */
-(void)viewModelDidDetectGameOver:(id<TTKGameVM>)viewModel;

/**
 The corresponding cell has already been taken.
 Active player has not been changed yet.
 */
-(void)viewModel:(id<TTKGameVM>)viewModel
didChangeCellState:(struct TTKCellPoint)cellPosition;

/**
 The turn has failed. No turn transfer will occur.
 */
-(void)viewModel:(id<TTKGameVM>)viewModel
didTapOnPosessedCell:(struct TTKCellPoint)cellPosition;

@end
