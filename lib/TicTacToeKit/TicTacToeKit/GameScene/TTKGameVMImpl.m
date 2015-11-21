//
//  TTKGameVMImpl.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKGameVMImpl.h"
#import "TTKGameVMDelegate.h"

#import "TTKPlayerPOD.h"
#import "TTKFieldState.h"
#import "TTKMutableFieldState.h"


@implementation TTKGameVMImpl
{
    id<TTKFieldState, TTKMutableFieldState> _fieldModel;
    BOOL _isFirstTurnForPlayerX;
    
    NSUInteger _indexOfActivePlayer;
}


@dynamic activePlayer;

-(id<TTKPlayer>)activePlayer
{
    return self->_players[self->_indexOfActivePlayer];
}

-(instancetype)initWithField:(id<TTKFieldState, TTKMutableFieldState>)fieldModel
                     xPlayer:(BOOL)isPlayerXSelectedFromMenu
{
    self = [super init];
    if (nil == self)
    {
        return nil;
    }
    
    self->_fieldModel = fieldModel;
    self->_isFirstTurnForPlayerX = isPlayerXSelectedFromMenu;
    [self setupPlayers];
    
    
    return self;
}

-(void)setupPlayers
{
    self->_indexOfActivePlayer = 0;
    
    TTKPlayerPOD* playerX = [TTKPlayerPOD new];
    {
        playerX.isPlayerX = YES;
        playerX.isPlayerO = NO;
        
         // TODO : inject images
        playerX.imageForPosessedCell = nil;
    }

    TTKPlayerPOD* playerO = [TTKPlayerPOD new];
    {
        playerO.isPlayerX = NO;
        playerO.isPlayerO = YES;
        
        // TODO : inject images
        playerO.imageForPosessedCell = nil;
    }
    
    
    if (self->_isFirstTurnForPlayerX)
    {
        self->_players = @[playerX, playerO];
    }
    else
    {
        self->_players = @[playerO, playerX];
    }
}

#pragma mark - TTKGameVM
-(void)view:(id)view
didTapOnCell:(struct TTKCellPoint)cellPosition
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    if ([self->_fieldModel isGameOver])
    {
        [strongDelegate viewModelDidDetectGameOver: self];
        return;
    }
    else if (![self->_fieldModel isFieldEmpty: cellPosition])
    {
        [strongDelegate viewModel: self
             didTapOnPosessedCell: cellPosition];
        
        return;
    }
    else
    {
        [self makeTurnWithCell: cellPosition];
    }
}

-(void)makeTurnWithCell:(struct TTKCellPoint)cellPosition
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    
    BOOL isTurnOfX = [self.activePlayer isPlayerX];
    
    // Order matters
    [self->_fieldModel takeField: cellPosition
                             byX: isTurnOfX];
    
    [strongDelegate viewModel: self
           didChangeCellState: cellPosition];
    
    [self invertActiveIndex];
    
    
    
    if ([self->_fieldModel isGameOver])
    {
        [strongDelegate viewModelDidDetectGameOver: self];
        return;
    }
    
}

-(void)invertActiveIndex
{
    if (0 == self->_indexOfActivePlayer)
    {
        self->_indexOfActivePlayer = 1;
    }
    else if (1 == self->_indexOfActivePlayer)
    {
        self->_indexOfActivePlayer = 0;
    }
    else
    {
        NSAssert(NO, @"[TTKGameVMImpl] Player index exceeded");
    }
}

@end
