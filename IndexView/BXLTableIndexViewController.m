//
//  BXLTableIndexViewController.m
//  iOSClient
//
//  Created by leven on 2018/3/20.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import "BXLTableIndexViewController.h"
#import "UITableView+indexView.h"

@interface BXLTableIndexViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *brandArray;
@property (nonatomic, strong) NSArray *indexArray;
@end

@implementation BXLTableIndexViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}
#pragma mark - Private
- (void)initUI {
    self.title = @"IndexView";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    UITableViewIndexConfig *config = [UITableViewIndexConfig new];
    config.selectedBgColor = [UIColor blueColor];
    config.selectedTextColor = [UIColor whiteColor];
    config.normalTextColor = [UIColor orangeColor];
    config.dynamicSwitch = NO;
    self.tableView.lw_configuration = config;
    _brandArray = [self readLocalFileWithName:@"brands"];
    _indexArray = @[@"A",
                         @"B",
                         @"C",
                         @"D",
                        @"E",
                         @"F",
                         @"G",
                         @"H",
                         @"I",
                         @"J",
                         @"K",
                         @"L",
                         @"M",
                         @"N",
                         @"O",
                         @"P",
                         @"Q",
                         @"R",
                         @"S",
                         @"T",
                         @"U",
                    @"V",
                    @"W",
                    @"X",
                    @"Y",
                    @"Z",
                    @"#"];
    [self.tableView reloadData];
    self.tableView.lw_indexArray = _indexArray;
}

- (id)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - Actions

#pragma mark - dataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    lable.text = [NSString stringWithFormat:@"  %@",_indexArray[section]];
    lable.backgroundColor = [UIColor whiteColor];
    return lable;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *dict = _brandArray[indexPath.section][indexPath.row];
    cell.textLabel.text = dict[@"name"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _brandArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *array = _brandArray[section];
    return array.count;
}

#pragma mark - delegate

#pragma mark - Public

#pragma mark - Custom Accessors

#pragma mark - Lazy Load

#pragma mark - Other

@end
