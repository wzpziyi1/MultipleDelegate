//
//  ViewController.m
//  MethodForward
//
//  Created by wzp on 2018/9/26.
//  Copyright © 2018 wzp. All rights reserved.
//

#import "ViewController.h"
#import "ZYDelegatePorts.h"
#import "ZYHeaderBiggerPort.h"



@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (nonatomic, strong) ZYHeaderBiggerPort *headerPort;
@property (nonatomic, strong) ZYDelegatePorts *delegatePorts;

@property (nonatomic, strong) UIView *headerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layoutUI];
    self.headerPort = [[ZYHeaderBiggerPort alloc] init];
    self.headerPort.imgView = self.imgView;
    
    self.delegatePorts = [[ZYDelegatePorts alloc] init];
    [self.delegatePorts configureDelegateTargets:@[self, self.headerPort]];
    
    self.tableView.dataSource = (id<UITableViewDataSource>)self.delegatePorts;
    self.tableView.delegate   = (id<UITableViewDelegate>)self.delegatePorts;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)dealloc {
    NSLog(@"销毁成功：%s", __func__);
}

- (void)layoutUI {
    self.imgView.frame = CGRectMake(0, 0, kScreenW, 280);
    self.headerView.frame = CGRectMake(0, 0, kScreenW, 280);
    self.tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
}

#pragma mark- UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [@(indexPath.row) stringValue];
    return cell;
}

#pragma mark -- getter && setter
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor clearColor];
    }
    return _headerView;
}
@end
