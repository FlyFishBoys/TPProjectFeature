//
//  TPDAVSpeechSynthesizer.h
//  AVSpeechSynthesizerDemo
//
//  Created by lish on 2017/8/24.
//  Copyright © 2017年 lish. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
typedef void (^AVSpeechDidStartSpeech)(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence);

//完成
typedef void (^AVSpeechDidFinishSpeech)(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence);

//暂停
typedef void (^AVSpeechDidPauseSpeech)(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence);

//继续
typedef void (^AVSpeechDidContinueSpeech)(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence);

//取消
typedef void (^AVSpeechDidCancelSpeech)(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence);

@interface TPDAVSpeechSynthesizer : NSObject

@property(nonatomic,assign)CGFloat uRate;//语速

@property(nonatomic,copy)NSString *speechLanguage;//默认中文

@property(nonatomic,copy)AVSpeechDidStartSpeech speechStartBlock;

//完成回调
@property(nonatomic,copy)AVSpeechDidFinishSpeech speechFinishBlock;

//暂停回调
@property(nonatomic,copy)AVSpeechDidPauseSpeech speechPauseBlock;

//继续回调
@property(nonatomic,copy)AVSpeechDidContinueSpeech speechContinueBlock;

//取消回调
@property(nonatomic,copy)AVSpeechDidCancelSpeech speechCancelBlock;


#pragma mark - Public Methods

/**
 单例

 @return object
 */
+ (instancetype)sharedSyntheSize;


/**
 开始朗读

 @param speechText 朗读的文字
 */
- (void)startReadWithSpeechText:(NSString *)speechText;

/**
 停止朗读
 */
- (void)cancleReading;

/**
 继续朗读
 */
- (void)continueReading;

/**
 暂停朗读
 */
- (void)pauseReading;

@end
