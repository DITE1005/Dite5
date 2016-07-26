//
//  FocuseViewControllerViewController.m
//  Product-B
//
//  Created by lanou on 16/7/25.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "FocuseViewControllerViewController.h"
#import "SDRPlayer.h"
#import "CaptureViewController.h"

@interface FocuseViewControllerViewController ()
@property (nonatomic, strong)CaptureViewController *Capture;
@property (nonatomic, strong)SDRPlayer *SPlayer;

@end

@implementation FocuseViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)OpenVidoBt:(UIButton *)sender {
    CaptureViewController *capVC =[CaptureViewController new];
    
    capVC.backMovieUrl=^(NSURL *fileName){
        _SPlayer=[[SDRPlayer alloc] initWithFrame:CGRectMake(0, 64, 200, 200)];
        [self.view addSubview:_SPlayer];
        [_SPlayer playViewUrl:fileName];
    };

    [self presentViewController:capVC animated:YES completion:nil];

    
    
}



-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint poitn=[touch locationInView:self.view];
    
    [UIView animateWithDuration:0.1 animations:^{
        [_SPlayer setCenter:poitn];
    }];
    NSLog(@"%f---%f",poitn.x,poitn.y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   
}


@end
