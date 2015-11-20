//
//  TTTGameVC.h
//  TicTacToe
//
//  Created by Oleksandr Dodatko on 20/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TicTacToeKit/TicTacToeKit.h>

@protocol TTKGameVM;


@interface TTTGameVC : UIViewController<TTKGameVMDelegate>

/**
 Write-once property
 */
@property (nonatomic) id<TTKGameVM> viewModel;

@end
