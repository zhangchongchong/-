//
//  FirstViewController.m
//  缓存例子
//
//  Created by pro on 14-10-20.
//  Copyright (c) 2014年 jkrm. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 100, 320, 360)];
    [self.view addSubview:self.myWebView];
    NSString * paramURLAsString=@"http://blog.sina.com.cn/u/2526279194";
    self.urlCache=[NSURLCache sharedURLCache];
   //设置缓存大小
    [self.urlCache setMemoryCapacity:1*1024*1024];
    self.url=[NSURL URLWithString:paramURLAsString];
    self.request=[NSMutableURLRequest requestWithURL:self.url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
    [self.myWebView loadRequest:self.request];
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"链接" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(100, 50, 50, 30)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(reloadWebView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
-(IBAction)reloadWebView:(UIButton *)sender{
    NSLog(@"哈哈哈哈");
    //从请求中获取缓存输出
    NSCachedURLResponse * request=[self.urlCache cachedResponseForRequest:self.request];
    //判断是否有缓存
    if (request!=nil) {
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [self.request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
            }
    [self.myWebView loadRequest:self.request];
    self.connection=nil;
    NSURLConnection * newconnetion=[[NSURLConnection alloc]initWithRequest:self.request delegate:self startImmediately:YES];

    self.connection=newconnetion;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"将接受输出");
}
-(NSURLRequest*)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"即将发送请求");
    return (request);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"接受数据");
    NSLog(@"数据长度为＝%lu",(unsigned long)[data length]);
}
-(NSCachedURLResponse*)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse{
    NSLog(@"将缓存输出");
    return (cachedResponse);
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"请求完成");
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"请求失败");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
