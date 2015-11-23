//
//  MainMenuLocalizer.m
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import "TTTMainMenuLocalizer.h"

@implementation TTTMainMenuLocalizer

-(NSString*)xPlayerWinsMessage
{
    return NSLocalizedString(@"GAME_OVER__PLAYER_X", nil);
}

-(NSString*)oPlayerWinsMessage
{
    return NSLocalizedString(@"GAME_OVER__PLAYER_O", nil);
}

-(NSString*)drawMessage
{
    return NSLocalizedString(@"GAME_OVER__DRAW", nil);
}

-(NSString*)turnMessageFormat
{
    return NSLocalizedString(@"TURN_MESSAGE_FORMAT", nil);
}

-(NSString*)xPlayerName
{
    return NSLocalizedString(@"PLAYER_X__NAME", nil);
}

-(NSString*)oPlayerName
{
    return NSLocalizedString(@"PLAYER_O__NAME", nil);
}

-(NSString*)socialMessageWin
{
    return NSLocalizedString(@"SOCIAL_WIN", nil);
}

-(NSString*)socialMessageLoose
{
    return NSLocalizedString(@"SOCIAL_LOOSE", nil);
}

-(NSString*)socialMessageDraw
{
    return NSLocalizedString(@"SOCIAL_DRAW", nil);
}


@end
