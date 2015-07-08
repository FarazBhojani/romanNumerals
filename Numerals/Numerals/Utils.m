//
//  Utils.m
//  Numerals
//
//  Created by Faraz Bhojani on 2015-07-08.
//  Copyright (c) 2015 Faraz. All rights reserved.
//

#import "Utils.h"

@interface Utils()
@end

@implementation Utils

//Converts arabic numerals to roman numerals
+(NSString *)numeralToRoman: (NSInteger)num
{
    NSArray *numeralString = [[NSArray alloc] initWithObjects:@"I", @"V", @"X", @"L", @"C", @"D", nil];
    NSArray *numeralIndex = [[NSArray alloc] initWithObjects:@1, @5, @10, @50, @100, @500, nil];
    
    NSString *romanString = @"";
    
    if( num <= 0 )
    {
        NSLog(@"Please enter a number greater than 0");
        return @"";
    }
    
    if( num == 9 )
    {
        romanString = @"IX";
        return romanString;
    }
    
    NSInteger highestFactor = 1, highestFactorIndex = 0;
    for( NSInteger i = (NSInteger)numeralIndex.count-1; i --; )
        if( num/[numeralIndex[i] integerValue] >= 1 )
        {
            highestFactor = [numeralIndex[i] integerValue];
            highestFactorIndex = i;
            
            break;
        }
    
    NSInteger nextHighest;
    NSInteger subtractionPoint;
    NSInteger leftover;
    
    if( highestFactorIndex < numeralIndex.count-1 )
        nextHighest = [numeralIndex[highestFactorIndex+1] integerValue];
    
    subtractionPoint = nextHighest-highestFactor;
    
    //if there is a highest subtraction point and the num is greater than or equal to it and the biggest factor is not half of the next biggest numeral, reverse the symbols for next highest and highest and continue algorithm on the leftover.
    if( highestFactorIndex < numeralIndex.count-1 && num >= subtractionPoint && subtractionPoint != highestFactor)
    {
        romanString = [romanString stringByAppendingString: numeralString[highestFactorIndex]];
        romanString = [romanString stringByAppendingString: numeralString[highestFactorIndex+1]];
        
        leftover = num%subtractionPoint;
        
        if( leftover > 0 )
            romanString = [romanString stringByAppendingString: [self numeralToRoman:leftover]];
    }
    else
    {
        int numberOfTimes = num / highestFactor; // the number of times the closest (floor) number fits into this num
        for( int i = 0; i < numberOfTimes; i ++ )
        {
            romanString = [romanString stringByAppendingString: numeralString[highestFactorIndex]];
        }
        
        leftover = num%highestFactor;
        if( leftover > 0 )
            romanString = [romanString stringByAppendingString: [self numeralToRoman:leftover]];
    }
    
    return romanString;
}

@end
