//
//  TTKNilImageProvider.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKNilImageProvider.h"

@implementation TTKNilImageProvider

-(UIImage*)imageForEmptyCell
{
    return nil;
}

-(UIImage*)imageForCellTakenByX
{
    return nil;
}

-(UIImage*)imageForCellTakenByO
{
    return nil;
}

@end
