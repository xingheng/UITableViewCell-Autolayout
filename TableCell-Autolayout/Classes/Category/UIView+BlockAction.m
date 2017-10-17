//
//  UIView+BlockAction.m
//  youyue
//
//  Created by WeiHan on 5/26/17.
//  Copyright © 2017 DragonSource. All rights reserved.
//

#import "UIView+BlockAction.h"
@import ObjectiveC.runtime;

#pragma mark - UIGestureRecognizer (BlockAction)

@interface UIGestureRecognizer (BlockAction)

@property (nonatomic, copy) GestureActionBlockType gestureHandlerBlock;

@end

@implementation UIGestureRecognizer (BlockAction)

- (void)setGestureHandlerBlock:(GestureActionBlockType)gestureHandlerBlock
{
    objc_setAssociatedObject(self, @selector(gestureHandlerBlock), gestureHandlerBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (GestureActionBlockType)gestureHandlerBlock
{
    return objc_getAssociatedObject(self, @selector(gestureHandlerBlock));
}

@end

#pragma mark - UIView (BlockAction)

@implementation UIView (BlockAction)

- (void)addTapGestureRecognizer:(GestureActionBlockType)block
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bk_tapGestureHandlerAction:)];
    [self addGestureRecognizer:tapGesture];

    tapGesture.gestureHandlerBlock = block;
}

- (void)bk_tapGestureHandlerAction:(id)sender
{
    UITapGestureRecognizer *tapGesture = sender;

    if (tapGesture.gestureHandlerBlock) {
        tapGesture.gestureHandlerBlock(sender);
    }
}

@end
