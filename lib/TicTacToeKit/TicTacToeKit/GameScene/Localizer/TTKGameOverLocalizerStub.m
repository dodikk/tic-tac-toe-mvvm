//
//  TTKGameOverLocalizerStub.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTKGameOverLocalizerStub.h"

@implementation TTKGameOverLocalizerStub

-(NSString*)xPlayerWinsMessage
{
    return @"X wins";
}

-(NSString*)oPlayerWinsMessage
{
    return @"O wins";
}

-(NSString*)drawMessage
{
    return @"A draw";
}

-(NSString*)turnMessageFormat
{
    return @"Turn of player %@";
}

-(NSString*)xPlayerName
{
    return @"X";
}

-(NSString*)oPlayerName
{
    return @"O";
}

-(NSString*)socialMessageWin
{
    return @"I have won a tic-tac-toe game";
}

-(NSString*)socialMessageLoose
{
    return @"I have lost a tic-tac-toe game";
}

-(NSString*)socialMessageDraw
{
    return @"I have a draw in a tic-tac-toe game";
}

@end

