//
//  TPDNearSupplyTabView.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/4.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyTabView.h"

#import "TPFilterView.h"

#import "TPDDestinationView.h"

@interface TPDNearSupplyTabView ()

@property (weak, nonatomic)   IBOutlet UIButton *destinationBtn;

@property (weak, nonatomic)   IBOutlet UIButton *carModelBtn;

@property (nonatomic, strong) TPFilterView      *filterView;

@property (nonatomic, strong) TPDDestinationView *destinationView;

@end

@implementation TPDNearSupplyTabView

- (TPFilterView *)filterView {
    if (!_filterView) {
        _filterView = [TPFilterView initWithShowRentType:NO title:nil];
    }
    return _filterView;
}

- (TPDDestinationView *)destinationView {
    if (!_destinationView) {
        _destinationView = [[TPDDestinationView alloc] initWithFrame:CGRectMake(0, 0, TPScreenWidth, TPScreenHeight)];
    }
    return _destinationView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    NSAttributedString *desAttr = [self titleString:@"目的地" imageName:@"nav_icon_down_nor" titleColor:UIColorHex(666666)];
    [self.destinationBtn setAttributedTitle:desAttr forState:UIControlStateNormal];
    
    NSAttributedString *selsectDesAttr = [self titleString:@"目的地" imageName:@"nav_icon_down_sel" titleColor:UIColorHex(6E90FF)];
    [self.destinationBtn setAttributedTitle:selsectDesAttr forState:UIControlStateSelected];

    NSAttributedString *carAttr = [self titleString:@"车型车长" imageName:@"nav_icon_down_nor" titleColor:UIColorHex(666666)];
    [self.carModelBtn setAttributedTitle:carAttr forState:UIControlStateNormal];
    
    NSAttributedString *selsectcarAttr = [self titleString:@"车型车长" imageName:@"nav_icon_down_sel" titleColor:UIColorHex(6E90FF)];
    [self.carModelBtn setAttributedTitle:selsectcarAttr forState:UIControlStateSelected];
    
}

- (NSMutableAttributedString *)titleString:(NSString *)text imageName:(NSString *)imageName titleColor:(UIColor *)color
{
    NSString * btnStr = text;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:btnStr];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, btnStr.length)];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    UIImage *image = [UIImage imageNamed:imageName];
    attachment.image = image;
    attachment.bounds = CGRectMake(3, 2, image.size.width, image.size.height);
    [attrString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
    return attrString;
}

- (IBAction)clickDestinationBtn:(id)sender {

    if (!self.destinationBtn.selected) {
        self.carModelBtn.selected = NO;
    }
    self.destinationBtn.selected = !self.destinationBtn.selected;
    
    [self showDestinationView:!self.destinationBtn.selected];
    [self showFilterView:YES];


}

- (IBAction)clickcarModelBtn:(id)sender {
    if (!self.carModelBtn.selected) {
        self.destinationBtn.selected = NO;
    }
    self.carModelBtn.selected = !self.carModelBtn.selected;
    
    [self showFilterView:!self.carModelBtn.selected];
    [self showDestinationView:YES];

}

- (void)showDestinationView:(BOOL)isDisMiss
{
    if (isDisMiss) {
        [self.destinationView disMissFilterView];
    }else {
        @weakify(self);
        [self.destinationView showViewInWindowWithTop:104 handleComplete:^(NSArray<TPDestinationItemViewModel *> *destinations) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(chooseDestination:)]) {

                NSMutableArray *temp = @[].mutableCopy;
                [destinations enumerateObjectsUsingBlock:^(TPDestinationItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [temp addObject:obj.business_line_city_id];
                }];
                
                [self.delegate chooseDestination:[temp yy_modelToJSONString]];
            }
        } filterDismiss:^{
            @strongify(self);
            self.destinationBtn.selected = NO;

        }];
    }
}

- (void)showFilterView:(BOOL)isDisMiss
{

    if (isDisMiss) {
        [self.filterView disMissFilterView];
    }else {
        [self.filterView settingItemColor:UIColorHex(FFFFFF)
                              borderColor:UIColorHex(DDDDDD)
                            selectBgColor:UIColorHex(6E90FF)
                        selectBorderColor:UIColorHex(6E90FF)];
        self.filterView.trucklengthNumber = 0;
        self.filterView.trucktypeNumber = 0;

        //self.filterView.didSelectItemIds = @[@[@"2",@"28",@"27"],@[@"2",@"26"]];
        
        @weakify(self);
        [self.filterView showFromView:self handleComplete:^(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *trucktype, NSInteger rentType, NSArray<NSArray<NSNumber *> *> *selectItems) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(chooseCarModel:typeIds:)]) {
                
                NSMutableArray *length = @[].mutableCopy;
                [trucklength enumerateObjectsUsingBlock:^(TrucklengthModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [length addObject:obj.lengthId];
                }];
                NSString *lengths = [length componentsJoinedByString:@","];
                
                NSMutableArray *type = @[].mutableCopy;
                [trucktype enumerateObjectsUsingBlock:^(TrucktypeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [type addObject:obj.typeId];
                }];
                NSString *types = [type componentsJoinedByString:@","];
                
                [self.delegate chooseCarModel:lengths typeIds:types];
            }
        } filterDismiss:^{
            @strongify(self);
            self.carModelBtn.selected = NO;
        }];

    }

}

@end
