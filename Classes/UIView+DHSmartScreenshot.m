//
//  UIView+DHSmartScreenshot.m
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/30/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import "UIView+DHSmartScreenshot.h"

@implementation UIView (DHSmartScreenshot)

- (UIImage *)screenshot
{
	return [self screenshotForCroppingRect:self.bounds];
}

- (UIImage *)screenshotForCroppingRect:(CGRect)croppingRect
{
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    [format setOpaque:NO];
    [format setScale:[UIScreen mainScreen].scale];
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:croppingRect.size format:format];
    // Create a graphics context and translate it the view we want to crop so
    // that even in grabbing (0,0), that origin point now represents the actual
    // cropping origin desired:
    UIImage *screenshotImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGContextTranslateCTM(rendererContext.CGContext, -croppingRect.origin.x, -croppingRect.origin.y);
        [self layoutIfNeeded];
        [self.layer renderInContext:rendererContext.CGContext];
    }];
        
    return screenshotImage;
}

@end
