//
//  ViewController.m
//  IphoneImages
//
//  Created by Spencer Symington on 2019-01-24.
//  Copyright © 2019 Spencer Symington. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (strong,nonatomic) NSArray<NSURL*> *phoneURLS;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.phoneURLS = @[ [NSURL URLWithString:@"https://i.imgur.com/zdwdenZ.png"],
                        [NSURL URLWithString:@"https://i.imgur.com/CoQ8aNl.png"],
                        [NSURL URLWithString:@"https://i.imgur.com/bktnImE.png"],
                        [NSURL URLWithString:@"https://i.imgur.com/2vQtZBb.png"],
                        [NSURL URLWithString:@"https://i.imgur.com/y9MIaCS.png"]];
    
    
    [self showRandomPhone];
    
}
- (IBAction)buttonPressed:(id)sender {
    [self showRandomPhone];
}
-(NSURL*)getRandomPhone{
    int rand = arc4random_uniform(5);
    return self.phoneURLS[rand];
}
-(void)showRandomPhone{
    NSURL *url = [self getRandomPhone];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) { // 1
            // Handle the error
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data]; // 2
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // This will run on the main queue
            
            self.myImage.image = image; // 4
        }];
        
    }];
    
    [downloadTask resume]; // 5
}


@end
