//
//  VoiceViewController.m
//  Product-B
//
//  Created by lanou on 16/7/21.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VoiceViewController.h"
//科大讯飞语音识别功能回调方法的接口文件
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

//科大讯飞语音识别功能的声音识别视图
#import "iflyMSC/IFlyRecognizerView.h"

//科大讯飞语音识别功能中定义的常量
#import "iflyMSC/IFlySpeechConstant.h"

//文字识别的回调方法接口
#import <iflyMSC/IFlySpeechSynthesizerDelegate.h>

//文字识别对象
#import <iflyMSC/IFlySpeechSynthesizer.h>



@interface VoiceViewController ()<IFlyRecognizerViewDelegate,IFlySpeechSynthesizerDelegate>




@property (weak, nonatomic) IBOutlet UITextView *textView;


//属性
@property(strong,nonatomic)IFlyRecognizerView *recognizerView;

@property(strong,nonatomic)NSMutableString *resultString;


//
@property(strong,nonatomic)IFlySpeechSynthesizer *synthesizer;



@end

@implementation VoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.title = @"声音";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(sender)];
    
    self.synthesizer = [IFlySpeechSynthesizer sharedInstance];
    self.synthesizer.delegate = self;
    
    // 声音
    [self.synthesizer setParameter:@"vinn" forKey:[IFlySpeechConstant VOICE_NAME]];
    //  速度设置文字识别完成后的语音的播放速度
    [self.synthesizer setParameter:@"100" forKey:[IFlySpeechConstant SPEED]];
    // 设置文字识别完成之后语音的播放声音（音量）
    [self.synthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    
    // 设置文字识别完成后音频的存储文件名，存储目录在Documents文件夹
    [self.synthesizer setParameter:@"temp.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    self.recognizerView = [[IFlyRecognizerView alloc]initWithCenter:self.view.center];
    self.recognizerView.delegate = self;
    
    // 语音识别的属性设置，默认json
    // 设置语音转化为的格式
    [self.recognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    
    //设置前端点检测时间为6000ms（开始检测音频的时候多久不说话则放弃检测）
    [self.recognizerView setParameter:@"6000" forKey:[IFlySpeechConstant VAD_BOS]];
    
    //设置后端点检测时间为700ms（说话完成后多久不说话则放弃检测）
    [self.recognizerView setParameter:@"500" forKey:[IFlySpeechConstant VAD_EOS]];
    
    //设置采样率为8000（决定录音的音质）
    [self.recognizerView setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置在Documents文件夹下缓存的文件名为temp.asr
    [self.recognizerView setParameter: @"temp.iat" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    NSString *path  = NSHomeDirectory();
    NSLog(@"%@________",path);
    
    //    self.recognizerView setParameter:@"asr" forKey:[IFlySpeechError IFl]
    // 开辟空间
    self.resultString = [NSMutableString new];
    
}

-(void)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法发送" message:@"没有接口" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onError:(IFlySpeechError *)error{
    NSLog(@"====%@",error);
}

// 文字转化为语音
- (IBAction)textToVoice:(UIButton *)sender {
    [self.synthesizer startSpeaking:self.textView.text];
}

// 语音转化为文字
- (IBAction)voiceToText:(UIButton *)sender {
    [self.recognizerView start];
}
- (void)onResult:(NSArray *)resultArray isLast:(BOOL) isLast{
    
    
    NSDictionary *dict = [resultArray firstObject];
    
    for (NSString *key in dict) {
        
        [self.resultString appendFormat:@"%@",key];
        
    }
    // 显示文本的视图上
    self.textView.text = self.resultString;
    
}
// 暂停
- (IBAction)suspended:(UIButton *)sender {
    
    [self.synthesizer pauseSpeaking];
    
}

- (IBAction)stop:(UIButton *)sender {
    [self.synthesizer stopSpeaking];
}

// 继续
- (IBAction)continue:(UIButton *)sender {
    [self.synthesizer resumeSpeaking];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
