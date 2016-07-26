//
//  PublishAddTagToolbar.m
//  Product-B
//
//  Created by lanou on 16/7/13.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "PublishAddTagToolbar.h"


@interface PublishAddTagToolbar()

// 顶部控件
@property (weak, nonatomic) IBOutlet UIView *topView;

// 添加按钮
@property (nonatomic, weak) UIButton *addButton;
// 存放所有的标签label
@property (nonatomic, strong) NSMutableArray *tabLables;



@end


@implementation PublishAddTagToolbar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
// 标签间距
CGFloat tagMargin = 5;
// 标签高度
CGFloat height = 20;
-(NSMutableArray *)tabLables{
    if (!_tabLables) {
        _tabLables = [NSMutableArray array];
    }
    return _tabLables;
}


-(void)awakeFromNib{
    // 添加一个加号按钮
    UIButton *addButton = [[UIButton alloc] init];
    [addButton addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
     [addButton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    // 标签间距
        addButton.size = addButton.currentImage.size;
    addButton.x = tagMargin;
    [self.topView addSubview:addButton];
    
    self.addButton = addButton;
    
    // 默认就拥有两个标签
    [self createTagLabel:@[@"吐槽", @"糗事"]];
    
}

#pragma mark --- 创建标签 ----
-(void)createTagLabel:(NSArray *)tags{
    // 为了不重复
    [self.tabLables makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tabLables removeAllObjects];
    
    for (int i = 0; i < tags.count; i ++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tabLables addObject:tagLabel];
        tagLabel.backgroundColor = [UIColor blueColor];
        tagLabel.textAlignment = NSTextAlignmentCenter;
#pragma mark ---
        tagLabel.text = tags[i];
        tagLabel.font =  [UIFont systemFontOfSize:14];
        
        //// 应该要先设置文字很字体后，在进行计算
        [tagLabel sizeToFit];
        tagLabel.width += 2 *tagMargin;
        tagLabel.height = height;
        tagLabel.textColor = [UIColor whiteColor];
#pragma mark ---  添加到头视图 ---
        [self.topView addSubview:tagLabel];
    }
    // 重新布局子控件
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.tabLables.count; i ++) {
        UILabel *tagLabel = self.tabLables[i];
        // 设置位置
        if (i == 0) {// 最前面的标签
            tagLabel.x = 0;
            tagLabel.y = 0;
            
        }else {// 其他标签
            UILabel *lastTagLabel = self.tabLables[i - 1];
            // 计算当前行  左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + tagMargin;
            // 计算当前行 右边的宽度
            CGFloat rightWidth = self.topView.width - leftWidth;
            if (rightWidth >= tagLabel.width) {
                // 按钮显示在当前行
                tagLabel.y = lastTagLabel.y;
                tagLabel.x = leftWidth;
            }else{
                tagLabel.x = 0;
                tagLabel.y = CGRectGetMaxY(lastTagLabel.frame) + tagMargin;
            }
        }
    }
    //最后一个标签
    UILabel *lastTagLabel = [self.tabLables lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + tagMargin;
    // 更新addButton的frame
    if (self.topView.width - leftWidth >= self.addButton.width) {
        self.addButton.y = lastTagLabel.y;
        self.addButton.x = leftWidth;
    }else{
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastTagLabel.frame) + tagMargin;
    }
    // 整体的高度
    CGFloat oldH = self.height;
    self.height = CGRectGetMaxY(self.addButton.frame) + 45;
    self.y -= self.height - oldH;
}


@end
