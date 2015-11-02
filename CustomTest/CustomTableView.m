//
//  CustomTableView.m
//  YZFreeShop
//
//  Created by lunarboat on 15/11/2.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "CustomTableView.h"

@interface CustomTableView (){
    NSArray *_array;
}

@end

@implementation CustomTableView

- (void)dataArray:(NSArray *)dataArray{
    _array = dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"listDataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
}

@end
