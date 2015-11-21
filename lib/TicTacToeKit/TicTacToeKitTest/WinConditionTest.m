//
//  WinConditionTest.m
//  TicTacToeKit
//
//  Created by Oleksandr Dodatko on 21/11/2015.
//  Copyright © 2015 dodikk. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TicTacToeKit/TicTacToeKit.h>
#import "TTKMatrixFieldModel.h"
#import "TTKMatrixFieldModel+UnitTest.h"

#import "TTKCellPoint.h"


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


-(void)testFieldCannotBeTakenTwice
{
    struct TTKCellPoint position = {0, 0};
    [self->_field takeField: position byX: YES];
    
    XCTAssertThrows([self->_field takeField: position byX: YES]);
    XCTAssertThrows([self->_field takeField: position byX: NO ]);
}


// x x x
// 0 - -
// 0 - -
-(void)testFieldAccessors
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: YES];
    
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];

    
    BOOL fieldTest = NO;
    {
        fieldTest = [self->_field isFieldEmpty: (struct TTKCellPoint){1, 1}];
        XCTAssertTrue(fieldTest);
        
        fieldTest = [self->_field isFieldTakenByX: (struct TTKCellPoint){1, 1}];
        XCTAssertFalse(fieldTest);
        
        
        fieldTest = [self->_field isFieldEmpty: (struct TTKCellPoint){0, 0}];
        XCTAssertFalse(fieldTest);
        
        fieldTest = [self->_field isFieldTakenByX: (struct TTKCellPoint){0, 0}];
        XCTAssertTrue(fieldTest);
        
        fieldTest = [self->_field isFieldTakenByX: (struct TTKCellPoint){2, 0}];
        XCTAssertFalse(fieldTest);
    }
}

// x x x
// 0 - -
// 0 - -
-(void)testXWinsByCompletingRow
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: YES];
    
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];

    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertTrue([self->_field isWinnerPlayerX]);
}


// x - -
// 0 0 0
// - - x
-(void)testOWinsByCompletingRow
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){1, 2} byX: NO];
    
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){2, 2} byX: YES];
    
    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertFalse([self->_field isWinnerPlayerX]);
}

// - x x
// 0 x -
// 0 x 0
-(void)testXWinsByCompletingColumn
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){2, 1} byX: YES];
    
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 2} byX: NO];
    
    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertTrue([self->_field isWinnerPlayerX]);
}

// 0 x x
// 0 x -
// 0 - -
-(void)testOWinsByCompletingColumn
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];
    
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    
    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertFalse([self->_field isWinnerPlayerX]);
}


// x x -
// 0 x -
// 0 0 x
-(void)testXWinsByCompletingDiagonal
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){2, 2} byX: YES];
    
    
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 1} byX: NO];
    
    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertTrue([self->_field isWinnerPlayerX]);
}

// x x o
// - o -
// o - -
-(void)testOWinsByCompletingReverseDiagonal
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: NO];
    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: NO];
    
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    
    
    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertFalse([self->_field isWinnerPlayerX]);
}

// x x o
// o x x
// x o o
-(void)testDraw
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){0, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){0, 2} byX: NO ];
    
    [self->_field takeField: (struct TTKCellPoint){1, 0} byX: NO ];
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){1, 2} byX: YES];

    [self->_field takeField: (struct TTKCellPoint){2, 0} byX: YES];
    [self->_field takeField: (struct TTKCellPoint){2, 1} byX: NO ];
    [self->_field takeField: (struct TTKCellPoint){2, 2} byX: NO ];


    // THEN
    XCTAssertTrue([self->_field isGameOver]);
    XCTAssertTrue([self->_field isDraw]);
    XCTAssertFalse([self->_field isWinnerPlayerX]);
}


// - - -
// - x -
// - - -
-(void)testIncompleteGame
{
    // GIVEN
    [self->_field takeField: (struct TTKCellPoint){1, 1} byX: YES];
    
    // THEN
    XCTAssertFalse([self->_field isGameOver]);
    XCTAssertFalse([self->_field isDraw]);
    XCTAssertFalse([self->_field isWinnerPlayerX]);
}

@end


// - - -
// - - -
// - - -

