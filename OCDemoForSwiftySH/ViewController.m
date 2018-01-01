//
//  ViewController.m
//  OCDemoForSwiftySH
//
//  Created by Xingyuji on 31/12/17.
//  Copyright © 2017 com.xingyuji. All rights reserved.
//

#import "ViewController.h"
#import <SHSdkSwift/SHSdkSwift-Swift.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tagKey;
@property (weak, nonatomic) IBOutlet UITextView *syslog;
@property (weak, nonatomic) IBOutlet UILabel *appKey;
@property (weak, nonatomic) IBOutlet UILabel *host;
@property (weak, nonatomic) IBOutlet UILabel *installid;
@property (weak, nonatomic) IBOutlet UITextField *tagValue;
@end

@implementation ViewController

- (IBAction)logTag:(id)sender {
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:[self.tagKey text], @"key", [self.tagValue text], @"string", nil];
    [SHClientsManager.shProcessor tagViaLogline: content completionHandler: ^(NSDictionary<NSString *, id>* res){
        self.syslog.text = [self.syslog.text stringByAppendingString: [[@"tagging via api return: " stringByAppendingString: [NSString stringWithFormat:@"%@", res]] stringByAppendingString:@"\n"]];
    }];
}
- (IBAction)completeActivity:(id)sender {
    [SHClientsManager.shProcessor simulateNormalLogline: @"completeActivity"];
    self.syslog.text = [self.syslog.text stringByAppendingString: @"add a completeActivity logline to buffer \n"];
}
- (IBAction)clientUpgrade:(id)sender {
    [SHClientsManager.shProcessor simulateNormalLogline: @"upgradeClient"];
    self.syslog.text = [self.syslog.text stringByAppendingString: @"add a upgradeClient logline to buffer \n"];
}
- (IBAction)pushAccept:(id)sender {
    [SHClientsManager.shProcessor simulateNormalLogline: @"acceptPush"];
    self.syslog.text = [self.syslog.text stringByAppendingString: @"add an acceptPush logline to buffer \n"];
}
- (IBAction)flushLogline:(id)sender {
    [SHClientsManager.shProcessor flushBufferWithCompletionHandler:^(NSDictionary<NSString *,id> * res) {
        self.syslog.text = [self.syslog.text stringByAppendingString: [[@"Flush logline return: " stringByAppendingString: [NSString stringWithFormat:@"%@", res]] stringByAppendingString:@"\n"]];
    }];
}

- (IBAction)apiTag:(id)sender {
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:[self.tagKey text], @"key", [self.tagValue text], @"string", nil];
    [SHClientsManager.shProcessor tagViaApi:content authToken: @"1JMyBIGTLLA86MxJ7nCm7kBZoSiOmJ" completionHandler: ^(NSDictionary<NSString *, id>* res){
        self.syslog.text = [self.syslog.text stringByAppendingString: [[@"tagging via api return: " stringByAppendingString: [NSString stringWithFormat:@"%@", res]] stringByAppendingString:@"\n"]];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateSDKInfo:)
                                                 name:@"SHSetupDone"
                                               object:nil];
}

// unsubscribe when we go away
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// this method gets run when the notification is posted
// the notification's userInfo property contains the data that the app delegate provided
- (void)updateSDKInfo:(NSNotification *)notification {
    NSDictionary *info = notification.userInfo;
    if ([info objectForKey:@"host"]) {
        self.appKey.text = [SHClientsManager.shProcessor appKey];
        self.host.text = info[@"host"];
        self.syslog.text = [[@"Setting up -> host fetched: " stringByAppendingString: info[@"host"]] stringByAppendingString:@"\n"];
    } else if ([info objectForKey:@"installid"]){
        self.installid.text = info[@"installid"];
        self.syslog.text = [self.syslog.text stringByAppendingString: [[@"Setting up -> installid received: " stringByAppendingString: info[@"installid"]] stringByAppendingString:@"\n"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing: YES];
}

@end
