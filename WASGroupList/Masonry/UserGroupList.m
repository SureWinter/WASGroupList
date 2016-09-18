//
//  UserGroupList.m
//  MeiJiaShi
//
//  Created by luofeiyu on 16/9/5.
//  Copyright © 2016年 luofeiyu. All rights reserved.
//

#import "UserGroupList.h"
#import "AppDelegate.h"
#import "UIColor+extension.h"
// MARK: - 选择框中每个选择条目
@interface GroupListItem ()
@property (nonatomic,weak) UserGroupList  *list;
@end
@implementation GroupListItem
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_list clearAllSelectState];
    self.img.image = [UIImage imageNamed:@"icon_fenzu_selected"];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *lab = [UILabel new];
        lab.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
        lab.font = [UIFont systemFontOfSize:15];
        lab.bounds = (CGRect){0,0,frame.size.width - 21,21};
        lab.center = (CGPoint){28+lab.bounds.size.width/2,frame.size.height/2};
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
        self.lab = lab;
        
        UIImageView *img = [[UIImageView alloc] init];
        img.bounds = (CGRect){0,0 ,18,18};
        img.center = (CGPoint){frame.size.width -24,frame.size.height/2};
        [self addSubview:img];
        self.img = img;
    }
    return self;
}

@end

// MARK: - 选择框后的灰色背景
@interface GroupListBgView () 
@property (nonatomic,weak) UserGroupList  *list;
@end

@implementation GroupListBgView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_list dismiss];
}

@end



// MARK: - 选择框主体

@interface UserGroupList ()
@property (nonatomic,strong) GroupListBgView  *bgView; //灰色背景
@property (nonatomic,strong) UIView  *groupList;       //显示选项的view
@property (nonatomic,strong) NSMutableArray  *itemArray;//所有选项存放的数组
@property (nonatomic,strong) UIScrollView  *listScrollView; //滑动的listScrollView
@end

@implementation UserGroupList
SYNTHESIZE_SINGLETON_FOR_CLASS(UserGroupList)

- (void)createGroupList:(NSArray *)group
{
    CGFloat margin = 30;
    CGFloat headH = 50;
    CGFloat FootH = 55;
    CGFloat itemFinalH = 51;

    CGFloat ListH = itemFinalH* MIN(group.count,6) + margin + headH + FootH;
    
    UIView *list = [[UIView alloc] initWithFrame:(CGRect){0,0,ScreenWidth - 60,ListH}];
    list.backgroundColor = [UIColor whiteColor];
    list.layer.cornerRadius = 8;
    list.layer.masksToBounds = YES;
    
    
    //滑动的listScrollView
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:(CGRect){0,headH,list.frame.size.width,itemFinalH* MIN(group.count,6)+ margin}];
    scroll.contentSize = (CGSize){list.frame.size.width,itemFinalH*group.count +margin};
    scroll.showsVerticalScrollIndicator = NO;
    [list addSubview:scroll];
    
    //选择条目
    _itemArray = [NSMutableArray array];
    for (int i = 0; i<group.count; i++) {
        GroupListItem *itemBtn = [[GroupListItem alloc] initWithFrame:(CGRect){0,margin/2 + itemFinalH *i,ScreenWidth - 60,itemFinalH}];
        itemBtn.lab.text = group[i];
        itemBtn.list = self;
        [scroll addSubview:itemBtn];
        [_itemArray addObject:itemBtn];
        if (i == 0) {
            itemBtn.img.image = [UIImage imageNamed:@"icon_fenzu_selected"];
        }else{
            itemBtn.img.image = [UIImage imageNamed:@"icon_fenzu_unselected"];
        }
    }
    
    //标题
    UILabel *title = [UILabel new];
    title.text = @"选择分组";
    title.textColor = [UIColor colorWithHexString:@"#666666"];
    title.bounds = (CGRect){0,0,68,24};
    title.center = (CGPoint){list.frame.size.width/2,25};
    [list addSubview:title];
    
    //线1 线2 线3
    CALayer *layer1 = [CALayer new];
    layer1.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"].CGColor;
    layer1.frame = (CGRect){0,50 ,list.frame.size.width,1};
    [list.layer addSublayer:layer1];
    
    CALayer *layer2 = [CALayer new];
    layer2.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"].CGColor;
    layer2.frame = (CGRect){0,list.frame.size.height - 55 ,list.frame.size.width,1};
    [list.layer addSublayer:layer2];
    
    CALayer *layer3 = [CALayer new];
    layer3.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"].CGColor;
    layer3.frame = (CGRect){list.frame.size.width/2 ,list.frame.size.height - 55,1,55};
    [list.layer addSublayer:layer3];
    
    //确定 取消
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    done.frame = (CGRect){list.frame.size.width/2,list.frame.size.height - 55,list.frame.size.width/2,55};
    [done setTitle:@"确定" forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont systemFontOfSize:17];
    [done addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [done setTitleColor:[UIColor colorWithHexString:@"F34270"] forState:UIControlStateNormal];
    [list addSubview:done];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = (CGRect){0,list.frame.size.height - 55,list.frame.size.width/2,55};
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [list addSubview:cancel];
    
    _groupList = list;
    [[UserGroupList mainWindow] addSubview: _groupList];
    _groupList.center = [UserGroupList mainWindow].center;
    
}

- (void)showListOnGroup:(NSArray *)group
{
    [[UserGroupList mainWindow] addSubview: _bgView];
    [self createGroupList:[NSArray arrayWithObjects:@"优质顾客",@"普通顾客",@"待唤醒顾客",@"待分组顾客",@"屌丝111",@"屌丝2222",@"屌丝3333",@"屌丝4444",@"屌丝5555",nil]];
    
}

- (void)dismiss
{
    [_bgView removeFromSuperview];
    [_groupList removeFromSuperview];
}
+ (UIWindow*)mainWindow
{
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] window];
}

- (void)clearAllSelectState
{
    for (GroupListItem *item in _itemArray) {
        item.img.image = [UIImage imageNamed:@"icon_fenzu_unselected"];
    }
}

- (id)init
{
    if (self = [super init]) {
        _bgView = [[GroupListBgView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.autoresizingMask = UIViewAutoresizingNone;
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        _bgView.list = self;
    }
    return self;
}
@end
