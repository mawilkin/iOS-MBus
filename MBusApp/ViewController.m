//
//  ViewController.m
//  MBusApp
//
//  Created by Max Wilkinson on 8/18/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Sizes for webview
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenBound.size.height;
    
    self.webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, screenHeight-20)];
    NSURL *nsurl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"complete" ofType:@"html"]];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    
    [self.webview loadRequest:nsrequest];
    [self.view addSubview:self.webview];
    
    UIView *statusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    statusBar.backgroundColor = [UIColor colorWithRed:0 green:0.153 blue:0.298 alpha:1];
    [self.view addSubview:statusBar];
    
    NSLog(@"value of screenHeight: %f", screenHeight);
    
    //Set up Splash Screen
    self.coverImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight)];
    self.coverImage.contentMode = UIViewContentModeScaleToFill;
    
    if (screenHeight < 568.0) {
        self.coverImage.image = [UIImage imageNamed:@"SplashScreen_Small"];
    } else {
        self.coverImage.image = [UIImage imageNamed:@"SplashScreen"];
    }
    
    //Display Splash Screen
    if (screenHeight < 568.0 || [[UIDevice currentDevice].model isEqualToString:@"iPod touch"]) {
        [self performSelector:@selector(hideCover) withObject:nil afterDelay:3.0];
    } else {
        [self performSelector:@selector(hideCover) withObject:nil afterDelay:2.0];
    }
    
    [self.view addSubview:self.coverImage];
    
    
}

- (void)hideCover
{
    self.coverImage.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
