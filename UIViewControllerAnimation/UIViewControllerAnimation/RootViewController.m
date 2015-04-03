//
//  RootViewController.m
//  UIViewControllerAnimation
//
//  Created by 王钱钧 on 15/4/3.
//  Copyright (c) 2015年 Arthur. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@implementation RootViewController


#pragma mark - UITableviewDelegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = @"test pop";
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewController *detailVC = [[ViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
