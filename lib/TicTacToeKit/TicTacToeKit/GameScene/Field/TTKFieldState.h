//
//  TTKFieldState.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/Types/TTKCellPoint.h>

@protocol TTKPlayer;


@protocol TTKFieldState <NSObject>

-(BOOL)isFieldEmpty:(struct TTKCellPoint)cellPosition;
-(BOOL)isFieldTakenByX:(struct TTKCellPoint)cellPosition;
-(BOOL)isFieldTakenByY:(struct TTKCellPoint)cellPosition;

-(BOOL)isGameOver;
-(BOOL)isDraw;
-(BOOL)isWinnerPlayerX;
-(BOOL)isWinnerPlayerO;

@end
