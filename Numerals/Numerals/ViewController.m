//
//  ViewController.m
//  Numerals
//
//  Created by Faraz Bhojani on 2015-07-08.
//  Copyright (c) 2015 Faraz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSMutableArray *romanNumerals;

//tied together
@property (nonatomic) NSArray *numeralString;
@property (nonatomic) NSArray *numeralIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.numeralString = [[NSArray alloc] initWithObjects:@"I", @"V", @"X", @"L", nil];
    self.numeralIndex = [[NSArray alloc] initWithObjects:@1, @5, @10, @50, nil];
    
    self.romanNumerals = [[NSMutableArray alloc] init];
    [self.romanNumerals addObject:@"0"];
    
    for( int i = 1; i < 41; i ++ )
        NSLog(@"%d -> %@", i, [self numeralToRoman:i]);
}

-(NSString *)numeralToRoman: (int)num
{
    if( num < self.romanNumerals.count )
        return self.romanNumerals[num];
    
    int highestFactor = 1, highestFactorIndex = 0;
    for( int i = self.numeralIndex.count-1; i --; i > 0 )
            if( num/[self.numeralIndex[i] integerValue] >= 1 )
            {
                highestFactor = [self.numeralIndex[i] integerValue];
                highestFactorIndex = i;
                
                break;
            }
    
    NSString *romanString = @"";
    int nextHighest;
    int subtractionPoint;
    int leftover;
    
    if( highestFactorIndex < self.numeralIndex.count-1 )
        nextHighest = [self.numeralIndex[highestFactorIndex+1] integerValue];
    
    subtractionPoint = nextHighest-highestFactor;
    
    if( highestFactorIndex < self.numeralIndex.count-1 && num >= subtractionPoint && subtractionPoint != highestFactor)
    {
        romanString = [romanString stringByAppendingString:self.numeralString[highestFactorIndex]];
        romanString = [romanString stringByAppendingString:self.numeralString[highestFactorIndex+1]];
        
        leftover = num%subtractionPoint;
        
        if( leftover > 0 )
            romanString = [romanString stringByAppendingString: [self numeralToRoman:leftover]];
    }
    else
    {
        int numberOfTimes = num / highestFactor; // the number of times the closest (floor) number fits into this num
        for( int i = 0; i < numberOfTimes; i ++ )
        {
            romanString = [romanString stringByAppendingString: self.numeralString[highestFactorIndex]];
        }
        
        leftover = num%highestFactor;
        if( leftover > 0 )
            romanString = [romanString stringByAppendingString: [self numeralToRoman:leftover]];
    }
    
    if( num >= self.romanNumerals.count )
       [self.romanNumerals addObject:romanString];
    
    return romanString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
