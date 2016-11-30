//
//  ViewController.m
//  Fibonacci
//
//  Created by Matsumoto Taichi on 4/7/15.
//  Copyright (c) 2015 iHeartMedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *fibTableView;
@property (nonatomic, strong) NSMutableArray<NSNumber *> *fibResultsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fibResultsArray = [[NSMutableArray<NSNumber *> alloc] init];
    
    [self getFibSequence:15];
    
    self.fibTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.fibTableView setDelegate:self];
    [self.fibTableView setDataSource:self];
    self.fibTableView.rowHeight = 90;
    [self.fibTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_resuse_id"];
    
    [self.view addSubview:self.fibTableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fibResultsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_resuse_id"];
    if (self.fibResultsArray.count > 0) {
        cell.textLabel.text = [self.fibResultsArray[indexPath.row] stringValue];
    }
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
        [self getFibSequence:self.fibResultsArray.count + 10];
        [self.fibTableView reloadData];
    }
}

-(void)getFibSequence:(NSUInteger)position {
    
    [self.fibResultsArray removeAllObjects];
    
    int first = 0;
    [self.fibResultsArray addObject:[NSNumber numberWithInt:first]];
    int second = 1;
    [self.fibResultsArray addObject:[NSNumber numberWithInt:second]];
    int result = first + second;
    
    for (int i = second+result; i < position; i++) {
        result = first + second;
        [self.fibResultsArray addObject:[NSNumber numberWithInt:result]];
        first = second;
        second = result;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
