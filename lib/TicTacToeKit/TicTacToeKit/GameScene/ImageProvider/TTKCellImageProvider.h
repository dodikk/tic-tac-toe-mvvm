//
//  TTKCellImageProvider.h
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 22/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@protocol TTKCellImageProvider <NSObject>

-(UIImage*)imageForEmptyCell;
-(UIImage*)imageForCellTakenByX;
-(UIImage*)imageForCellTakenByO;

@end
