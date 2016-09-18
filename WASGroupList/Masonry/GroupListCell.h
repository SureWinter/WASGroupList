//
//  GroupListCell.h
//  WASGroupList
//
//  Created by luofeiyu on 16/9/18.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GroupListCellDelegate <NSObject>
@optional
- (void)cellDidClickChangeGroupBtn;
@end
@interface GroupListCell : UITableViewCell
- (void)configCell:(id)data;
@property (nonatomic, weak) id<GroupListCellDelegate>delegate;
@end
