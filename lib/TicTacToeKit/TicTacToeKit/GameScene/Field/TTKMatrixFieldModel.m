//
//  TTKMatrixFieldModel.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKMatrixFieldModel.h"

typedef signed char CellState_t;

static const CellState_t FIELD_EMPTY =  0;
static const CellState_t FIELD_X     =  1;
static const CellState_t FIELD_O     = -1;

static const size_t FIELD_SIZE = 3;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu-folding-constant"
@implementation TTKMatrixFieldModel
{
    CellState_t _cells[FIELD_SIZE][FIELD_SIZE];
}
#pragma clang diagnostic pop


-(instancetype)init
{
    self = [super init];
    [self nullifyCells];
    
    return self;
}

-(void)nullifyCells
{
    for (size_t x = 0; x != FIELD_SIZE; ++x)
        for (size_t y = 0; y != FIELD_SIZE; ++y)
    {
        self->_cells[x][y] = 0;
    }
}

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
    CellState_t rawGameResult = [self rawGameResult];
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
    CellState_t rawGameResult = [self rawGameResult];
    return (0 == rawGameResult);
}

-(BOOL)isWinnerPlayerX
{
    // TODO : reduce loops count by extracting "state" ivar (if needed)
    CellState_t rawGameResult = [self rawGameResult];
    return (rawGameResult > 0);
}

-(CellState_t)rawGameResult
{
    CellState_t rows[3]    = {0};
    CellState_t columns[3] = {0};
    
    CellState_t diagonal  = 0;
    CellState_t rDiagonal = 0;
    
    for (size_t row = 0; row != FIELD_SIZE; ++row)
    {
//        rows[row] =
//            self->_cells[row][0] +
//            self->_cells[row][1] +
//            self->_cells[row][2];
        for (size_t column = 0; column != FIELD_SIZE; ++column)
        {
            rows[row] += self->_cells[row][column];
        }
        

        if ( FIELD_SIZE == abs(rows[row]) )
        {
            return rows[row];
        }
    }
    
    for (size_t column = 0; column != FIELD_SIZE; ++column)
    {
//        columns[column] =
//            self->_cells[0][column] +
//            self->_cells[1][column] +
//            self->_cells[2][column];
        for (size_t row = 0; row != FIELD_SIZE; ++row)
        {
            columns[column] += self->_cells[row][column];
        }
        
        
        if ( FIELD_SIZE == abs(columns[column]) )
        {
            return columns[column];
        }
    }


//    diagonal  =
//        self->_cells[0][0] +
//        self->_cells[1][1] +
//        self->_cells[2][2];
    for (size_t diagonalIndex = 0; diagonalIndex != FIELD_SIZE; ++diagonalIndex)
    {
        diagonal += self->_cells[diagonalIndex][diagonalIndex];
    }
    if (FIELD_SIZE == abs(diagonal))
    {
        return diagonal;
    }
    
    
//    rDiagonal =
//        self->_cells[2][0] +
//        self->_cells[1][1] +
//        self->_cells[0][2];
    for (size_t diagonalIndex = 0; diagonalIndex != FIELD_SIZE; ++diagonalIndex)
    {
        rDiagonal += self->_cells[FIELD_SIZE - diagonalIndex - 1][diagonalIndex];
    }
    
    if (FIELD_SIZE == abs(rDiagonal))
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
    
    CellState_t value = isX_Or_O ? FIELD_X : FIELD_O;
    self->_cells[cellPosition.row][cellPosition.column] = value;
}

@end
