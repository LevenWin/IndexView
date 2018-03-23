//
//  UITableView+indexView.h
//  iOSClient
//
//  Created by leven on 2018/3/20.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BXLTableIndexView.h"

@interface UITableView (indexView)
@property (nonatomic, strong, readonly) BXLTableIndexView *lw_indexView;
@property (nonatomic, strong) NSArray <NSString *> *lw_indexArray;
@property (nonatomic, strong) UITableViewIndexConfig *lw_configuration;
@end
