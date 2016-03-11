//
//  ViewController.m
//  pullToEnlarge
//
//  Created by Lee Jay on 16/3/10.
//  Copyright © 2016年 wjpeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 图片*/
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
/** table*/
@property (nonatomic, weak) IBOutlet UITableView *tableView;
/** 上一次偏移*/
@property (nonatomic, assign) CGFloat offsetY;
/** imageView的高度*/
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *igHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *igTopCons;

@end

CGFloat const kImageViewHeight = 200.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:@"scence"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [NSString stringWithFormat:@"第%zd行",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat detal = self.offsetY - offsetY;
    
    CGFloat height = self.igHeight.constant;
    height += detal;
    if (height < kImageViewHeight) {
        height = kImageViewHeight;
    }else if(height > 2 * kImageViewHeight){
        height = 2 * kImageViewHeight;
    }
    self.igHeight.constant = height;
//    NSLog(@"offsetY=%.2f,detal=%.2f,h=%.2f",offsetY,detal,height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self setIgViewHeightcons];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [self setIgViewHeightcons];
    NSLog(@"%@;%@;",NSStringFromCGPoint(velocity),NSStringFromCGPoint(*targetContentOffset));
}

- (void)setIgViewHeightcons
{
    CGFloat height = self.igHeight.constant;
    if (height > kImageViewHeight) {
        height = kImageViewHeight;
    }
    self.igHeight.constant = height;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
