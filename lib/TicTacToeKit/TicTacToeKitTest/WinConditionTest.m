//
//  WinConditionTest.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "TTKMatrixFieldModel.h"
#import "TTKMatrixFieldModel+UnitTest.h"


@interface WinConditionTest : XCTestCase
@end

@implementation WinConditionTest
{
    TTKMatrixFieldModel* _field;
}


-(void)setUp
{
    [super setUp];

    self->_field = [TTKMatrixFieldModel new];
}

-(void)tearDown
{
    self->_field = nil;
    [super tearDown];
}

-(void)testXWinsByCompletingRow
{
    

}

@end
