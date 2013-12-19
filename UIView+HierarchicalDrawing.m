//
//  UIView+HierarchicalDrawing.m
//  Classes
//
//  Created by Marcel Ruegenberg on 12.10.12.
//  Copyright (c) 2012 Dustlab. All rights reserved.
//

#import "UIView+HierarchicalDrawing.h"

@implementation UIView (HierarchicalDrawing)

- (void)drawHierarchy {    
    [self layoutSubviews];
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    
    CGContextTranslateCTM(c, self.frame.origin.x, self.frame.origin.y);
    
    if([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *sSelf = (UIScrollView *)self;
        CGContextTranslateCTM(c, (-1) * sSelf.contentOffset.x, (-1) * sSelf.contentOffset.y);
    }
    if(self.backgroundColor != nil) {
        CGContextSetFillColorWithColor(c, [self.backgroundColor CGColor]);
        CGContextFillRect(c, self.bounds);
    }
    
    [self drawRect:self.bounds];
    
    if(self.clipsToBounds) CGContextClipToRect(c, self.bounds);
    
    for(UIView *v in self.subviews) {
        if(v.hidden) continue;
        [v drawHierarchy];
    }
    CGContextRestoreGState(c);
}


@end
