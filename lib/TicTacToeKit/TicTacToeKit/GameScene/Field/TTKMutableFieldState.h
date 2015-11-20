//
//  TTKMutableFieldState.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TicTacToeKit/Types/TTKCellPoint.h>

@protocol TTKMutableFieldState <NSObject>

-(void)takeField:(struct TTKCellPoint)cellPosition
             byX:(BOOL)isX_Or_O;

@end
