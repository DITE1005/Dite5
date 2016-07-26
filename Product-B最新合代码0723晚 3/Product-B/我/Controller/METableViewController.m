//
//  METableViewController.m
//  Product-B
//
//  Created by lanou on 16/7/12.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "METableViewController.h"
#import "MECell.h"
#import "MeFooterView.h"
#import "SettingTableViewController.h"
#import "SquareButton.h"
#import "LoginBtViewController.h"


@interface METableViewController ()<MeFooterViewDelegate>
@property (nonatomic, assign) BOOL isClick;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *nightMode;

@property (weak, nonatomic) IBOutlet UINavigationItem *metitle;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingButton;

@end

@implementation METableViewController
- (IBAction)clickNightMode:(id)sender {
   
    
    self.isClick=!self.isClick;
    if (self.isClick==YES) {
        [self.dk_manager nightFalling];
        [sender setImage:[[UIImage imageNamed:@"summer"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
       
//        self.dk_manager.themeVersion = DKThemeVersionNight;


    }
    else{
        
        
        [self.dk_manager dawnComing];
        [sender setImage:[[UIImage imageNamed:@"bright_moon"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
//        self.dk_manager.themeVersion = DKThemeVersionNormal;

    }
    
        
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabelView];
    [self.nightMode setImage:[[UIImage imageNamed:@"bright_moon"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];

    
    
    UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2.0-50, 0, 100, 44)];
    navigationLabel.textAlignment=NSTextAlignmentCenter;
    navigationLabel.text = @"我的";
    navigationLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = navigationLabel;
    
    [self.dk_manager dawnComing];

    self.navigationController.navigationBar.dk_barTintColorPicker = DKColorPickerWithKey(BAR);
    self.settingButton.dk_tintColorPicker=DKColorPickerWithKey(TINT);
    self.tableView.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    self.tableView.dk_separatorColorPicker = DKColorPickerWithKey(SEP);
    navigationLabel.dk_textColorPicker = DKColorPickerWithKey(TEXT);

    
}
- (IBAction)neightMode:(id)sender {
//    if (!_isClick) {
//        self.tableView.backgroundColor = [UIColor blackColor];
//        self.view.backgroundColor = [UIColor blackColor];
//        SquareButton *button = [[SquareButton alloc] init];
//        button.titleLabel.textColor = [UIColor whiteColor];
//        
//    } else {
//        self.view.backgroundColor = [UIColor whiteColor];
//        SquareButton *button = [[SquareButton alloc] init];
//        button.titleLabel.textColor = [UIColor blackColor];
//    }
//    _isClick = !_isClick;
    
    
}
- (IBAction)settingItem:(id)sender {
    [self.navigationController pushViewController:[[SettingTableViewController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
    
    
    
    
    
}

- (void)setupTabelView {
    // 设置背景颜色
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[MECell class] forCellReuseIdentifier:@"ME"];
    
    // 调整header和footer
//    self.tableView.sectionHeaderHeight = 0;
//    self.tableView.sectionFooterHeight = 10;
    
    // 设置footerView
    MeFooterView *meFooterView = [[MeFooterView alloc] init];
    meFooterView.delegate = self;
    self.tableView.tableFooterView = meFooterView;
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
  
}

- (void)meFooterViewDidLoadDate:(MeFooterView *)meFooterView{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, meFooterView.height + 70, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MECell *cell = [tableView dequeueReusableCellWithIdentifier:@"ME" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"登录:注册"];
        cell.textLabel.text = @"登录/注册";
    } else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"离线下载"];
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSLog(@"--------");
        
        LoginBtViewController *loginVC=[LoginBtViewController alloc];
        [self presentViewController:loginVC animated:YES completion:nil];
        
    } else if (indexPath.section == 1) {
        NSLog(@"=========");
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
