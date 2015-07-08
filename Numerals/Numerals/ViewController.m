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
#import "Utils.h"

#define tableSize 30000

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

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

    //[self.numeralLabel setText:[self numeralToRoman: digit]];
    [self.numeralLabel setText:[Utils numeralToRoman: digit]];

    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:digit inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
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
    
    [cell.textLabel setText:[Utils numeralToRoman:indexPath.item+1]];
    
    return cell;
}

@end
