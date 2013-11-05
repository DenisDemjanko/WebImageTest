//
//  UIImage+MultiFormat.m
//  SDWebImage
//
//  Created by Olivier Poitrey on 07/06/13.
//  Copyright (c) 2013 Dailymotion. All rights reserved.
//

#import "UIImage+MultiFormat.h"
#import "UIImage+GIF.h"
#import "NSData+Base64.h"

#ifdef SD_WEBP
#import "UIImage+WebP.h"
#endif

@implementation UIImage (MultiFormat)

+ (UIImage *)sd_imageWithData:(NSData *)data
{
    UIImage *image;

    if ([data sd_isGIF])
    {
        image = [UIImage sd_animatedGIFWithData:data];
    }
    else
    {
        image = [[UIImage alloc] initWithData:data];
    }

#ifdef SD_WEBP
    if (!image) // TODO: detect webp signature
    {
        image = [UIImage sd_imageWithWebPData:data];
    }
#endif
    
    if(!image){
        //base64
        NSString *base64 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        image = [[UIImage alloc] initWithData:[NSData dataFromBase64String:base64]];
    }

    return image;
}

@end
