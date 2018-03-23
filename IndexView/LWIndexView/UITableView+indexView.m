//
//  UITableView+indexView.m
//  iOSClient
//
//  Created by leven on 2018/3/20.
//  Copyright © 2018年 borderxlab. All rights reserved.
//

#import "UITableView+indexView.h"
#import <objc/runtime.h>

@implementation UITableView (indexView)
@dynamic lw_configuration,lw_indexView,lw_indexArray;

+ (void)load
{
    [self swizzledSelector:@selector(indexView_layoutSubviews) originalSelector:@selector(layoutSubviews)];
}

+ (void)swizzledSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector
{
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)indexView_layoutSubviews {
    [self indexView_layoutSubviews];
    if (self.lw_indexArray.count > 0) {
        [self.superview addSubview:self.indexView];
        CGFloat indexViewHeight = [self index_getIndexViewHeight];
        CGFloat indexViewWidth = kIndexViewWidth;
        CGFloat top = self.center.y - indexViewHeight/2 - self.lw_configuration.indexViewTopMargin;
        CGFloat left = self.frame.size.width + self.frame.origin.x - kIndexViewWidth - self.lw_configuration.indexViewRightpMargin;
        self.indexView.frame = CGRectMake(left, top, indexViewWidth, indexViewHeight);
        [self.indexView setNeedsLayout];
    }else{
        [self.indexView removeFromSuperview];
    }
}

- (CGFloat)index_getIndexViewHeight {
    return self.lw_configuration.indexViewItemSpace * (self.lw_indexArray.count - 1) + kIndexViewWidth * self.lw_indexArray.count;
}

static char kConfigurationKey;
- (UITableViewIndexConfig *)lw_configuration {
   UITableViewIndexConfig *config = objc_getAssociatedObject(self, &kConfigurationKey);
    if (!config && self.lw_indexArray.count > 0) {
        config = [UITableViewIndexConfig new];
        objc_setAssociatedObject(self, &kConfigurationKey, config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return config;
}

- (void)setLw_configuration:(UITableViewIndexConfig *)lw_configuration{
    objc_setAssociatedObject(self, &kConfigurationKey, lw_configuration, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char kIndexViewChar;
- (BXLTableIndexView *)indexView {
    BXLTableIndexView *indexView = objc_getAssociatedObject(self, &kIndexViewChar);
    if (!indexView && self.lw_indexArray.count > 0) {
        indexView = [BXLTableIndexView new];
        indexView.configuration = self.lw_configuration;
        objc_setAssociatedObject(self, &kIndexViewChar, indexView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return indexView;
}

static char kIndexArrayChar;
- (void)setLw_indexArray:(NSArray<NSString *> *)lw_indexArray{
    objc_setAssociatedObject(self, &kIndexArrayChar, lw_indexArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (lw_indexArray.count > 0) {
        self.indexView.titles = lw_indexArray;
        self.indexView.delegate = (id<BXLTableIndexViewDelegate>) self;
        [self.indexView observeTableViewScroll:self];
        [self addIndexView];
    }else{
        self.indexView.delegate = nil;
        [self removeIndexView];
    }
}

- (NSArray<NSString *> *)lw_indexArray {
    return objc_getAssociatedObject(self, &kIndexArrayChar);
}

- (void)addIndexView {
    [self.superview addSubview:self.indexView];
}

- (void)removeIndexView {
    [self.indexView removeFromSuperview];
}

- (void)BXLTableIndexViewDidClickIndex:(NSString *)indexString {
    NSInteger index = [self.lw_indexArray indexOfObject:indexString];
    NSInteger section = 0;
    if ([indexString isEqualToString:UITableViewIndexSearch]
        && index == 0) {
        section = 0;
    }else{
        section = index;
        if ([self.lw_indexArray.firstObject isEqualToString:UITableViewIndexSearch]) {
            section--;
        }
    }
    
    if (section >= self.numberOfSections) {
        section = self.numberOfSections - 1;
    }

    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

@end
