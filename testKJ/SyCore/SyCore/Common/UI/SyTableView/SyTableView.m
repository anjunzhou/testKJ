//
//  SyTableView.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#define kType_Header            1
#define kType_Footer            2


#import "SyTableView.h"
#import "SyConstant.h"
#import "UIView+SyView.h"
#import "SyTableHeaderView.h"
#import "SyTableFooterView.h"


@interface SyTableView ()


@end


@implementation SyTableView
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        if (!_tableView) {
            _tableView = [[UITableView alloc] init];
            _tableView.delegate = self;// 把当前类设为 代理 实现scroll代理方法
            _tableView.dataSource = self;
            [self addSubview:_tableView];
        }
        
        if (!_nothingImageView) {
            UIImage *nothingImage = [UIImage imageNamed:@"sy_table_centerBlank@2x.png"];;
            _nothingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 115, 115)];
            _nothingImageView.image = nothingImage;
            _nothingImageView.hidden = YES;
            [_tableView addSubview:_nothingImageView];
        }
        
        _type = kType_Footer;
    }
    return self;
}

- (void)reloadData
{
    _tableFooterView.hidden = YES;
    [_tableView reloadData];
}

- (void)reloadDataWithTotalPage:(NSInteger)totalPage currentPage:(NSInteger)currentPage
{
    
    NSLog(@"+++++++++____%d,%d",totalPage,currentPage);
    
    [_tableView reloadData];
    _tableFooterView.hidden = NO;
    
    if (_type == kType_Header) {
        if (totalPage == 0) {
            // 没数据
            [_tableFooterView setStates:kPullState_NoDataLoad];
            _tableFooterView.hidden = YES;
        }
        else if (totalPage == 1) {
            // 不足一页
            [_tableFooterView setStates:kPullState_NoDataLoad];
            if (_tableView.contentSize.height > _tableView.height) {
                _tableFooterView.hidden = NO;
            }
            else {
                _tableFooterView.hidden = YES;
            }
        }
        else if (totalPage == currentPage) {
            [_tableFooterView setStates:kPullState_NoDataLoad];
            _tableFooterView.hidden = YES;
        }
        else {
            [_tableFooterView setStates:kPullState_Pull];
            _tableFooterView.hidden = NO;
        }
        [_tableHeaderView finishReloading:_tableView animated:YES];
    }
    else if (_type == kType_Footer) {
        if (totalPage > 1) {
            _tableFooterView.hidden = NO;
            if (totalPage == currentPage) {
                [_tableFooterView setStates:kPullState_NoDataLoad];
            }
            else {
                [_tableFooterView setStates:kPullState_Pull];
            }
        }
        else if (totalPage == 1){
            // 不足一页
            [_tableFooterView setStates:kPullState_NoDataLoad];
            if (_tableView.contentSize.height > _tableView.height) {
                _tableFooterView.hidden = NO;
            }
            else {
                _tableFooterView.hidden = YES;
            }
            
        }
        else if (totalPage == 0) {
            // 没数据
            [_tableFooterView setStates:kPullState_NoDataLoad];
            _tableFooterView.hidden = YES;
        }
    }
}

- (void)showHeadLoading
{
    if (_tableHeaderView) {
        _type = kType_Header;
        [_tableHeaderView startReloading:_tableView animated:YES];
    }
    [_tableView setContentOffset:CGPointMake(0, -60)];
}

- (void)hideHeadLoading
{
    if (_tableHeaderView) {
        [_tableHeaderView finishReloading:_tableView animated:YES];
    }
}


- (void)showNoDataView
{
    _nothingImageView.hidden = NO;
}

- (void)hideNoDataView
{
    _nothingImageView.hidden = YES;
}


- (void)setupTableHeaderView
{
    if (!_tableHeaderView && _tableView) {
        _tableHeaderView = [[SyTableHeaderView alloc] init];
        [_tableHeaderView setState:kPullState_Pull];
        [_tableView addSubview:_tableHeaderView];
    }
}
- (void)setupTableFooterView
{
    if (!_tableFooterView && _tableView) {
        _tableFooterView = [[SyTableFooterView alloc] init];
        [_tableFooterView setStates:kPullState_Pull];
        _tableFooterView.frame = CGRectMake(0, 0, self.width, kHeight_HeaderView);
        _tableFooterView.backgroundColor = [UIColor clearColor];
        _tableFooterView.hidden = YES;
        [_tableFooterView addTarget:self action:@selector(footerViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [_tableView setTableFooterView:_tableFooterView];
    }
}

// 底部加载
- (void)footerViewAction:(id)sender
{
    if (_tableFooterView.states == kPullState_NoDataLoad ||
        _tableFooterView.states == kPullState_Loading) {
        return;
    }
    [_tableFooterView setStates:kPullState_Loading];
   
    if (_delegate && [_delegate respondsToSelector:@selector(tableviewFooterRefresh:)]) {
        [_delegate tableviewFooterRefresh:self];
    }
}

- (void)setupTableHeaderAndTableFooterView
{
    [self setupTableHeaderView];
    [self setupTableFooterView];
}

- (void)resetTableHeaderView
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 0, self.width, self.height);
    _nothingImageView.center = _tableView.center;
    _tableHeaderView.frame = CGRectMake(0, -self.height, self.width, self.height);
}
//------------------ UIScrollViewDelegate<NSObject>
#pragma mark- UIScrollViewDelegate
// scrollView.contentSize.height = scrollView.bounds.size.height + scrollView.contentOffset.y
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
            [_delegate scrollViewDidScroll:scrollView];
        }
        
        if (scrollView.contentOffset.y > - kHeight_PullDown && scrollView.contentOffset.y < 0.0f) {
            if (_tableHeaderView && _tableHeaderView.state != kPullState_Loading) {
                [_tableHeaderView setState:kPullState_Pull];
            }
        }
        else if (scrollView.contentOffset.y <= - kHeight_PullDown) {
            _type = kType_Header;
            if (_tableHeaderView && _tableHeaderView.state != kPullState_Loading) {
                [_tableHeaderView setState:kPullState_Release];
            }
        }
        
        else if (scrollView.contentSize.height - scrollView.contentOffset.y - scrollView.bounds.size.height < -kHeight_PullUp) {
            _type = kType_Footer;
            if (_tableFooterView && _tableFooterView.states == kPullState_Pull) {
                [self footerViewAction:nil];
            }
        }
    }
    
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
            [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
        }
        if (_tableHeaderView.state == kPullState_Release && _type == kType_Header) {
            [_tableHeaderView startReloading:_tableView animated:YES];
            if (_delegate && [_delegate respondsToSelector:@selector(tableViewHeaderReresh:)]) {
                [_delegate tableViewHeaderReresh:self];
            }
        }
        if (_tableFooterView.states == kPullState_Loading && _type == kType_Footer) {
            [self footerViewAction:nil];
        }
    }
}

// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
            [_delegate scrollViewDidZoom:scrollView];
        }
    }
    
}

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
            [_delegate scrollViewWillBeginDragging:scrollView];
        }
    }
}
// called on finger up if the user dragged. velocity is in points/second. targetContentOffset may be changed to adjust where the scroll view comes to rest. not called when pagingEnabled is YES
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
            [_delegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
        }

    }
}

// called on finger up as we are moving
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
            [_delegate scrollViewWillBeginDecelerating:scrollView];
        }
    }
}

 // called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
            [_delegate scrollViewDidEndDecelerating:scrollView];
        }
    }
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _tableView) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
            [_delegate scrollViewDidEndScrollingAnimation:scrollView];
        }
    }
}
 // return a view that will be scaled. if delegate returns nil, nothing happens
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [_delegate viewForZoomingInScrollView:scrollView];
    }
    else
        return nil;
}
 // called before the scroll view begins zooming its content
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2)
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [_delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

// scale between minimum and maximum. called after any 'bounce' animations
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [_delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

// return a yes if you want to scroll to the top. if not defined, assumes YES
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [_delegate scrollViewShouldScrollToTop:scrollView];
    }
    else
        return YES;
}

// called when scrolling animation finished. may be called immediately if already at top
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_delegate scrollViewDidScrollToTop:scrollView];
    }
}
//----------------------------------------------------------------------------------------------------------------
//                              UITableViewDataSource
#pragma mark- UITableViewDataSource 全部方法共 11
// 1
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [_dataSource tableView:tableView numberOfRowsInSection:section];
    }
    else {
        return 0;
    }
       
}

// 2
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        UITableViewCell *cell = [_dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell;
    }
    else {
        return nil;
    }
    
}
// 3
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [_dataSource numberOfSectionsInTableView:tableView];
    }
    else {
        return 1;
    }
}
// 4
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [_dataSource tableView:tableView titleForHeaderInSection:section];
    }
    else {
        return @"";
    }
}
// 5
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [_dataSource tableView:tableView titleForFooterInSection:section];
    }
    else {
        return @"";
    }
}

// 6    Editing
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [_dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }else {
        return NO;
    }
}

// 7    Moving/reordering
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [_dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }else {
        return NO;
    }
}

// 8    Index
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (_dataSource && [_dataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [_dataSource sectionIndexTitlesForTableView:tableView];
    }else {
        return nil;
    }
}
// 9
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [_dataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }else {
        return 0;
    }
}
// 10
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [_dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
// 11
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    if (_dataSource && [_dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [_dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

//--------------------------------------------------------------------------------------------------------------------
//                                  UITableViewDelegate 共22
#pragma mark- UITableViewDelegate 全部
//  1
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [_delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

// 2    Variable height support
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }else
        return kHeight_CellDefault;
}
// 3
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [_delegate tableView:tableView heightForHeaderInSection:section];
    }else
        return 0;
}
// 4
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [_delegate tableView:tableView heightForFooterInSection:section];
    }else
        return 0;
}

// 5
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [_delegate tableView:tableView viewForHeaderInSection:section];
    }else
        return nil;
}
// 6
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [_delegate tableView:tableView viewForFooterInSection:section];
    }else
        return nil;
}

// 7    Accessories (disclosures). DEPRECATED
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath{}
//  8
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        return [_delegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
#pragma mark Select
//  9    Selection
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [_delegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    }else
        return indexPath;
}
//  10
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [_delegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }else
        return indexPath;
}
//  11
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
// 12
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [_delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}
//  13      Editing
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }else
        return UITableViewCellEditingStyleNone;
}
// 14
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }else
        return @"";
}

// 15
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [_delegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }else
        return NO;
}
// 16
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        return [_delegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}
// 17
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        return [_delegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

// 18       Moving/reordering
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [_delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }else
        return nil;
}

// 19
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }else
        return 0;
}
// 20
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [_delegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }else
        return NO;
}
// 21
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [_delegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }else
        return NO;
}
// 22
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        return [_delegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}


@end
