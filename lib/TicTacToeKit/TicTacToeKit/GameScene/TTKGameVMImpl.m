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
#import "TTKGameOverLocalizer.h"
#import "TTKCellImageProvider.h"


@implementation TTKGameVMImpl
{
    id<TTKFieldState, TTKMutableFieldState> _fieldModel;
    id<TTKGameOverLocalizer> _localizer;
    id<TTKCellImageProvider> _imageProvider;
    BOOL _isFirstTurnForPlayerX;
    
    
    NSUInteger _indexOfActivePlayer;
}


@dynamic activePlayer;
@dynamic gameOverMessage;
@dynamic turnIndicatorMessage;
@dynamic isShareButtonsVisible;
@dynamic socialMessage;


-(id<TTKPlayer>)activePlayer
{
    return self->_players[self->_indexOfActivePlayer];
}

-(instancetype)initWithField:(id<TTKFieldState, TTKMutableFieldState>)fieldModel
                     xPlayer:(BOOL)isPlayerXSelectedFromMenu
                   localizer:(id<TTKGameOverLocalizer>)localizer
               imageProvider:(id<TTKCellImageProvider>)imageProvider
{
    NSParameterAssert(nil != fieldModel   );
    NSParameterAssert(nil != localizer    );
    NSParameterAssert(nil != imageProvider);
    
    self = [super init];
    if (nil == self)
    {
        return nil;
    }
    
    self->_fieldModel = fieldModel;
    self->_localizer = localizer;
    self->_imageProvider = imageProvider;
    
    
    self->_isFirstTurnForPlayerX = isPlayerXSelectedFromMenu;
    [self setupPlayers];
    
    
    return self;
}

-(void)setupPlayers
{
    self->_indexOfActivePlayer = 0;
    
    TTKPlayerPOD* playerX = [TTKPlayerPOD new];
    {
        playerX.playerName = self->_localizer.xPlayerName;
        playerX.isPlayerX = YES;
        playerX.isPlayerO = NO;
        playerX.imageForPosessedCell = [self->_imageProvider imageForCellTakenByX];
    }

    TTKPlayerPOD* playerO = [TTKPlayerPOD new];
    {
        playerO.playerName = self->_localizer.oPlayerName;
        playerO.isPlayerX = NO;
        playerO.isPlayerO = YES;
        playerO.imageForPosessedCell = [self->_imageProvider imageForCellTakenByO];
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

#pragma mark - Game flow
-(void)view:(id)view
didTapOnCell:(struct TTKCellPoint)cellPosition
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    if ([self->_fieldModel isGameOver])
    {
        [strongDelegate viewModel: self
          didTapCellAfterGameOver: cellPosition];
        
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
    [self updateFieldAndNotify: cellPosition];
    [self transferTurnAndNotify];
    [self checkGameOverAndNotify];
}

-(void)updateFieldAndNotify:(struct TTKCellPoint)cellPosition
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    BOOL isTurnOfX = [self.activePlayer isPlayerX];
    [self->_fieldModel takeField: cellPosition
                             byX: isTurnOfX];
    
    [strongDelegate viewModel: self
           didChangeCellState: cellPosition];
}

-(void)transferTurnAndNotify
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    [self invertActiveIndex];
    [strongDelegate viewModelDidTransferTurn: self];
}

-(void)checkGameOverAndNotify
{
    id<TTKGameVMDelegate> strongDelegate = self.vcDelegate;
    
    if ([self->_fieldModel isGameOver])
    {
        [strongDelegate viewModelDidDetectGameOver: self];
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
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wgnu-zero-variadic-macro-arguments"
        NSAssert(NO, @"[TTKGameVMImpl] Player index exceeded");
        #pragma clang diagnostic pop
    }
}


#pragma mark - Game state utils
-(NSString*)gameOverMessage
{
    if (![self->_fieldModel isGameOver])
    {
        return nil;
    }
    else if ([self->_fieldModel isDraw])
    {
        return [self->_localizer drawMessage];
    }
    else if ([self->_fieldModel isWinnerPlayerX])
    {
        return [self->_localizer xPlayerWinsMessage];
    }
    else
    {
        return [self->_localizer oPlayerWinsMessage];
    }
}

-(UIImage*)imageForCell:(struct TTKCellPoint)cellPosition
{
    if ([self->_fieldModel isFieldEmpty: cellPosition])
    {
        return [self->_imageProvider imageForEmptyCell];
    }
    else if ([self->_fieldModel isFieldTakenByX: cellPosition])
    {
        return [self->_imageProvider imageForCellTakenByX];
    }
    else
    {
        return [self->_imageProvider imageForCellTakenByO];
    }
}

-(NSString*)turnIndicatorMessage
{
    if ([self->_fieldModel isGameOver])
    {
        return self.gameOverMessage;
    }
    
    NSString* messageFormat = [self->_localizer turnMessageFormat];
    NSString* result = [NSString stringWithFormat: messageFormat, self.activePlayer.playerName];
    
    return result;
}

#pragma mark - Social
-(BOOL)isFirstUserWins
{
    BOOL isXWinsAndSelected =  self->_isFirstTurnForPlayerX && [self->_fieldModel isWinnerPlayerX];
    BOOL isOWinsAndSelected = !self->_isFirstTurnForPlayerX && [self->_fieldModel isWinnerPlayerO];
    
    return isXWinsAndSelected || isOWinsAndSelected;
}

-(BOOL)isShareButtonsVisible
{
    if (![self->_fieldModel isGameOver])
    {
        return NO;
    }

    return YES;
//    return [self isFirstUserWins];
}

-(NSString*)socialMessage
{
    if (![self->_fieldModel isGameOver])
    {
        return nil;
    }
    else if ([self->_fieldModel isDraw])
    {
        return [self->_localizer socialMessageDraw];
    }
    
    BOOL isXWinsAndSelected =  self->_isFirstTurnForPlayerX && [self->_fieldModel isWinnerPlayerX];
    
    BOOL isOWinsAndSelected = !self->_isFirstTurnForPlayerX && [self->_fieldModel isWinnerPlayerO];

    
    if (isXWinsAndSelected || isOWinsAndSelected)
    {
        return [self->_localizer socialMessageWin];
    }
    else
    {
        return [self->_localizer socialMessageLoose];
    }
}

@end
