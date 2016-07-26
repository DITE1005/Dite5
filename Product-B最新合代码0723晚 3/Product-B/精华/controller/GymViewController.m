//
//  GymViewController.m
//  Product-B
//
//  Created by 灵芝 on 16/7/17.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "GymViewController.h"
#import "PersonViewController.h"
#import "TopicTableViewCell.h"
#import "GymTagTableViewController.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>//SSUI改ui的
@interface GymViewController ()<UITableViewDataSource,UITableViewDelegate>


@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UIImageView *topImageV;
@property (nonatomic,strong)UIView *topView;
@end

@implementation GymViewController

static NSString *reuse =@"topicCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    self.dataArr=[NSMutableArray array];
    [self requestData];
    
    
    
}



-(void)initTableView
{
    
    
    self.tableView.contentInset = UIEdgeInsetsMake(KNaviH + 40, 0, KTabbarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-KNaviH-40-KTabbarH) style:(UITableViewStylePlain)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    //    self.tableView.backgroundColor=[UIColor yellowColor];
    
    
    
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuse];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    [self.view addSubview:self.tableView];
    
    
    
    
    self.topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    self.topImageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    
    
    [ self.topView addSubview:self.topImageV];
    [self.tableView setTableHeaderView: self.topView];
    
    
   
    
    
    UIButton *addButton=[UIButton buttonWithType:(UIButtonTypeSystem)];
    addButton.frame=CGRectMake(kScreenWidth-80, 120, 35, 35);
    [addButton setImage:[UIImage imageNamed:@"plus_filled.png"] forState:(UIControlStateNormal)];
    [addButton setTintColor:[UIColor redColor]];
    [addButton addTarget:self action:@selector(clickAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.topView addSubview:addButton];
    
    UIButton *shareButton=[UIButton buttonWithType:(UIButtonTypeSystem)];
    shareButton.frame=CGRectMake(addButton.frame.origin.x+35, 120, 35,35);
    [shareButton setImage:[UIImage imageNamed:@"share.png"] forState:(UIControlStateNormal)];
    [shareButton setTintColor:[UIColor yellowColor]];

    [shareButton addTarget:self action:@selector(clickShare:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.topView addSubview:shareButton];
    
    
    [RequestManager requestWithUrlString:@"http://api.budejie.com/api/api_open.php?a=theme_info&appname=bs0315&asid=0CBD6687-21DF-4F3D-93CA-80BFE7754AFB&c=topic&client=iphone&device=iPhone%205&from=ios&jbk=0&mac=&market=&openudid=d41d8cd98f00b204e9800998ecf8427e5227b17d&sex=f&theme_id=735&udid=&uid=18800583&ver=4.3" parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *infoDic=dic[@"info"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.topImageV sd_setImageWithURL:[NSURL URLWithString:infoDic[@"image_detail"]] placeholderImage:nil];
            
            UILabel *tiezi=[[UILabel alloc]init];
            tiezi.frame=CGRectMake(10, 120-20, 100, 20);
            
            
            NSUInteger lenAll= [[NSString stringWithFormat:@"帖子数：%@",infoDic[@"post_number"] ] length];
            
            NSString *temp=[NSString stringWithFormat:@"帖子数：%@",infoDic[@"post_number"]];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:temp];
            
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,4)];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(4,lenAll-4)];
            
            tiezi.attributedText=str;
            
            
            
            tiezi.font=[UIFont systemFontOfSize:13];
            [self.topImageV addSubview:tiezi];
            
            UILabel *rss=[[UILabel alloc]init];
            rss.frame=CGRectMake(10, 120, 100, 20);
            
            NSUInteger lenAll2= [[NSString stringWithFormat:@"订阅人数：%@",infoDic[@"total_users"] ] length];
            NSString *tempstring=[NSString stringWithFormat:@"订阅人数：%@",infoDic[@"total_users"]];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:tempstring];
            
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,5)];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(5,lenAll2-5)];
            
            rss.attributedText=string;
            
            
            
            rss.font=[UIFont systemFontOfSize:13];

            [self.topImageV addSubview:rss];
            
            
     
            
            
            
            
            
        });
        
    } error:^(NSError *error) {
        
    }];
    
    [RequestManager requestWithUrlString:@"http://api.budejie.com/api/api_open.php?a=theme_users&appname=bs0315&asid=0CBD6687-21DF-4F3D-93CA-80BFE7754AFB&c=topic&client=iphone&device=iPhone%205&from=ios&jbk=0&mac=&market=&openudid=d41d8cd98f00b204e9800998ecf8427e5227b17d&sex=f&theme_id=735&udid=&uid=18800583&ver=4.3" parDic:nil requestType:RequestGET finish:^(NSData *data) {
        
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *topArray=dic[@"top"];
        
       
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (int i=0; i<topArray.count; i++) {
                
                UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(10+i*50,160, 30, 30)];
                
                [iconImage sd_setImageWithURL:[NSURL URLWithString:topArray[i][@"header"]] placeholderImage:[UIImage imageNamed:@"最新.png"]];
                iconImage.layer.cornerRadius=15;
                iconImage.layer.masksToBounds=YES;
                
                [ self.topView addSubview:iconImage];
                
                iconImage.userInteractionEnabled=YES;
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
                iconImage.tag=300+i;
                [iconImage addGestureRecognizer:tap];
                
                UILabel *iconLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+i*50,160+30, 50, 10)];
                iconLabel.text=topArray[i][@"name"];
                iconLabel.font=[UIFont systemFontOfSize:9];
                iconLabel.textColor=[UIColor lightGrayColor];
                [ self.topView addSubview:iconLabel];
                UIImageView *crownImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
                crownImage.image=[UIImage imageNamed:@"crown.png"];
                crownImage.transform=CGAffineTransformMakeRotation(M_PI*2*0.9);
               
                [iconImage addSubview:crownImage];
                
                
                
            }
            
            
            

            NSArray *recommendArray=dic[@"recommend"];

            UIImageView *iconImage=[[UIImageView alloc]initWithFrame:CGRectMake(10+topArray.count*50,160, 30, 30)];

            [iconImage sd_setImageWithURL:[NSURL URLWithString:recommendArray[0][@"header"]] placeholderImage:nil];
            iconImage.layer.cornerRadius=15;
            iconImage.layer.masksToBounds=YES;
            
            [ self.topView addSubview:iconImage];
            
            UILabel *iconLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+topArray.count*50,160+30, 30, 10)];
            iconLabel.text=recommendArray[0][@"name"];
            iconLabel.font=[UIFont systemFontOfSize:9];
            iconLabel.textColor=[UIColor lightGrayColor];
            [ self.topView addSubview:iconLabel];
            

            UIImageView *moreImage=[[UIImageView alloc]initWithFrame:CGRectMake(10+(topArray.count+1)*50,160, 30, 30)];
            
            moreImage.image=[UIImage imageNamed:@"cellmorebtnnormal.png"];
            moreImage.layer.cornerRadius=15;
            moreImage.layer.masksToBounds=YES;
            moreImage.userInteractionEnabled=YES;
            
            UITapGestureRecognizer *tapMore=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapMore:)];
            
            [moreImage addGestureRecognizer:tapMore];
            
            [ self.topView addSubview:moreImage];
            
            
            UILabel *moreLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+(topArray.count+1)*50,160+30, 30, 10)];
            moreLabel.text=@"更多";
            moreLabel.font=[UIFont systemFontOfSize:9];
            moreLabel.textColor=[UIColor lightGrayColor];
            [ self.topView addSubview:moreLabel];

            
            
            
        });
        
    } error:^(NSError *error) {
        
    }];
    
    

    
}

-(void)tapMore:(UITapGestureRecognizer *)tap{
    
    GymTagTableViewController *gymTagVC=[[GymTagTableViewController alloc]init];
    
    [self.navigationController pushViewController:gymTagVC animated:YES];
    
    
    
    
}

-(void)clickAdd:(UIButton *)button{
    
    
    
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *sexAction=[UIAlertAction actionWithTitle:@"发图片" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *adAction=[UIAlertAction actionWithTitle:@"发段子" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:sexAction];
    [alertVC addAction:adAction];
    
    
    [alertVC addAction:cancelAction];
    
    [self showDetailViewController:alertVC sender:nil];
    
}



-(void)clickShare:(UIButton *)button{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"提莫.jpg"]];
    //注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@""]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"www.zhenyu54.com"]
                                          title:@"分享标题"
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
-(void)tap:(UITapGestureRecognizer *)tap{
    
//    TopicTableViewCell *cell=(TopicTableViewCell *)tap.view.superview.superview;
//    
//    
//    PersonViewController *personVC = [[PersonViewController alloc] init];
//    NSIndexPath *indexPath=[self.tableView indexPathForCell:cell];
//    personVC.string = self.dataArr[indexPath.row];
//    [self.navigationController pushViewController:personVC animated:YES];
    
    
}

- (void)requestData {
    
    
    [RequestManager requestWithUrlString:KGym parDic:nil requestType:RequestGET finish:^(NSData *data) {
        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        self.dataArr=[TopicModel configModel:dic];
        dispatch_async(dispatch_get_main_queue(), ^{
          
            
            
            [self.tableView reloadData];
        });
        
        
    } error:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}



@end
