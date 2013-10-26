//
//  MSViewController.m
//  MotionScrub
//
//  Created by Adam Iredale on 26/10/2013.
//  Copyright (c) 2013 Stormforge Software. All rights reserved.
//

#import "MSViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "MSPresetViewController.h"

@interface MSViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) NSURL *assetURL;

@end

@implementation MSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [super prepareForSegue:segue sender:sender];
    MSPresetViewController *presetViewController = segue.destinationViewController;
    [presetViewController setAssetURL:_assetURL];
}

- (IBAction)chooseVideoTapped:(id)sender
{
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    [pickerController setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [pickerController setDelegate:self];
    [pickerController setMediaTypes:@[(NSString *)kUTTypeMovie]];
    [self presentViewController:pickerController
                       animated:YES
                     completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    NSLog(@"Info is :%@", info);
//    AVPlayer *player = [AVPlayer playerWithURL:info[UIImagePickerControllerMediaURL]];
//    AVPlayerLayer *layer = [[AVPlayerLayer alloc] init];
//    [layer setPlayer:player];
//    [_playerLayer removeFromSuperlayer];
//    [self.view.layer addSublayer:layer];
//    [layer setFrame:self.view.bounds];
//    self.playerLayer = layer;
//    self.player = player;
//    [player setRate:1.0];
    self.assetURL = info[UIImagePickerControllerMediaURL];
    [self performSegueWithIdentifier:@"segueChoosePreset" sender:self];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UINavigationControllerDelegate (optional)

@end
