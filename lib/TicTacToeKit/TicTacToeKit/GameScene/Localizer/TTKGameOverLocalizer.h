//
//  TTKGameOverLocalizer.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTKGameOverLocalizer <NSObject>

-(NSString*)xPlayerWinsMessage;
-(NSString*)oPlayerWinsMessage;
-(NSString*)drawMessage;

@end
