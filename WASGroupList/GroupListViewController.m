//
//  GroupListViewController.m
//  WASGroupList
//
//  Created by luofeiyu on 16/9/18.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import "GroupListViewController.h"
#import "CustomMacro.h"
#import "Masonry/Masonry.h"
#import "GroupListCell.h"
#import "UserGroupList.h"

@interface GroupListViewController ()<UITableViewDelegate,UITableViewDataSource,GroupListCellDelegate>
@property (nonatomic,strong) UITableView  *tableView;

@property (nonatomic,strong) NSMutableArray  *UserData;
@property (nonatomic,strong) NSMutableArray  *cateData;

@property (nonatomic,strong) NSMutableArray  *multopenSectionArray;


@end

@implementation GroupListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _UserData = [NSMutableArray arrayWithObjects:@"user1", @"user2", @"user3",@"user1", @"user2", @"user3",@"user1", @"user2", @"user3", nil];
    _cateData = [NSMutableArray arrayWithObjects:@"待分组顾客",@"优质顾客", @"普通顾客",@"待唤醒顾客",nil];
    _multopenSectionArray = [NSMutableArray array];
    _tableView.tableFooterView = [UIView new];
    self.view.backgroundColor = RGBA(247, 247, 247, 1);


}




// MARK: - cell Delegate

- (void)cellDidClickChangeGroupBtn {
    [[UserGroupList sharedUserGroupList] showListOnGroup:[NSArray array]];
}

// MARK: - UITapGestureRecognizer response


- (void)tapHeader:(UITapGestureRecognizer *) tap {
    NSInteger section = tap.view.tag;
    NSNumber *sectionObj = [NSNumber numberWithInteger:section];
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:100];
    if ([_multopenSectionArray containsObject:sectionObj]) {
        NSArray *deleteArray = [self buildRowWithSection:section];
        [_multopenSectionArray removeObject:sectionObj];
        [_tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationTop];
        [UIView animateWithDuration:0.3 animations:^{
            imageView.transform = CGAffineTransformMakeRotation(0);
        }];
    }else{
        [_multopenSectionArray addObject:sectionObj];
        NSArray *insertArray = [self buildRowWithSection:section];
        [_tableView insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationTop];
        [UIView animateWithDuration:0.3 animations:^{
            imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }];
    }
}

- (NSMutableArray *)buildRowWithSection:(NSInteger)section {
    NSInteger delete = [self tableView:_tableView numberOfRowsInSection:section];
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    for (int i = 0; i < delete; i++) {
        [indexPaths addObject: [NSIndexPath indexPathForRow:i inSection:section]];
    }
    return indexPaths;
}


// MARK: - tableView delegate and dataSoure

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cateData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![_multopenSectionArray containsObject:[NSNumber numberWithInteger:section]]) {
        return 0;
    }
    return self.UserData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserProfilesCell"];
    if (!cell) {
        cell = [[GroupListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserProfilesCell"];
    }
    cell.delegate = self;
    [cell configCell:@"sss"];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.tag = section;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeader:)];
    [view addGestureRecognizer:tap];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_shouqi"]];
    img.frame = (CGRect){15,21,9,9};
    img.tag = 100;
    NSNumber *sectionObj = [NSNumber numberWithInteger:section];
    if (![_multopenSectionArray containsObject:sectionObj]) {
        img.transform = CGAffineTransformMakeRotation(0);
    }else{
        img.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    [view addSubview:img];
    
    UILabel *title = [UILabel new];
    title.font =[UIFont systemFontOfSize:14];
    title.textColor = [UIColor blackColor];
    title.text = _cateData[section];
    title.frame = (CGRect){40,15,ScreenWidth - 80,20};
    [view addSubview:title];
    
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


// MARK: - init view
- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.navigationItem.title = @"顾客档案";
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,ScreenWidth,ScreenHeight} style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = RGBA(247, 247, 247, 1);
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets((UIEdgeInsets){50,0,0,0});
    }];
}

@end
