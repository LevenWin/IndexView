//
//  BXLTableIndexView.h
//  iOSClient
//
//  Created by leven on 2018/1/23.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewIndexConfig : NSObject
@property (nonatomic) CGFloat indexViewTopMargin; // default 0
@property (nonatomic) CGFloat indexViewRightpMargin; // default 2
@property (nonatomic) CGFloat indexViewItemSpace; // default 2

@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *selectedTextColor;
@property (nonatomic, strong) UIColor *selectedBgColor;
@property (nonatomic) BOOL dynamicSwitch; // default YES
@end

extern CGFloat const kIndexViewWidth;

@protocol BXLTableIndexViewDelegate<NSObject>
- (void)BXLTableIndexViewDidClickIndex:(NSString *)indexString;
@end

@interface BXLTableIndexView : UIView
@property (nonatomic, strong) UITableViewIndexConfig *configuration;
@property (nonatomic, copy, readonly) NSString *currentSelectedString;
@property (nonatomic, copy) NSArray <NSString *>*titles;
@property (nonatomic, weak) id<BXLTableIndexViewDelegate> delegate;

- (void)observeTableViewScroll:(UITableView *)tableView;
@end


