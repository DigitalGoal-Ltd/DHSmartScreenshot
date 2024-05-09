//
//  UIImage+ImageFromArrayUtils.m
//  TableViewScreenshots
//
//  Created by Hernandez Alvarez, David on 11/28/13.
//  Copyright (c) 2013 David Hernandez. All rights reserved.
//

#import "UIImage+DHImageAdditions.h"

@implementation UIImage (DHImageUtils)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    [format setOpaque:NO];
    [format setScale:[UIScreen mainScreen].scale];
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size format:format];
    
    UIImage *image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        [color set];
        CGContextFillRect(rendererContext.CGContext, CGRectMake(0.f, 0.f, size.width, size.height));
    }];

    return image;
}

@end

@implementation UIImage (DHImageFromArrayUtils)

+ (UIImage *)verticalImageFromArray:(NSArray *)imagesArray
{
	UIImage *unifiedImage = nil;
	CGSize totalImageSize = [self verticalAppendedTotalImageSizeFromImagesArray:imagesArray];
    
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    [format setOpaque:NO];
    [format setScale:0.f];
    UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:totalImageSize format:format];
    
    unifiedImage = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        // For each image found in the array, create a new big image vertically
        CGFloat imageOffsetFactor = 0.0f;
        for (UIImage *img in imagesArray) {
            [img drawAtPoint:CGPointMake(0, imageOffsetFactor)];
            imageOffsetFactor += img.size.height;
        }
    }];

	return unifiedImage;
}

+ (CGSize)verticalAppendedTotalImageSizeFromImagesArray:(NSArray *)imagesArray
{
	CGSize totalSize = CGSizeZero;
	for (UIImage *im in imagesArray) {
		CGSize imSize = [im size];
		totalSize.height += imSize.height;
		// The total width is gonna be always the wider found on the array
		totalSize.width = MAX(totalSize.width, imSize.width);
	}
	return totalSize;
}

@end
