//
//  VerifyViewController.m
//  Product-B
//
//  Created by lanou on 16/7/22.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VerifyViewController.h"
#import "NewModel.h"
#import "XFTopicCell.h"
#import "PostViewController1.h"


@interface VerifyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (nonatomic,assign)BOOL clickAll;




@end

@implementation VerifyViewController
- (void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden =YES;
}
static NSString *reuse =@"system";


- (IBAction)clickBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)clickPost:(id)sender {
    
    PostViewController1 *postVC=[[PostViewController1 alloc]init];
    [self.navigationController pushViewController:postVC animated:YES];
    
}

- (IBAction)clickAll:(id)sender {
    
    self.clickAll=YES;
    
    
    if ( self.clickAll) {
        self.allButton.tintColor=[UIColor redColor];
        [self.allButton setTitle:@"全部^" forState:(UIControlStateNormal)];
        
        
    }
    
    else {
        self.allButton.tintColor=[UIColor blackColor];
        [self.allButton setTitle:@"全部v" forState:(UIControlStateNormal)];
        
        
        
    }
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *articleAction=[UIAlertAction actionWithTitle:@"只审文章" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self getLocalData];
        NSMutableArray *articleArray=[NSMutableArray array];
        
        for (NewModel *model in self.dataArr) {
            if ([model.type isEqualToString:@"html"]) {
                [articleArray addObject:model];
                
                
            }
        }
        
        self.dataArr=articleArray;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        }) ;
        
        
        
    }];
    
    UIAlertAction *articleAndPhotoAction=[UIAlertAction actionWithTitle:@"只审图文" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self getLocalData];
        NSMutableArray *articleAndPhotoArray=[NSMutableArray array];
        
        for (NewModel *model in self.dataArr) {
            if ([model.type isEqualToString:@"image"]||[model.type isEqualToString:@"gif"]) {
                [articleAndPhotoArray addObject:model];
                
                
            }
        }
        
        self.dataArr=articleAndPhotoArray;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        }) ;
        
        
        
    }];
    
    UIAlertAction *wordAction=[UIAlertAction actionWithTitle:@"只审段子" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self getLocalData];
        NSMutableArray *textArray=[NSMutableArray array];
        
        for (NewModel *model in self.dataArr) {
            if ([model.type isEqualToString:@"text"]) {
                [textArray addObject:model];
                
                
            }
        }
        
        self.dataArr=textArray;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        }) ;
        
        
        
    }];
    
    UIAlertAction *voiceAction=[UIAlertAction actionWithTitle:@"只审声音" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self getLocalData];
        NSMutableArray *voiceArray=[NSMutableArray array];
        
        for (NewModel *model in self.dataArr) {
            if ([model.type isEqualToString:@"voice"]) {
                [voiceArray addObject:model];
                
                
            }
        }
        
        self.dataArr=voiceArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        }) ;
        
        
    }];
    UIAlertAction *videoAction=[UIAlertAction actionWithTitle:@"只审视频" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [self getLocalData];
        NSMutableArray *videoArray=[NSMutableArray array];
        
        for (NewModel *model in self.dataArr) {
            if ([model.type isEqualToString:@"video"]) {
                [videoArray addObject:model];
                
                
            }
        }
        
        self.dataArr=videoArray;
        
        NSLog(@"%ld",self.dataArr.count);
        [self.tableView reloadData];
        
        
    }];
    
    UIAlertAction *allAction=[UIAlertAction actionWithTitle:@"全部" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self getLocalData];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self.tableView reloadData];
            
        }) ;
        
        
        
    }];
    
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        [self.tableView reloadData];
    }];
    
    [alertVC addAction:articleAction];
    [alertVC addAction:articleAndPhotoAction];
    [alertVC addAction:wordAction];
    [alertVC addAction:voiceAction];
    [alertVC addAction:videoAction];
    [alertVC addAction:allAction];
    [alertVC addAction:cancelAction];
    
    [self showDetailViewController:alertVC sender:nil];
    
    
    
    
    
}
#pragma mark ---alertVC---
- (void)alertControllerShowWithTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self showDetailViewController:alert sender:nil];//好像用show不会提示错误
    [self performSelector:@selector(alertDismiss:) withObject:alert afterDelay:1];
}

#pragma mark ---alertVC自动消失---

- (void)alertDismiss:(UIAlertController *)alert
{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initTableView];
    self.dataArr=[NSMutableArray array];
    [self requestData];
    [self getLocalData];
    
}


- (void)requestData {
    
    
    //    [RequestManager requestWithUrlString:@"http://d.api.budejie.com/topic/audit-topic/1/bs0315-iphone-4.3/0-20.json?appname=bs0315&asid=0CBD6687-21DF-4F3D-93CA-80BFE7754AFB&client=iphone&device=iPhone%205&from=ios&jbk=0&mac=&market=&openudid=d41d8cd98f00b204e9800998ecf8427e5227b17d&udid=&uid=18872910&ver=4.3" parDic:nil requestType:RequestGET finish:^(NSData *data) {
    //        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //        NSLog(@"%@",dic);
    //        self.dataArr=[@[@"1",@"2",@"3",@"4",@"5"]mutableCopy];
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //
    //            [self.tableView reloadData];
    //        });
    //
    //
    //    } error:^(NSError *error) {
    //        NSLog(@"%@",error.description);
    //    }];
    
    
}


-(void)getLocalData{
    
    
    NSString *dataPath=[[NSBundle mainBundle]pathForResource:@"check.json" ofType:nil];
    
    NSData *Data=[NSData dataWithContentsOfFile:dataPath];
    
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:Data options:NSJSONReadingMutableContainers error:nil];
    
    self.dataArr=[NewModel returnModel:dic];
    
    
    
    
    
}

-(void)initTableView
{
    
    
    //    self.tableView.contentInset = UIEdgeInsetsMake(KNaviH + 40, 0, KTabbarH, 0);
    //    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KNaviH-40-KTabbarH) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    //    // 注册cell
    //    [self.tableView registerNib:[UINib nibWithNibName:@"XFTopicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    
    
    
}

#pragma mark ---tableView相关配置---
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    return [[UIView alloc] initWithFrame:CGRectZero];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuse];
    }
    
    
    NewModel *model=self.dataArr[indexPath.row];
    
    
    if ([model.type isEqualToString:@"image"]) {
        [cell.imageView sd_setImageWithURL:model.imageDic[@"big"][0] placeholderImage:nil];
        cell.textLabel.text=model.text;
    }
    if ([model.type isEqualToString:@"video"]) {
        [cell.imageView sd_setImageWithURL:model.videoDic[@"thumbnail"][0] placeholderImage:nil];
        cell.textLabel.text=model.text;
    }
    
    return cell;
    
    
    
    
}

- (IBAction)clickReport:(id)sender {
    
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"举报" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *sexAction=[UIAlertAction actionWithTitle:@"色情" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *adAction=[UIAlertAction actionWithTitle:@"广告" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *politicsAction=[UIAlertAction actionWithTitle:@"政治" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *copyAction=[UIAlertAction actionWithTitle:@"抄袭" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *otherAction=[UIAlertAction actionWithTitle:@"其他" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:sexAction];
    [alertVC addAction:adAction];
    [alertVC addAction:politicsAction];
    [alertVC addAction:copyAction];
    [alertVC addAction:otherAction];
    [alertVC addAction:cancelAction];
    
    [self showDetailViewController:alertVC sender:nil];
    
    
}
- (IBAction)clickDing:(id)sender {
}
- (IBAction)clickCai:(id)sender {
}

- (IBAction)clickSkip:(id)sender {
}


@end
