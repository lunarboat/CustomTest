//
//  CustomTableView.h
//  YZFreeShop
//
//  Created by lunarboat on 15/11/2.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

- (void)dataArray:(NSArray *)dataArray;


@end
