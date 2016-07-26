//
//  SettingTableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "SettingTableViewController.h"
#import "SDImageCache.h"
#import "AboutViewController.h"
#import <StoreKit/StoreKit.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的


#import "MyTableViewCell.h"
#import "BTableViewCell.h"
#import "CTableViewCell.h"

#import <AudioToolbox/AudioToolbox.h>
#import "LZAudioTool.h"
#import "NoticeTableViewController.h"

#import "SandBoxPath.h"
#import "CleanCaches.h"




@interface SettingTableViewController ()<SKStoreProductViewControllerDelegate>

@property(nonatomic,strong)NSMutableArray *section0;
@property(nonatomic,strong)NSMutableArray *section1;


@end

@implementation SettingTableViewController

- (void)evaluate{
    
    NSString *appID=@"983841569";
    
    //初始化控制器
    SKStoreProductViewController *storeProductViewContorller = [[SKStoreProductViewController alloc] init];
    //设置代理请求为当前控制器本身
    storeProductViewContorller.delegate = self;
    //加载一个新的视图展示
    [storeProductViewContorller loadProductWithParameters:
     //appId唯一的
     @{SKStoreProductParameterITunesItemIdentifier : appID} completionBlock:^(BOOL result, NSError *error) {
         //block回调
         if(error){
             NSLog(@"error %@ with userInfo %@",error,[error userInfo]);
         }else{
             //模态弹出appstore
             [self presentViewController:storeProductViewContorller animated:YES completion:^{
                 
             }
              ];
         }
     }];
}

//取消按钮监听
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
    [viewController dismissViewControllerAnimated:YES completion:^{//viewController self也可以
        
    }];
}

//隐藏tabbar
- (void)viewWillDisappear:(BOOL)animated


{
    
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
    [self becomeFirstResponder];
}


-(NSMutableArray *)section0{
    
    
    if (!_section0) {
        
         if ([[NSUserDefaults standardUserDefaults]boolForKey:@"LoginState"]) {
             
             _section0=[NSMutableArray arrayWithObjects:@"字体大小",@"摇一摇夜间模式",@"通知设置", nil];

             
         }
         else if(![[NSUserDefaults standardUserDefaults]boolForKey:@"LoginState"]){
         
             _section0=[NSMutableArray arrayWithObjects:@"字体大小",@"摇一摇夜间模式", nil];

         }
        
        
        
        
    }
    
    return _section0;
}
-(NSMutableArray *)section1{
    
    
    if (!_section1) {
        
        
        NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
        
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app名称
        NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        // app build版本
        NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
        
        
        
      
        CGFloat size = [SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
        
        _section1=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"清除缓存(已使用%.2fMB)", size],@"推荐给朋友", @"帮助",[NSString stringWithFormat:@"当前版本：%@", app_build],@"关于我们",@"隐私政策",@"打分支持不得姐!",nil];
        
    }
    
    return _section1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
      NSLog(@"cache路径%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    
//    self.title = @"设置";
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-50, 0, 100, 44)];
    navigationLabel.textAlignment=NSTextAlignmentCenter;
    navigationLabel.text = @"设置";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);
    
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"＜返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickBack:)];
    
     self.navigationItem.leftBarButtonItem.dk_tintColorPicker=DKColorPickerWithKey(TINT);
    
    self.tableView.backgroundColor = PKCOLOR(233, 233, 233);
    self.tableView.rowHeight=51;
    [self getSize2];
   
    

    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginState"];
    
    
    

    
    
    
    
    
}

-(void)clickBack:(UIBarButtonItem *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)getSize2 {
    // 图片缓存
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]);
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    // 获取文件夹内部的所有内容
    NSArray *subPaths = [manager subpathsAtPath:cachePath];
}

- (void)getSize {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", caches);
    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:cachePath];
    NSUInteger totalSize = 0;
    
    for (NSString *fileName in fileEnumerator) {
        NSString *filePath = [cachePath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        NSLog(@"%@ -- %@", attrs, filePath);
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        totalSize += [attrs[NSFileSize] integerValue];
        
    }
    NSLog(@"%zd", totalSize);
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.section0.count;
        
    }
    
    else
    {
        
        return self.section1.count;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
  
    
    if (indexPath.section==0) {
        
        
        if (indexPath.row==1) {
            
            BTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"style2"];
            if (cell==nil) {
                cell=[[BTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"style2"];
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.text= self.section0[indexPath.row];
            cell.tag=1000;//给个tag方便获取
            return cell;

            
        }
        
         if (indexPath.row==2){
            
            MyTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"style1"];
            if (cell==nil) {
                cell=[[MyTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"style1"];
            
                    }
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text= self.section0[indexPath.row];
             return cell;
             
         }
        
        else
        {
            
            CTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"style3"];
            if (cell==nil) {
                cell=[[CTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"style3"];
                
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.textLabel.text= self.section0[indexPath.row];
            [cell.myseg addTarget:self action:@selector(clickFont:) forControlEvents:(UIControlEventValueChanged)];
            
            
            return cell;
            
            
            
        }
            

    
    
    }
    
    else {
        MyTableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"style1"];
        if (cell==nil) {
            cell=[[MyTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"style1"];
            
            
    }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text= self.section1[indexPath.row];
        
        
        return cell;

    }

}


-(void)clickFont:(UISegmentedControl *)seg{
    
    switch (seg.selectedSegmentIndex) {
        case 0:
            NSLog(@"选中小");
            break;
        case 1:
            NSLog(@"选中中");
            break;
        case 2:
            NSLog(@"选中大");
            break;
        default:
            break;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"LoginState"]==NO) {
        return 0;
    }
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
   
    
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    bottomView.backgroundColor=[UIColor lightGrayColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, bottomView.width-10*2, 40)];
    label.textColor=[UIColor grayColor];
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentLeft;
    [bottomView addSubview:label];
         if (section==0) {
             label.text=@"功能设置";
         }
         else{
             
             label.text=@"其他";
         }
    
    bottomView.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
    label.dk_textColorPicker=DKColorPickerWithKey(TEXT);
    
//    label.dk_textColorPicker=DKColorPickerWithColors();
    
    return bottomView;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    
    if (section==1) {
        
        if([[NSUserDefaults standardUserDefaults]boolForKey:@"LoginState"]==NO){
            
            return [[UIView alloc]initWithFrame:CGRectZero];

            
        }
        
        
        else{
            
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        bottomView.backgroundColor=PKCOLOR(227, 227, 227);
        UIButton *button=[UIButton buttonWithType:(UIButtonTypeSystem)];
        button.frame=CGRectMake(0, 10, kScreenWidth, 30);
        button.backgroundColor=[UIColor whiteColor];
        button.titleLabel.font=[UIFont systemFontOfSize:17];
        [button addTarget:self action:@selector(clickQuit:) forControlEvents:(UIControlEventTouchUpInside)];
        [button setTitle:@"退出当前账号" forState:(UIControlStateNormal)];
        [button setTintColor:[UIColor redColor]];
        
        [bottomView addSubview:button];
        return bottomView;
            
        }
        
        

    }
        
    return [[UIView alloc]initWithFrame:CGRectZero];
    
}

-(void)clickQuit:(UIButton *)button{
    
    
    NSLog(@"点击退出当前账号");
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出吗？" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *enterAction=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginState"];
         self.section0=[NSMutableArray arrayWithObjects:@"字体大小",@"摇一摇夜间模式", nil];
//        [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        //MS懒加载只走一次  MSfootview高度没变
        [self.tableView reloadData];
        

        
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:enterAction];
    [alertVC addAction:cancelAction];
    
    
    [self showDetailViewController:alertVC sender:nil];
    
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
   
    
    if ((indexPath.section==0)&&(indexPath.row==1)){
        NSLog(@"点击摇一摇");
        
    }
    if ((indexPath.section==0)&&(indexPath.row==2)){
        NSLog(@"通知设置");
        
        NoticeTableViewController *noticeVC=[[NoticeTableViewController alloc]init];
        [self.navigationController pushViewController:noticeVC animated:YES];
        
    }
    if ((indexPath.section==1)&&(indexPath.row==0)){
      
        
        [self clearCache];
        

        
        
    }
    
    if ((indexPath.section==1)&&(indexPath.row==1)) {
        NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];

        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"www.zhenyu54.com"]
                                          title:@"分享给朋友"
                                           type:SSDKContentTypeAuto];
        NSArray *array = [NSArray array];
        array = @[
                  @(SSDKPlatformTypeTencentWeibo),
                  @(SSDKPlatformTypeSinaWeibo),
                  @(SSDKPlatformTypeWechat)];
        [ShareSDK showShareActionSheet:nil
                                 items:array shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享成功" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           case SSDKResponseStateFail: {
                               UIAlertController *alertVc =[UIAlertController alertControllerWithTitle:@"提示" message:@"分享失败" preferredStyle: UIAlertControllerStyleAlert];
                               [alertVc addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
        
        
        
        

    }
    
    if ((indexPath.section==1)&&(indexPath.row==2)){
        
        AboutViewController *aboutVC=[[AboutViewController alloc]init];
        aboutVC.htmlStr=@"Help.html";
        aboutVC.title=@"帮助";
        [self.navigationController pushViewController:aboutVC animated:YES];
        
        
        
    }
    
    if ((indexPath.section==1)&&(indexPath.row==4)){
        
        AboutViewController *aboutVC=[[AboutViewController alloc]init];
        aboutVC.htmlStr=@"About.html";
        aboutVC.title=@"关于我们";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    if ((indexPath.section==1)&&(indexPath.row==5)){
        
        AboutViewController *aboutVC=[[AboutViewController alloc]init];
        aboutVC.htmlStr=@"Privacy.html";
        aboutVC.title=@"隐私政策";
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
    //打分支持
    if ((indexPath.section==1)&&(indexPath.row==6)) {
   
        NSLog(@"打分支持");
        //应用内弹出
        [self evaluate];
        
        //应该是之前链接写错了
        //汽车世界的
        //应用外 有返回
//        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id983841569"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

        
        
    }
    
}



#pragma mark ---清除缓存---
-(void)clearCache{
    
    
    
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       //清理cache下的
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       
                      
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       
                       //清理tmp下的
                       [CleanCaches clearCachesFromDirectoryPath:[SandBoxPath getTmpDirectory]];
                       //sdimage的
                        [[SDImageCache sharedImageCache] cleanDisk];
//                       [[SDImageCache sharedImageCache] clearDisk];

                       [self performSelectorOnMainThread:@selector(clearCacheSuccess)
                                              withObject:nil waitUntilDone:YES];});
   
}


-(void)clearCacheSuccess
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1024.0 / 1024.0;
    
    self.section1=[NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"清除缓存(已使用%.2fMB)", size],@"推荐给朋友", @"帮助",[NSString stringWithFormat:@"当前版本：%@", app_build],@"关于我们",@"隐私政策",@"打分支持不得姐!",nil];
    [self.tableView reloadData];
    
   
    [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];

    
    
    
    
}
#pragma mark ---摇一摇设置---

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    //2个bug 其他页面摇没有用 影响了button
    
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"开始摇一摇");
        
        //因为方法一直都走，所以判断
        //取得bcell cell给个tag
        BTableViewCell *cell=[self.tableView viewWithTag:1000];
       
        if (cell.myswitch.on==YES) {
            [self.dk_manager nightFalling];
            [LZAudioTool playMusic:@"dance.mp3"];

        }
        else if(cell.myswitch.on==NO){
            
            
        }
        
    }
    
    
}


#pragma mark 摇动取消
- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"摇动中断");
}


#pragma mark 摇动结束
- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    if (motion != UIEventSubtypeMotionShake)
        
        return;

    if (event.subtype == UIEventSubtypeMotionShake) {
        
        NSLog(@"摇动结束");
    }
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
