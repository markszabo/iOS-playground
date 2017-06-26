//
//  ViewController.m
//  CryptoTest
//
//  Created by Szabo Mark on 2017. 06. 22..
//  Copyright © 2017. Szabo Mark. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (IBAction)calcMD5:(id)sender {
    [self showPopupTitle:@"MD5 hash" message: [ViewController md5HexDigest:@"Random fix input"]];
}

- (IBAction)calcSHA1:(id)sender {
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    NSData *stringBytes = [@"Random fix input" dataUsingEncoding: NSUTF8StringEncoding]; /* or some other encoding */
    if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
        [self showPopupTitle:@"SHA1 hash" message:[NSString stringWithFormat:@"%s", digest]];
    }
}

- (void) showPopupTitle:(NSString*)title message:(NSString*)message
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle: title
                                message: message
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* okButton = [UIAlertAction
                               actionWithTitle:@"Ok"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle ok button
                               }];
    
    [alert addAction:okButton];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
