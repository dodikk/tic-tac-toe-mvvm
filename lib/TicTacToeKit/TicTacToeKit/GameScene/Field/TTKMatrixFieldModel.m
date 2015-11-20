//
//  TTKMatrixFieldModel.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKMatrixFieldModel.h"

static const signed char FIELD_EMPTY =  0;
static const signed char FIELD_X     =  1;
static const signed char FIELD_O     = -1;

@implementation TTKMatrixFieldModel
{
    signed char _cells[3][3];
}

#pragma mark - TTKFieldState
-(BOOL)isFieldEmpty:(struct TTKCellPoint)cellPosition
{
    // TODO : assert range if needed
    return (FIELD_EMPTY == self->_cells[cellPosition.x][cellPosition.y]);
}

-(BOOL)isFieldTakenByX:(struct TTKCellPoint)cellPosition
{
    return (FIELD_X == self->_cells[cellPosition.x][cellPosition.y]);
}

-(BOOL)isFieldTakenByY:(struct TTKCellPoint)cellPosition
{
    return (FIELD_O == self->_cells[cellPosition.x][cellPosition.y]);
}

-(void)takeField:(struct TTKCellPoint)cellPosition
             byX:(BOOL)isX_Or_O
{
    NSParameterAssert([self isFieldEmpty: cellPosition]);
    
    signed char value = isX_Or_O ? FIELD_X : FIELD_O;
    self->_cells[cellPosition.x][cellPosition.y] = value;
}

@end
