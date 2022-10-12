//
//  MViewController.m
//  MDataAccessSafe
//
//  Created by 梅洋 on 10/12/2022.
//  Copyright (c) 2022 梅洋. All rights reserved.
//

#import "MViewController.h"
#import <Masonry/Masonry.h>

@interface MViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation MViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadUI];
}

#pragma mark ---- 加载视图
- (void)loadUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark ---- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.dataArray objectAtIndex:indexPath.row]);
    switch (indexPath.row) {
        case 0: {
            // 可变数组越界
            NSArray *array = @[@"1", @"2", @"3"];
            id result = [array objectAtIndex:3];
            NSLog(@"result -- %@", (NSString *)result);
        }
            break;
        case 1: {
            // 不可变数组越界
            
        }
            break;
        case 2: {
            // 可变字典存nil
            
        }
            break;
        case 3: {
            // 不可变字典存nil
            
        }
            break;
        default:
            break;
    }
}

#pragma mark ---- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---- lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"可变数组越界", @"不可变数组越界", @"可变字典存nil", @"不可变字典存nil"];
    }
    return _dataArray;
}

- (void)dealloc {
    NSLog(@"dealloc -- %@", [self class]);
}


@end
