//
//  WLCustomBtn.h
//  PayReader
//
//  Created by DuBenBen on 2020/7/9.
//  Copyright © 2020 杜文亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLCustomBtn : UIButton

+ (instancetype)customWithTitle:(NSString *)title
                     titleColor:(UIColor *)color
               titleSelectColor:(UIColor *)selectColor
                          image:(NSString *)image
                    selectImage:(NSString *)selectImage
                            tag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
