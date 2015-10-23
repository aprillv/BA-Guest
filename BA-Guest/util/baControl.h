//
//  baControl.h
//  BuildersAccess
//
//  Created by roberto ramirez on 9/24/13.
//  Copyright (c) 2013 eloveit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface baControl : NSObject

//+ (UIButton *) getGrayButton;

-(UIView *)GetCommenFrame1: (float)xw andxh: (float)xh;
-(UIView *)GetCommenFrame2: (float)xw andxh: (float)xh;
-(UIView *)GetCommenFrame100: (float)xw andxh: (float)xh;
-(UIView *)GetCommenFrame101: (float)xw andxh: (float)xh;


-(UIView *)GetCommenFrame100r: (float)xw andxh: (float)xh;
-(UIView *)GetCommenFrame101r: (float)xw andxh: (float)xh;

- (UIButton *) getButton:(UIColor *)co andrect:(CGRect)tttt;
-(UIButton *)getButton1:(UIColor *)co andrect:(CGRect)tttt andradius:(float)f;
@end
