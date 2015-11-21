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

static const size_t FIELD_SIZE = 3;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-folding-constant"
@implementation TTKMatrixFieldModel
{
    signed char _cells[FIELD_SIZE][FIELD_SIZE];
}
#pragma clang diagnostic pop


#pragma mark - TTKFieldState
-(BOOL)isFieldEmpty:(struct TTKCellPoint)cellPosition
{
    // TODO : assert range if needed
    return (FIELD_EMPTY == self->_cells[cellPosition.row][cellPosition.column]);
}

-(BOOL)isFieldTakenByX:(struct TTKCellPoint)cellPosition
{
    return (FIELD_X == self->_cells[cellPosition.row][cellPosition.column]);
}

-(BOOL)isFieldTakenByY:(struct TTKCellPoint)cellPosition
{
    return (FIELD_O == self->_cells[cellPosition.row][cellPosition.column]);
}

-(BOOL)isGameOver
{
    // TODO : reduce loops count by extracting "state" ivar (if needed)
    signed char rawGameResult = [self rawGameResult];
    if (0 != rawGameResult)
    {
        return YES;
    }

    return [self isAllFieldsPosessed];
}

-(BOOL)isDraw
{
    if (![self isAllFieldsPosessed])
    {
        return NO;
    }
    
    // TODO : reduce loops count by extracting "state" ivar (if needed)
    signed char rawGameResult = [self rawGameResult];
    return (0 == rawGameResult);
}

-(BOOL)isWinnerPlayerX
{
    // TODO : reduce loops count by extracting "state" ivar (if needed)
    signed char rawGameResult = [self rawGameResult];
    return (rawGameResult > 0);
}

-(signed char)rawGameResult
{
    signed char rows[3]    = {0};
    signed char columns[3] = {0};
    
    signed char diagonal  = 0;
    signed char rDiagonal = 0;
    
    for (size_t row = 0; row != FIELD_SIZE; ++row)
    {
        // TODO : remove brute force to accumulate values
        rows[row] = self->_cells[row][0] + self->_cells[row][1] + self->_cells[row][2];
        if ( FIELD_SIZE == abs(rows[row]) )
        {
            return rows[row];
        }
    }
    
    for (size_t column = 0; column != FIELD_SIZE; ++column)
    {
        // TODO : remove brute force to accumulate values
        columns[column] = self->_cells[0][column] + self->_cells[1][column] + self->_cells[2][column];
        if ( FIELD_SIZE == abs(columns[column]) )
        {
            return columns[column];
        }
    }
    
    
    // TODO : remove brute force to accumulate values
    diagonal  = self->_cells[0][0] + self->_cells[1][1] + self->_cells[2][2];
    if (FIELD_SIZE == diagonal)
    {
        return diagonal;
    }
    
    
    // TODO : remove brute force to accumulate values
    rDiagonal = self->_cells[2][0] + self->_cells[1][1] + self->_cells[0][2];
    if (FIELD_SIZE == rDiagonal)
    {
        return rDiagonal;
    }
    
    return 0;
}

-(BOOL)isAllFieldsPosessed
{
    BOOL isEmptyFieldExists = NO;
    
    for (size_t x = 0; x != FIELD_SIZE; ++x)
        for (size_t y = 0; y != FIELD_SIZE; ++y)
    {
        if (FIELD_EMPTY == self->_cells[x][y])
        {
            isEmptyFieldExists = YES;
            break;
        }
    }
    
    return !isEmptyFieldExists;
}

#pragma mark - TTKMutableFieldState
-(void)takeField:(struct TTKCellPoint)cellPosition
             byX:(BOOL)isX_Or_O
{
    NSParameterAssert([self isFieldEmpty: cellPosition]);
    
    signed char value = isX_Or_O ? FIELD_X : FIELD_O;
    self->_cells[cellPosition.row][cellPosition.column] = value;
}

@end
