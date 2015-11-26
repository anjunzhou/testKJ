//
//  SyTableView.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SyTableHeaderView;
@class SyTableFooterView;

@protocol SyTableViewDelegate;
@interface SyTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
//    id <UITableViewDataSource>      _dataSource;
//    id <UITableViewDelegate,
//        SyTableViewDelegate,UIScrollViewDelegate>        _delegate;
    UITableView         *_tableView;
    
    SyTableHeaderView   *_tableHeaderView;
    SyTableFooterView   *_tableFooterView;
    
    NSInteger           _type;
    
    UIImageView*        _nothingImageView;
    
}


@property (nonatomic, assign) id<UITableViewDataSource> dataSource;
@property (nonatomic, assign) id<UITableViewDelegate,SyTableViewDelegate,UIScrollViewDelegate>   delegate;
@property (nonatomic, retain) UITableView   *tableView;



- (void)showHeadLoading;
- (void)hideHeadLoading;

- (void)showNoDataView;
- (void)hideNoDataView;



- (void)reloadData;     // 加载数据
- (void)reloadDataWithTotalPage:(NSInteger)totalPage currentPage:(NSInteger)currentPage;




- (void)setupTableHeaderView;
- (void)setupTableFooterView;
- (void)setupTableHeaderAndTableFooterView;
- (void)resetTableHeaderView;

@end





@protocol SyTableViewDelegate <NSObject,
    UITableViewDelegate,UIScrollViewDelegate,UITableViewDataSource>


@optional
// tableView 顶部刷新加载
- (void)tableViewHeaderReresh:(SyTableView *)tableView;
// tableView 底边刷新加载
- (void)tableviewFooterRefresh:(SyTableView *)tableView;


@end






