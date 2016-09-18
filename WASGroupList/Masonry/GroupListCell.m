//
//  GroupListCell.m
//  WASGroupList
//
//  Created by luofeiyu on 16/9/18.
//  Copyright © 2016年 wangshuo. All rights reserved.
//

#import "GroupListCell.h"
#import "Masonry.h"
#import "UIColor+extension.h"
@interface GroupListCell ()

@property (nonatomic,strong) UIImageView  *icon;

@property (nonatomic,strong) UILabel  *nickName;

@property (nonatomic,strong) UILabel  *purchaseLab;

@property (nonatomic,strong) UIButton  *lastPurchase;

@property (nonatomic,strong) UIButton  *changeGroupBtn;

@property (nonatomic,strong) UIImageView  *levelImgV;

@property (nonatomic,strong) UIImageView  *birthdayTag;


@end

@implementation GroupListCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _icon = [[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(50);
        }];
        
        _nickName = [[UILabel alloc] init];
        _nickName.textColor = [UIColor blackColor];
        _nickName.textColor = [UIColor colorWithHexString:@"#1A1A1A"];
        _nickName.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.left.equalTo(_icon.mas_right).with.offset(10);
            make.height.mas_equalTo(24);
        }];
        
        _purchaseLab = [[UILabel alloc] init];
        _purchaseLab.textColor = [UIColor colorWithHexString:@"#666666"];
        _purchaseLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_purchaseLab];
        [_purchaseLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nickName.mas_bottom).with.offset(4);
            make.left.equalTo(_icon.mas_right).with.offset(10);
            make.height.mas_equalTo(17);
        }];
        
        _lastPurchase = [[UIButton alloc] init];
        _lastPurchase.titleLabel.font = [UIFont systemFontOfSize:14];
        _lastPurchase.titleLabel.textAlignment = NSTextAlignmentLeft;
        _lastPurchase.titleEdgeInsets = UIEdgeInsetsMake(6,10,0,0);
        _lastPurchase.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_lastPurchase setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        _lastPurchase.userInteractionEnabled = NO;
        UIEdgeInsets insets = UIEdgeInsetsMake(30, 300, 4, 20);
        UIImage * image = [[UIImage imageNamed:@"bg_shuoming"] resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [_lastPurchase setBackgroundImage:image forState:UIControlStateNormal];
        [self.contentView addSubview:_lastPurchase];
        [_lastPurchase mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_icon.mas_bottom).with.offset(4);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.mas_right).with.offset(-15);
            make.height.mas_equalTo(36);
        }];
        
        
        _changeGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeGroupBtn.layer.cornerRadius = 3;
        _changeGroupBtn.layer.masksToBounds = YES;
        _changeGroupBtn.layer.borderWidth = 1.0;
        [_changeGroupBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        _changeGroupBtn.titleLabel.font = [UIFont systemFontOfSize:12];;
        [_changeGroupBtn addTarget:self action:@selector(changeGroupClick) forControlEvents:UIControlEventTouchUpInside];
        _changeGroupBtn.layer.borderColor = [UIColor colorWithHexString:@"#E6E6E6"].CGColor;
        [self.contentView addSubview:_changeGroupBtn];
        [_changeGroupBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.right.equalTo(self.mas_right).with.offset(-15);
            make.height.mas_equalTo(24);
        }];
        
        _birthdayTag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_brithday_list"]];
        [self.contentView addSubview:_birthdayTag];
        [_birthdayTag mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(36, 36));
        }];
        
    }
    
    return self;
}


- (void)configCell:(id)data
{
    _icon.image = [UIImage imageNamed:@"product_meirong"];
    _nickName.text = @"用户阿克苏";
    _purchaseLab.text = @"消费4次 | 共消费400元";
    [_lastPurchase setTitle:@"肩部按摩（5天前）" forState:UIControlStateNormal];
    
    [_changeGroupBtn setTitle:@" 设置用户分组  " forState:UIControlStateNormal];
    
}

- (void)changeGroupClick
{
    if ([self.delegate respondsToSelector:@selector(cellDidClickChangeGroupBtn)]) {
        [self.delegate cellDidClickChangeGroupBtn];
    }
}


@end
