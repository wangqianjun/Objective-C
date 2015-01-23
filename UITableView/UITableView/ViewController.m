//
//  ViewController.m
//  UITableView
//
//  Created by 王钱钧 on 15/1/21.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *data;
@property (strong, nonatomic) NSMutableArray *sections;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

// UITableView索引搜索工具类
@property (strong, nonatomic) UILocalizedIndexedCollation *collation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [[NSMutableArray alloc]initWithCapacity:6];
//    self.sectionTitles = [[NSMutableArray alloc]initWithCapacity:6];
    [self initData];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.tableView setSectionIndexColor:[UIColor grayColor]];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initData
{
    User *u1 = [[User alloc]initWithName:@"a" uid:@""];
    User *u2 = [[User alloc]initWithName:@"oe" uid:@""];
    User *u3 = [[User alloc]initWithName:@"r" uid:@""];
    User *u4 = [[User alloc]initWithName:@"pt" uid:@""];
    User *u5 = [[User alloc]initWithName:@"hu" uid:@""];
    User *u6 = [[User alloc]initWithName:@"rk" uid:@""];
       User *u7 = [[User alloc]initWithName:@"jk" uid:@""];
       User *u8 = [[User alloc]initWithName:@"dk" uid:@""];
       User *u9 = [[User alloc]initWithName:@"qk" uid:@""];
    User *u10 = [[User alloc]initWithName:@"4k" uid:@""];
    User *u11 = [[User alloc]initWithName:@"fk" uid:@""];
    User *u12= [[User alloc]initWithName:@"g" uid:@""];
    User *u13 = [[User alloc]initWithName:@"wk" uid:@""];
    User *u14 = [[User alloc]initWithName:@"tk" uid:@""];
    User *u15 = [[User alloc]initWithName:@"yk" uid:@""];
    
    [self.data addObject:u1];
    [self.data addObject:u2];
    [self.data addObject:u3];
    [self.data addObject:u4];
    [self.data addObject:u5];
    [self.data addObject:u6];
    [self.data addObject:u7];
    [self.data addObject:u8];
    [self.data addObject:u9];
    [self.data addObject:u10];
    [self.data addObject:u11];
    [self.data addObject:u12];
    [self.data addObject:u13];
    [self.data addObject:u14];
    [self.data addObject:u15];
    
    [self configureSections];
    
}

- (void)configureSections
{
    SEL selector = @selector(name);
    //获得当前UILocalizedIndexedCollation对象并且引用赋给collation
    self.collation = [UILocalizedIndexedCollation currentCollation];
    self.sectionTitles = [NSMutableArray arrayWithArray:[self.collation sectionTitles]];
    //获得索引数和section标题数
    NSInteger index, sectionTitlesCount = [[self.collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc]initWithCapacity:sectionTitlesCount];
    
    // 设置sections数组
    for (index = 0; index < sectionTitlesCount; index ++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionArray addObject:array];
    }
    
    for (User *user in self.data) {
        NSInteger sectionNumber = [self.collation sectionForObject:user collationStringSelector:selector];
        [[newSectionArray objectAtIndex:sectionNumber] addObject:user];
    }
    
    //排序
    for (NSUInteger idx = 0; idx < sectionTitlesCount; idx++) {
         NSArray *objectsForSection = [newSectionArray objectAtIndex:idx];
        [newSectionArray replaceObjectAtIndex:idx withObject:[[UILocalizedIndexedCollation currentCollation] sortedArrayFromArray:objectsForSection collationStringSelector:selector]];
    }
    
    // 移除空的section
    
    NSMutableIndexSet *removeIndextSet = [[NSMutableIndexSet alloc]init];
    [newSectionArray enumerateObjectsUsingBlock:^(NSMutableArray *obj, NSUInteger idx, BOOL *stop) {
        if ([obj count] == 0) {
//            [newSectionArray removeObject:obj];
            [removeIndextSet addIndex:idx];
        }
    }];
    [newSectionArray removeObjectsAtIndexes:removeIndextSet];

    self.sections = newSectionArray;
    [self.sectionTitles removeObjectsAtIndexes:removeIndextSet];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *dataInOnSection = [self.sections objectAtIndex:section];
    return [dataInOnSection count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSArray *dataInOnSection = [self.sections objectAtIndex:indexPath.section];
    User *user = [dataInOnSection objectAtIndex:indexPath.row];
    [cell.textLabel setText:user.name];
    
    return cell;
}

//设置section的Header
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionTitles objectAtIndex:section];
}

//设置索引标题
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView { //返回一个区域索引标题的数组
    return self.sectionTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index];
}
@end


@implementation User

- (id)init
{
    return [self initWithName:nil uid:nil];
}

- (instancetype)initWithName:(NSString *)name uid:(NSString *)uid {
    
    self = [super init];
    if (self) {
        self.name = name;
        self.uid = uid;
    }
    return self;
}
@end
