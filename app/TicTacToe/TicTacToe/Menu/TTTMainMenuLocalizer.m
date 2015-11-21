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

@end
