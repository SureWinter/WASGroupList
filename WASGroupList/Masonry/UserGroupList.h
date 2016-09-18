//
//  UserGroupList.h
//  MeiJiaShi
//
//  Created by luofeiyu on 16/9/5.
//  Copyright © 2016年 luofeiyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomMacro.h"

@interface GroupListItem : UIView
@property (nonatomic,strong) UILabel  *lab;
@property (nonatomic,strong) UIImageView  *img;
@end

@interface GroupListBgView :UIView
@end

@interface UserGroupList : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(UserGroupList)
- (void)showListOnGroup:(NSArray *)group;
- (void)dismiss;
- (void)clearAllSelectState;
@end
