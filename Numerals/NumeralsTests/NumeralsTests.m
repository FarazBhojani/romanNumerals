//
//  NumeralsTests.m
//  NumeralsTests
//
//  Created by Faraz Bhojani on 2015-07-08.
//  Copyright (c) 2015 Faraz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Utils.h"

@interface NumeralsTests : XCTestCase

@end

@implementation NumeralsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testNumeralBoundCase1 {
    XCTAssertEqualObjects([Utils numeralToRoman:1], @"I");
}

- (void)testNumeralGenericCase1 {
    XCTAssertEqualObjects([Utils numeralToRoman:2], @"II");
    XCTAssertEqualObjects([Utils numeralToRoman:3], @"III");
    XCTAssertEqualObjects([Utils numeralToRoman:4], @"IV");
    XCTAssertEqualObjects([Utils numeralToRoman:5], @"V");
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
