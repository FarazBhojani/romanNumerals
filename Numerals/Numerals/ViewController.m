//
//  ViewController.m
//  Numerals
//
//  Created by Faraz Bhojani on 2015-07-08.
//  Copyright (c) 2015 Faraz. All rights reserved.
//

/*
 Converting Arabic Numbers to Roman Numerals
 */

#import "ViewController.h"

#define tableSize 30000

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

//tied together
@property (nonatomic) NSArray *numeralString;
@property (nonatomic) NSArray *numeralIndex;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSString *cellIdentifier;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *numeralLabel;
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.numeralString = [[NSArray alloc] initWithObjects:@"I", @"V", @"X", @"L", @"C", @"D", nil];
    self.numeralIndex = [[NSArray alloc] initWithObjects:@1, @5, @10, @50, @100, @500, nil];
    
    for( int i = 1; i < 110; i ++ )
        NSLog(@"%d -> %@", i, [self numeralToRoman:i]);
    
    
    self.cellIdentifier = @"Cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: self.cellIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.textField addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    self.textField.placeholder = @"Arabic numeral";
    
    self.numeralLabel.layer.cornerRadius = self.textField.layer.cornerRadius;
    
    self.topView.layer.borderWidth = 0.3f;
    self.topView.layer.borderColor = [[UIColor colorWithHue:1.0f saturation:0.0f brightness:0.7 alpha:1.0f] CGColor];
    self.topView.layer.shadowOpacity = 0.2f;
    self.topView.layer.shadowRadius = 2.5;
    self.topView.layer.shadowOffset = CGSizeZero;
}

-(void)textChanged
{
    NSInteger digit = [self.textField.text integerValue];
 
    //if the digit entered is too big, scroll to the largest value in the table. 
    if( digit > tableSize )
        digit = tableSize-1;

    [self.numeralLabel setText:[self numeralToRoman: digit]];

    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:digit inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


-(NSString *)numeralToRoman: (NSInteger)num
{
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
    for( int i = self.numeralIndex.count-1; i --; i > 0 )
            if( num/[self.numeralIndex[i] integerValue] >= 1 )
            {
                highestFactor = [self.numeralIndex[i] integerValue];
                highestFactorIndex = i;
                
                break;
            }
    
    NSInteger nextHighest;
    NSInteger subtractionPoint;
    NSInteger leftover;
    
    if( highestFactorIndex < self.numeralIndex.count-1 )
        nextHighest = [self.numeralIndex[highestFactorIndex+1] integerValue];
    
    subtractionPoint = nextHighest-highestFactor;
    
    //if there is a highest subtraction point and the num is greater than or equal to it and the biggest factor is not half of the next biggest numeral, reverse the symbols for next highest and highest and continue algorithm on the leftover.
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
    
    return romanString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableSize;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    
    [cell.textLabel setText:[self numeralToRoman:indexPath.item+1]];
    
    return cell;
}

@end
