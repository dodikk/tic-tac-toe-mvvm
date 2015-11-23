//
//  TTKPlayer.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@protocol TTKPlayer <NSObject>

-(NSString*)playerName;

-(BOOL)isPlayerX;
-(BOOL)isPlayerO;
-(UIImage*)imageForPosessedCell;

@end
