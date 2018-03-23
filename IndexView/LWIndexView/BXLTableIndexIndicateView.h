//
//  BXLTableIndexIndicateView.h
//  iOSClient
//
//  Created by leven on 2018/1/24.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BXLTableIndexIndicateView : UIView

@property (nonatomic, copy, readonly) NSString *text;

- (void)dismissWithAnimation:(BOOL)animation;

- (void)updateWithAnchorPoint:(CGPoint)anchorPoint
                         text:(NSString *)text;
@end
