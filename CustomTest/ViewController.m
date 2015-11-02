//
//  ViewController.m
//  CustomTest
//
//  Created by lunarboat on 15/11/2.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewController.h"

@interface ViewController (){
    NSArray *_listArray;
    NSArray *_dataArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _listArray = @[@"1", @"11", @"111", @"1111", @"11111", @"111111", @"1111", @"111", @"1111", @"111", ];
    _dataArray = @[@"2", @"22", @"222", @"2222222", @"2222222", @"2222222", @"2222222", @"22", @"222"];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    CustomViewController *vc = [segue destinationViewController];
    vc.dataArray = _dataArray;
    vc.listArray = _listArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
