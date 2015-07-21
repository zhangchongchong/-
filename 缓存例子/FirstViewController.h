//
//  FirstViewController.h
//  缓存例子
//
//  Created by pro on 14-10-20.
//  Copyright (c) 2014年 jkrm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property(strong,nonatomic)NSURLConnection * connection;
@property(strong,nonatomic)NSURLCache * urlCache;
@property(strong,nonatomic)NSURL * url;
@property(strong,nonatomic)NSMutableURLRequest * request;
@property(strong,nonatomic)UIWebView * myWebView;
-(IBAction)reloadWebView:(UIButton *)sender;
@end
