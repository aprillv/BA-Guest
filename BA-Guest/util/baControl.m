//
//  baControl.m
//  BuildersAccess
//
//  Created by roberto ramirez on 9/24/13.
//  Copyright (c) 2013 eloveit. All rights reserved.
//

#import "baControl.h"
#import "Mysql.h"
//#import "NSString+Color.h"
#import <QuartzCore/QuartzCore.h>

@implementation baControl

+ (UIButton *) getGrayButton{
    
   UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
     [loginButton setBackgroundImage:[[UIImage imageNamed:@"grayButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    loginButton.layer.cornerRadius = 5.0;
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return loginButton;
    
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (UIImage *) roundCorners:(UIImage*)img withRadius:(float)radius {
	int w = img.size.width;
	int h = img.size.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
	
	CGContextBeginPath(context);
	CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
	addRoundedRectToPath(context, rect, radius, radius);
	CGContextClosePath(context);
	CGContextClip(context);
	
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
	
	CGImageRef imageMasked = CGBitmapContextCreateImage(context);
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	return [UIImage imageWithCGImage:imageMasked];
}



- (UIButton *) getButton:(UIColor *)co andrect:(CGRect)tttt{
    return [self getButton1:co andrect:tttt andradius:5.0f];
    
}

-(UIButton *)getButton1:(UIColor *)co andrect:(CGRect)tttt andradius:(float)f{
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    Mysql *mq =[[Mysql alloc]init];
    UIImage *roundedImage = [self roundCorners:[mq createImageWithColor:co withrect:tttt]  withRadius:f];
    [loginButton setBackgroundImage:[roundedImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return loginButton;
}


-(UIView *)GetCommenFrame1: (float)xw andxh: (float)xh{
    return [self GetCommenFrame:xw andxh:xh andimg:@"top1.gif" andtitle:@"Guest Registration"];
}

-(UIView *)GetCommenFrame2: (float)xw andxh: (float)xh{
    return [self GetCommenFrame:xw andxh:xh andimg:@"top1.gif" andtitle:@"Future Resident Registration"];
}


-(UIView *)GetCommenFrame100: (float)xw andxh: (float)xh{
    return [self GetCommenFrame1:xw andxh:xh andimg:@"lovettlogo.png" andtitle:@"Future Resident Registration"];
}

-(UIView *)GetCommenFrame100r: (float)xw andxh: (float)xh{
    return [self GetCommenFrame2:xw andxh:xh andimg:@"lovettlogo.png" andtitle:@"Future Resident Registration"];
}

-(UIView *)GetCommenFrame101: (float)xw andxh: (float)xh{
    return [self GetCommenFrame1:xw andxh:xh andimg:@"intownlogo.png" andtitle:@"Future Resident Registration"];
}

-(UIView *)GetCommenFrame101r: (float)xw andxh: (float)xh{
    return [self GetCommenFrame2:xw andxh:xh andimg:@"intownlogo.png" andtitle:@"Future Resident Registration"];
}



-(UIView *)GetCommenFrame: (float)xw andxh: (float)xh andimg:(NSString *)imgnm andtitle:(NSString *)stitle{
    UIView *aaaa=[[UIView alloc]initWithFrame:CGRectMake(0, 0, xw, xh-1)];
    aaaa.backgroundColor=[UIColor whiteColor];
    UIView *v1 =[[UIView alloc]initWithFrame:CGRectMake(10, 0, xw-20, 120)];
    [aaaa addSubview:v1];
    
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgnm]];
    [v1 addSubview:iv];
    UILabel *tt =[[UILabel alloc]initWithFrame:CGRectMake(390, 38, 500, 50)];
    if ([stitle hasPrefix:@"Future"]) {
        tt =[[UILabel alloc]initWithFrame:CGRectMake(340, 20, 500, 50)];
    }
    tt.text=stitle;
    tt.font=[UIFont boldSystemFontOfSize:25.0f];
    [v1 addSubview:tt];
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 120, xw, 20)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [aaaa addSubview:v2];
    
    
    v2=[[UIView alloc]initWithFrame:CGRectMake(0, xh-45, xw, 44)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [aaaa addSubview:v2];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, xw-20, 40)];
    lbl.text=@"Copyright © 2014 All Rights Reserved";
    lbl.font=[UIFont systemFontOfSize:14.0f];
    lbl.backgroundColor=[UIColor clearColor];
    [v2 addSubview:lbl];
    
    return aaaa;
}


-(UIView *)GetCommenFrame1: (float)xw andxh: (float)xh andimg:(NSString *)imgnm andtitle:(NSString *)stitle{
    UIView *aaaa=[[UIView alloc]initWithFrame:CGRectMake(0, 0, xw, xh-1)];
    aaaa.backgroundColor=[UIColor whiteColor];
    UIView *v1 =[[UIView alloc]initWithFrame:CGRectMake(10, 0, xw-20, 90)];
    [aaaa addSubview:v1];
    
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgnm]];
    [v1 addSubview:iv];
    UILabel *tt =[[UILabel alloc]initWithFrame:CGRectMake(340, 20, 500, 50)];
    tt.text=stitle;
    tt.font=[UIFont boldSystemFontOfSize:25.0f];
    [v1 addSubview:tt];
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 95, xw, 20)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [aaaa addSubview:v2];
    
    
    return aaaa;
}


-(UIView *)GetCommenFrame2: (float)xw andxh: (float)xh andimg:(NSString *)imgnm andtitle:(NSString *)stitle{
    UIView *aaaa=[[UIView alloc]initWithFrame:CGRectMake(0, 0, xw, xh-1)];
    aaaa.backgroundColor=[UIColor whiteColor];
    UIView *v1 =[[UIView alloc]initWithFrame:CGRectMake(10, 0, xw-20, 90)];
    [aaaa addSubview:v1];
    
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:imgnm]];
    [v1 addSubview:iv];
    UILabel *tt =[[UILabel alloc]initWithFrame:CGRectMake(340, 20, 500, 50)];
    tt.text=stitle;
   tt.font=[UIFont boldSystemFontOfSize:25.0f];
    [v1 addSubview:tt];
    UIView *v2=[[UIView alloc]initWithFrame:CGRectMake(0, 95, xw, 20)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [aaaa addSubview:v2];
    
    v2=[[UIView alloc]initWithFrame:CGRectMake(0, xh-45, xw, 44)];
    v2.backgroundColor=[UIColor lightGrayColor];
    [aaaa addSubview:v2];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 2, xw-20, 40)];
    lbl.text=@"Copyright © 2014 All Rights Reserved";
    lbl.font=[UIFont systemFontOfSize:14.0f];
    lbl.backgroundColor=[UIColor clearColor];
    [v2 addSubview:lbl];
    return aaaa;
}

@end
