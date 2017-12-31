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
@property (weak, nonatomic) IBOutlet UITextField *tagValue;
@end

@implementation ViewController

- (IBAction)logTag:(id)sender {
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:[self.tagKey text], @"key", [self.tagValue text], @"string", nil];
    [SHClientsManager.shProcessor tagViaLogline:content];
}

- (IBAction)apiTag:(id)sender {
    NSDictionary *content = [NSDictionary dictionaryWithObjectsAndKeys:[self.tagKey text], @"key", [self.tagValue text], @"string", nil];
    [SHClientsManager.shProcessor tagViaApi:content authToken: @"1JMyBIGTLLA86MxJ7nCm7kBZoSiOmJ"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing: YES];
}

@end
