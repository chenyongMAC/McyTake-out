//
//  UIImageView+ImageRequest.m
//  05-多线程下载图片
//
//  Created by kangkathy on 15/9/15.
//  Copyright (c) 2015年 kangkathy. All rights reserved.
//

#import "UIImageView+ImageRequest.h"

@implementation UIImageView (ImageRequest)


- (void)setImageWithURL:(NSURL *)url {
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        //下载图片数据任务在多线程中处理
            NSData *data = [NSData dataWithContentsOfURL:url];
        
            UIImage *image = [UIImage imageWithData:data];
        
        //更新UI要在主线程中处理
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.image = image;
        });
        
    });
}


@end
