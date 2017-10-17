//
//  UIView+BlockAction.h
//  youyue
//
//  Created by WeiHan on 5/26/17.
//  Copyright © 2017 DragonSource. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlockType)(id sender);


@interface UIView (BlockAction)

- (void)addTapGestureRecognizer:(GestureActionBlockType)block;

@end
