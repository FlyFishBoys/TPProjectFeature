//
//  TPDAVSpeechSynthesizer.m
//  AVSpeechSynthesizerDemo
//
//  Created by lish on 2017/8/24.
//  Copyright © 2017年 lish. All rights reserved.
//

#import "TPDAVSpeechSynthesizer.h"
@interface TPDAVSpeechSynthesizer()<AVSpeechSynthesizerDelegate>

//语音合成器
@property(nonatomic,strong,readonly)AVSpeechSynthesizer *speechSynthesizer;

@property (nonatomic,strong) AVSpeechSynthesisVoice * speechVoice;

@property(nonatomic,strong,readonly)AVSpeechUtterance *speechUtterence;

@end

@implementation TPDAVSpeechSynthesizer
+ (instancetype)sharedSyntheSize {
    static dispatch_once_t once;
    static TPDAVSpeechSynthesizer *speechSynthesizer;
    dispatch_once(&once, ^{
        speechSynthesizer = [[TPDAVSpeechSynthesizer alloc]init];
    });
    return speechSynthesizer;
}
- (instancetype)init {
    
    self = [super init];
    if (self) {
     
        _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
        _speechSynthesizer.delegate = self;
        _speechLanguage = @"zh-CH";
        _speechVoice = [AVSpeechSynthesisVoice voiceWithLanguage:_speechLanguage];
        _uRate = 0.4;

    }
    return self;
}

#pragma mark - Public Methods
- (void)startReadWithSpeechText:(NSString *)speechText{
    
    if (!speechText)
        return;
    
    [self cancleReading];
    
    if (_speechUtterence)
        _speechUtterence = nil;

    _speechUtterence = [AVSpeechUtterance speechUtteranceWithString:speechText];
    _speechUtterence.rate = _uRate;
    [_speechUtterence setVoice:[AVSpeechSynthesisVoice voiceWithLanguage:_speechLanguage]];
    [_speechSynthesizer speakUtterance:_speechUtterence];
    
}
-(void)cancleReading{
    
    if ([_speechSynthesizer isSpeaking])
        [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    _speechUtterence=nil;
    
}
-(void)continueReading{
    [_speechSynthesizer continueSpeaking];
}

-(void)pauseReading{
    if ([_speechSynthesizer isSpeaking])
        [_speechSynthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

#pragma mark - System Delegate
//开始
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    if (_speechStartBlock) {
        _speechStartBlock(synthesizer,utterance);
    }
}
//完成
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{

    if (_speechFinishBlock) {
        _speechFinishBlock(synthesizer,utterance);
    }
    _speechUtterence = nil;
}
//暂停
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    if (_speechPauseBlock) {
        _speechPauseBlock(synthesizer,utterance);
    }
}
//继续
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    if (_speechContinueBlock) {
        _speechContinueBlock(synthesizer,utterance);
    }
}
//取消
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    if (_speechCancelBlock) {
        _speechCancelBlock(synthesizer,utterance);
    }
}

#pragma mark - Getters and Setters
- (void)setSpeechLanguage:(NSString *)speechLanguage {
    _speechLanguage = speechLanguage;
}
- (void)setURate:(CGFloat)uRate {
    
    _uRate = uRate;
}
@end
