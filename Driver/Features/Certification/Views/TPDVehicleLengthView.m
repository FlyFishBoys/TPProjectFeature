//
//  TPDVehicleLengthView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleLengthView.h"
#import "TPFilterView.h"

@interface TPDVehicleLengthView ()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * truckTypeLabel;
@property (nonatomic,strong) UIImageView * arrowImageView;
@property (nonatomic , strong) NSMutableArray <NSNumber *>*selectItems;

@end

@implementation TPDVehicleLengthView

#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        _isEnble = YES;
        [self vl_addSubviews];
        [self vl_createTapGesture];
    }
    return self;
}

#pragma mark - Privates
- (void)vl_createTapGesture {
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(vl_tapGestureRecognizerAction:)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)vl_setupConstraints {
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.top.bottom.equalTo(self);
    }];
    
    [self addSubview:_arrowImageView];
    [_arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).with.offset(TPAdaptedWidth(-20));
    }];
    
    [_truckTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(_arrowImageView.mas_left).with.offset(TPAdaptedWidth(-8));
    }];
    
}

//选择车型
- (void)vl_tapGestureRecognizerAction:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (!self.isEnble) return;
    
    TPFilterView *filter = [TPFilterView initWithShowRentType:YES title:@""];
    filter.trucktypeNumber = 0;
    filter.trucklengthNumber = 0;
    filter.didSelectItems = self.selectItems;
    @weakify(self);
    [filter showFilterViewInWindowHandleComplete:^(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *trucktype, NSInteger rentType, NSArray<NSArray<NSNumber *> *> *selectItems) {
        @strongify(self);
        self.selectItems = selectItems.mutableCopy;
        if (self.vehicleLengCompleteBlock) {
            NSString * lengthId = trucklength.lastObject ? trucklength.lastObject.lengthId : @"";
            NSString * typeId = trucktype.lastObject ? trucktype.lastObject.typeId : @"";
            NSString * truckLengthTypeName = trucktype.lastObject ? [NSString stringWithFormat:@"%@  ",trucktype.lastObject.displayName] : @"";
            truckLengthTypeName = trucklength.lastObject ? [NSString stringWithFormat:@"%@%@",truckLengthTypeName,trucklength.lastObject.displayName] : truckLengthTypeName;
            self.truckTypeLength = truckLengthTypeName;
            self.vehicleLengCompleteBlock(lengthId,typeId);
        }
    } filterDismiss:nil];
}

- (void)vl_addSubviews {
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = TPAdaptedFontSize(15);
    [_titleLabel setText:@"车型车长"];
    _titleLabel.textColor = TPTitleTextColor;
    [self addSubview:_titleLabel];
    
    _truckTypeLabel = [[UILabel alloc]init];
    _truckTypeLabel.font = TPAdaptedFontSize(15);
    [_truckTypeLabel setText:@"请选择车型车长"];
    _truckTypeLabel.textColor = TPPlaceholderColor;
    _truckTypeLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_truckTypeLabel];
    
    _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_cell_arrow"]];
    [self addSubview:_arrowImageView];
    
    [self vl_setupConstraints];
}

#pragma mark - Setters
- (void)setTruckTypeLength:(NSString *)truckTypeLength {
    _truckTypeLength = truckTypeLength;
    if (truckTypeLength.isNotBlank) {
        _truckTypeLabel.textColor = UIColorHex(333333);
        _truckTypeLabel.text = truckTypeLength;
    } else {
        _truckTypeLabel.textColor = TPPlaceholderColor;
        [_truckTypeLabel setText:@"请选择车型车长"];
    }
}

@end
