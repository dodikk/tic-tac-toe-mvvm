//
//  TTKGameVMImpl.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKGameVMImpl.h"

@implementation TTKGameVMImpl
{
    id<TTKFieldState, TTKMutableFieldState> _fieldModel;
    BOOL _isFirstTurnForPlayerX;
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
    NSAssert(NO, @"not implemented");
}

#pragma mark - TTKGameVM
-(void)view:(id)view
didTapOnCell:(struct TTKCellPoint)cellPosition
{
    NSAssert(NO, @"not implemented");
}

@end
