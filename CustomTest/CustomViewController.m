//
//  CustomViewController.m
//  YZFreeShop
//
//  Created by lunarboat on 15/11/2.
//  Copyright © 2015年 lunarboat. All rights reserved.
//

#import "CustomViewController.h"
#import "HTHorizontalSelectionList.h"
#import "CustomTableView.h"
#define ViewSize self.view.bounds.size

@interface CustomViewController ()<HTHorizontalSelectionListDataSource, HTHorizontalSelectionListDelegate, UIScrollViewDelegate>{
    
    NSMutableArray *_viewArray;
}
@property (nonatomic, strong) HTHorizontalSelectionList *selectionList;
@property (nonatomic, strong) UIScrollView *allScrollView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation CustomViewController

- (NSInteger)index{
    return (int)_allScrollView.contentOffset.x / (int)ViewSize.width;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectionList = [[HTHorizontalSelectionList alloc]initWithFrame:CGRectMake(0, 0, ViewSize.width, 30)];
    [self.view addSubview:_selectionList];
    _selectionList.delegate = self;
    _selectionList.dataSource = self;
    
    _allScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ViewSize.width, ViewSize.height - 30)];
    [self.view addSubview:_allScrollView];
    _allScrollView.contentSize = CGSizeMake(ViewSize.width * _listArray.count, 0);
    _allScrollView.delegate = self;
    NSLog(@"%f",ViewSize.width * _listArray.count);
    _allScrollView.pagingEnabled = YES;
    
    [self loadDataListView];
    [self loadDataWithObjectArray:_dataArray];
    
}

#pragma mark - loadMethod
- (void)loadDataListView{
    _viewArray = [[NSMutableArray alloc]initWithCapacity:_listArray.count];
    for (int i=0; i<_listArray.count; i++) {
        CustomTableView *tableview = [[CustomTableView alloc]initWithFrame:CGRectMake(ViewSize.width * i, 0, ViewSize.width, ViewSize.height) style:UITableViewStylePlain];
        [self.allScrollView addSubview:tableview];
        [_viewArray addObject:tableview];
    }
    
}

//这个方法里从网络获取数据赋值给data数组， 这里传的数组只是测试用
- (void)loadDataWithObjectArray:(NSArray *)array{
    CustomTableView *currentView = [_viewArray objectAtIndex:_index];
    currentView.delegate = currentView;
    currentView.dataSource = currentView;
    NSMutableArray *displayArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    for (NSString *str in array) {
        [displayArray addObject:[NSString stringWithFormat:@"%ld-%@-%@",_index, str, _listArray[_index]]];
    }
    [currentView dataArray:displayArray];
    [currentView reloadData];
    //例如
    //执行网络数据操作
//    [YZSuperData getListDataWithListNumber:_index ComplationBlock:^(NSArray *array) {
//        [currentView dataArray:array];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [currentView reloadData];
//            [currentView.header endRefreshing];
//        });
//    }];
}


#pragma mark - SomeThingInitial
//- (HTHorizontalSelectionList *)selectionList{
//    _selectionList = [[HTHorizontalSelectionList alloc]initWithFrame:CGRectMake(0, 0, ViewSize.width, 30)];
//    [self.view addSubview:_selectionList];
//    _selectionList.delegate = self;
//    _selectionList.dataSource = self;
//    return _selectionList;
//}
//- (UIScrollView *)allScrollView{
//    _allScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, ViewSize.width, ViewSize.height - 30)];
//    [self.view addSubview:_allScrollView];
//    _allScrollView.contentSize = CGSizeMake(ViewSize.width * _listArray.count, 0);
//    NSLog(@"%f",ViewSize.width * _listArray.count);
//    _allScrollView.pagingEnabled = YES;
//    return _allScrollView;
//}



#pragma mark - HorizontalSelectionListDateSource&delegate
- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList{
    return _listArray.count;
}
- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)index{
    return [_listArray objectAtIndex:index];
}
- (void)selectionList:(HTHorizontalSelectionList *)selectionList didSelectButtonWithIndex:(NSInteger)index{
    [_allScrollView setContentOffset:CGPointMake(index * ViewSize.width, _allScrollView.frame.origin.y) animated:YES];
    _index = index;
    //这里改变了当前视图，需要加载另一个数据源的view，需要重新加载
    [self loadDataWithObjectArray:_dataArray];
}
#pragma mark - scrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSInteger index = (int)targetContentOffset->x / (int)ViewSize.width;
    [self.selectionList setSelectedButtonIndex:index animated:YES];
    _index = index;
    CustomTableView *tableView = _viewArray[index];
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (!cell) {
        //这里改变了当前视图，需要加载另一个数据源的view，需要重新加载
        [self loadDataWithObjectArray:_dataArray];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
