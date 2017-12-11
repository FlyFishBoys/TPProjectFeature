//
//  TPHomeWebViewCell.m
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeWebViewCell.h"
#import "TPWebView.h"

@interface TPDHomeWebViewCell()

@property (nonatomic , strong) TPWebView *webView;

@end
@implementation TPDHomeWebViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = TPBackgroundColor;
        [self addSubview:self.webView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self).offset(TPAdaptedHeight(10));
        make.size.bottom.equalTo(self);
    }];
}
- (TPWebView *)webView
{
    if (!_webView) {
        
        _webView = [[TPWebView alloc]init];
        _webView.backgroundColor = TPWhiteColor;
       [_webView loadRequestWithURLString:_webURL];
       
    }
    return _webView;
}

- (void)setWebURL:(NSString *)webURL {
    
    
  if (![_webURL isEqualToString:webURL]) {
        _webURL = webURL;
        [_webView refreshRequestWithURLString:_webURL];
  }
 
}
@end
