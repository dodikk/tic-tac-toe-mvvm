//
//  TTTDefautCellTheme.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTDefautCellTheme.h"

@implementation TTTDefautCellTheme

-(UIImage*)imageForEmptyCell
{
    return nil;
}

-(UIImage*)imageForCellTakenByX
{
    return [UIImage imageNamed: @"x-mark"];
}

-(UIImage*)imageForCellTakenByO
{
    return [UIImage imageNamed: @"o-mark"];
}

@end
