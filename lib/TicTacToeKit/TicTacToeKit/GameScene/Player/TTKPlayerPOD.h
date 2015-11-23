//
//  TTKPlayerPOD.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTKPlayer.h"

@class UIImage;

@interface TTKPlayerPOD : NSObject<TTKPlayer>

@property (nonatomic) NSString* playerName;

@property (nonatomic) BOOL isPlayerX;
@property (nonatomic) BOOL isPlayerO;
@property (nonatomic) UIImage* imageForPosessedCell;

@end
