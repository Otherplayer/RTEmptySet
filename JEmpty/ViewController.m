//
//  ViewController.m
//  JEmpty
//
//  Created by __无邪_ on 3/8/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Empty.h"
#import "HYQHelperReachibility.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.datas = [[NSMutableArray alloc] init];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataVerticalOffset = -100;
    self.tableView.loadedImageName = @"ios_default_face";
    self.tableView.loading = YES;
    
    double delayInSeconds = 3;
    dispatch_time_t delayInNanoSeconds =dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    // 得到全局队列
    dispatch_queue_t concurrentQueue = dispatch_get_main_queue();
    // 延期执行
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        
        for (int i = 0; i < 100; i ++) {
            [self.datas addObject:@""];
        }

        self.tableView.loading = NO;
        [self.tableView reloadData];

    });

    [self.tableView clickLoading:^{
        
        for (int i = 0; i < 100; i ++) {
            [self.datas addObject:@""];
        }
        self.tableView.loading = NO;
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clearAction:(id)sender {
    
    [self.datas removeAllObjects];
    [self.tableView reloadData];
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"identifier2cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifierCell];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - configure

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}




@end
