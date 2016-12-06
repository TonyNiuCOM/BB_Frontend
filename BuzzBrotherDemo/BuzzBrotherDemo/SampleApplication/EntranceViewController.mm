//
//  EntranceViewController.m
//  BuzzBrotherDemo
//
//  Created by niuhe on 04/12/2016.
//  Copyright © 2016 niuhe. All rights reserved.
//

#import "EntranceViewController.h"

@interface EntranceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pscode;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


@end

@implementation EntranceViewController

NSString *const URL = @"http://192.168.1.5:8000/";

- (void)viewDidLoad {
    [super viewDidLoad];
    _startButton.backgroundColor = [UIColor greenColor];
    _startButton.layer.borderColor = [UIColor greenColor].CGColor;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissThekeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fireTheVerifyRequest {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?passcode=%@",URL, _pscode.text]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                          timeoutInterval:10];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSLog(@"%@",[response description]);
        NSLog(@"%@",[error description]);
        if ([[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] containsString:@"OK"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                    ViewController *myVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetectionView"];
                    [self presentViewController:myVC animated:YES completion:nil];
            });
        } else dispatch_async(dispatch_get_main_queue(), ^{
            _startButton.backgroundColor = [UIColor redColor];
            _startButton.layer.borderColor = [UIColor redColor].CGColor;
            [_startButton setTitle:@"Failed, Try again" forState:UIControlStateNormal];
            [_startButton setEnabled:YES];
        });
    }];
    [dataTask resume];
}
- (IBAction)startDetecting:(id)sender {
    _startButton.backgroundColor = [UIColor yellowColor];
    _startButton.layer.borderColor = [UIColor yellowColor].CGColor;
    [_startButton setTitle:@"Processing" forState:UIControlStateNormal];
    [_startButton setEnabled:NO];
    [self fireTheVerifyRequest];
}
- (void) dismissThekeyboard {
    [self.view endEditing:YES];
}
@end
