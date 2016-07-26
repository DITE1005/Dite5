//
//  TopicTableViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//


#import "TopicTableViewController.h"
#import "TopicTableViewCell.h"
#import "TopicModel.h"
#import "ShowPictureViewController.h"
#import "HtmlViewController1.h"
#import "PersonViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的

#import "CommentTableViewController.h"

//基类

@interface TopicTableViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;



@end


static NSString *reuse =@"topicCell";

@implementation TopicTableViewController

-(void)initTableView
{
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(KNaviH + 40, 0, KTabbarH, 0);
    //    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KNaviH-40-KTabbarH) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.dataArr=[NSMutableArray array];
    [self requestData];
  
    
#pragma mark ---检查网络环境---
    [[NetWorkStateManager shareInstance] reachabilityNetWorkState:^(NetWorkStateType type) {
        NSLog(@"网络状态 === %ld", type);
        
        /*
         NetWorkStateUnKnow, // 未知网络
         NetWorkStateNot, // 没有网络
         NetWorkStateWWAN, // 移动网络
         NetWorkStateWIFI // WIFI网络
         */
        
        switch (type) {
            case 0:
                [self alertControllerShowWithTitle:nil message:@"位置网络"];
                
                break;
            case 1:
                [self alertControllerShowWithTitle:nil message:@"当前没有网络，请检查网络设置"];
                
                break;
                
            case 2:
                [self alertControllerShowWithTitle:nil message:@"当前使用2G/3G/4G移动网络"];
                
                break;
                
            case 3:
//                [self alertControllerShowWithTitle:nil message:@"当前使用WIFI网络环境"];
                
                break;
                
                
            default:
                break;
        }
        
        
    }];
}


#pragma makr ---请求数据---

- (void)requestData {
    
    
    


}


-(void)clickAttention:(UIButton *)button{
    
    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    
    
    
    
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    //收藏！！数据库
    
//    if (model.isFavorite==YES) {
//        
//        UIAlertAction *canclefavoriteAction=[UIAlertAction actionWithTitle:@"取消收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//            
//          
//            
//            
//            [alertVC addAction:canclefavoriteAction];
//            
//            
//            
//            
//        }];
//    }
//    
//    if (model.isFavorite==NO) {
//        
    UIAlertAction *favoriteAction=[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        
        

        
    }];
    
    [alertVC addAction:favoriteAction];

//
//    }
//    
    
    
    
    UIAlertAction *reportAction=[UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:reportAction];
    [alertVC addAction:cancelAction];
    
    
    [self showDetailViewController:alertVC sender:nil];
    
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

    
    
   TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    
    
        TopicModel *model=self.dataArr[indexPath.row];    
        [cell.attentionButton addTarget:self action:@selector(clickAttention:) forControlEvents:(UIControlEventTouchUpInside)];
        
        cell.model=model;
        [cell configCell:model];
    
    
        [cell.photoView.FullPhoto addTarget:self action:@selector(clickFullPhoton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.htmlView.Full addTarget:self action:@selector(clickFull:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
        //不能使用同一个tap否则失效
        UITapGestureRecognizer *htmltap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
        UITapGestureRecognizer *phototap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
        UITapGestureRecognizer *videotap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPhoto:)];
    

        [cell.htmlView.imageV addGestureRecognizer:htmltap];
        [cell.photoView.imageV addGestureRecognizer:phototap];
        [cell.videoView.imageV addGestureRecognizer:videotap];
    
    UITapGestureRecognizer *tapIconImage=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIconImage:)];
    [cell.profileImageView addGestureRecognizer:tapIconImage];
    
    UITapGestureRecognizer *tapTopComment=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTopComment:)];
    [cell.topCmtContentLabel addGestureRecognizer:tapTopComment];
    

        UIButton *dingBtn = (UIButton *)[cell viewWithTag:200];
        [dingBtn addTarget:self action:@selector(clickDing:) forControlEvents:(UIControlEventTouchUpInside)];
        UIButton *caiBtn = (UIButton *)[cell viewWithTag:201];
        [caiBtn addTarget:self action:@selector(clickCai:) forControlEvents:(UIControlEventTouchUpInside)];
        UIButton *shareButton = (UIButton *)[cell viewWithTag:202];
        [shareButton addTarget:self action:@selector(clickShare:) forControlEvents:(UIControlEventTouchUpInside)];
        UIButton *commentButton = (UIButton *)[cell viewWithTag:203];
        [commentButton addTarget:self action:@selector(clickComment:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
        
    
    
    
        return cell;

    
    
    
}

-(void)tapTopComment:(UITapGestureRecognizer *)tap{
    
    
         TopicTableViewCell *cell=(TopicTableViewCell *)tap.view.superview.superview;
        CommentTableViewController *commentVC=[[CommentTableViewController alloc]init];
        
        NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
        TopicModel *model=self.dataArr[indexPath.row];
        commentVC.ID=model.ID;
        [self.navigationController pushViewController:commentVC animated:YES];
        
        
    
}

-(void)tapIconImage:(UIGestureRecognizer *)tap{
    
    //有时会崩
    
    TopicTableViewCell *cell=(TopicTableViewCell *)tap.view.superview.superview;
    PersonViewController *personVC = [[PersonViewController alloc] init];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    personVC.string =model.u[@"uid"];
    [self.navigationController pushViewController:personVC animated:YES];
    
    
}
-(void)clickShare:(UIButton *)button{
    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    
    NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];
    
    if (model.share_image) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:@[model.share_image]
                                            url:[NSURL URLWithString:model.share_url]
                                          title:model.text?model.text:@"分享标题"
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
    else {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:model.share_url]
                                          title:model.text?model.text:@"分享标题"
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
    
}
-(void)clickComment:(UIButton *)button{
    
    CommentTableViewController *commentVC=[[CommentTableViewController alloc]init];
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    commentVC.ID=model.ID;
    [self.navigationController pushViewController:commentVC animated:YES];
   
    
}
-(void)clickDing:(UIButton *)button{
    
    if (button.selected)return;
    button.selected = YES;
    
    
    //延时 如注册
//    [self performSelector:@selector(timeEnough:) withObject:nil afterDelay:1000];
    
    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    model.likeIsSelected=YES;
    NSLog(@"点击赞第%ld行",indexPath.row);
    
    
    if (model.likeIsSelected==YES) {
        
        
        
        [button setImage:[UIImage imageNamed:@"mainCellDingClick"] forState:(UIControlStateNormal)];
        [button setTitle:[NSString stringWithFormat:@"%d",[model.up intValue]+1] forState:(UIControlStateNormal)];
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            cell.dingLabel.frame = CGRectMake(button.origin.x,  model.cellHeight-button.size.height,button.size.width, button.size.height);
        } completion:^(BOOL finished) {
            cell.dingLabel.frame= CGRectMake(button.origin.x, button.origin.y, button.width, 0);
        }];
        
        
        
    }
    
    
    else if  ((model.likeIsSelected==NO)){
        

        [button setImage:[UIImage imageNamed:@"mainCellDing"] forState:(UIControlStateNormal)];
        [button setTitle:[NSString stringWithFormat:@"%@",model.up ]forState:(UIControlStateNormal)];        
        cell.dingLabel.frame= CGRectMake(button.origin.x,button.origin.y, button.width, 0);
        
        

    }
    
    
}




-(void)clickCai:(UIButton *)button{
    
    if (button.selected)return;
    
    button.selected = YES;
    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview.superview;
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    TopicModel *model=self.dataArr[indexPath.row];
    model.caiIsSelected=YES;
    NSLog(@"点击踩第%ld行",indexPath.row);
    
    
   
    
    if (model.caiIsSelected==YES) {
        
        [button setImage:[UIImage imageNamed:@"mainCellCaiClick"] forState:(UIControlStateNormal)];
        [button setTitle:[NSString stringWithFormat:@"%d",[model.down intValue]+1] forState:(UIControlStateNormal)];
        [UIView animateWithDuration:1 delay:0.0 usingSpringWithDamping:1 initialSpringVelocity:1 options:(UIViewAnimationOptionCurveEaseInOut) animations:^{
            cell.dingLabel.frame = CGRectMake(button.origin.x, model.cellHeight-button.size.height,button.size.width, button.size.height);
        } completion:^(BOOL finished) {
            cell.dingLabel.frame= CGRectMake(button.origin.x, button.origin.y, button.width, 0);
        }];
        
        
        
    }
    
    
    else if (model.caiIsSelected==NO) {

        [button setImage:[UIImage imageNamed:@"mainCellCai"] forState:(UIControlStateNormal)];
        [button setTitle:[NSString stringWithFormat:@"%@",model.down ]forState:(UIControlStateNormal)];
        cell.dingLabel.frame= CGRectMake(button.origin.x,button.origin.y, button.width, 0);
        
        
        
    }
    
 
    
}
-(void)timeEnough:(UIButton *)btn
{
    btn.selected = NO;
}
#pragma mark - tableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicModel *model = self.dataArr[indexPath.row];
    return model.cellHeight;
}

-(void)clickPhoto:(UITapGestureRecognizer *)tap{
    
    TopicTableViewCell *cell=(TopicTableViewCell *)tap.view.superview.superview;
    ShowPictureViewController *showVC=[[ShowPictureViewController alloc]init];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    showVC.model=self.dataArr[indexPath.row];
    [self.navigationController pushViewController:showVC animated:YES];
       
    
}


-(void)clickFull:(UIButton *)button{
    
    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview;
    HtmlViewController1 *htmlVC=[[HtmlViewController1 alloc]init];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    htmlVC.model=self.dataArr[indexPath.row];
    [self.navigationController pushViewController:htmlVC animated:YES];

    
    
}

-(void)clickFullPhoton:(UIButton *)button
{

    
    TopicTableViewCell *cell=(TopicTableViewCell *)button.superview.superview;
    ShowPictureViewController *showVC=[[ShowPictureViewController alloc]init];
    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
    showVC.model=self.dataArr[indexPath.row];
    [self presentViewController:showVC animated:YES completion:nil];
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TopicTableViewCell  *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
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


//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    
//    
//    NSIndexPath *indexpath =  [self.tableView indexPathForRowAtPoint:CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y)];
//    
//    NSLog(@"这是第%ld行",(long)indexpath.row);
//    TopicTableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexpath];
//    [cell.videoView.videoController pause];
//    
//    
//    
//}

@end
