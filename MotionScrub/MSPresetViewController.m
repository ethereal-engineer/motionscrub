//
//  MSPresetViewController.m
//  MotionScrub
//
//  Created by Adam Iredale on 26/10/2013.
//  Copyright (c) 2013 Stormforge Software. All rights reserved.
//

#import "MSPresetViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface MSPresetViewController ()

@property (nonatomic, strong) AVAsset *asset;

@property (nonatomic, strong) NSArray *presets;

@end

@implementation MSPresetViewController

- (void)setAssetURL:(NSURL *)assetURL
{
    _assetURL = assetURL;
    self.asset = [AVAsset assetWithURL:assetURL];
    self.presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:_asset];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _presets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = _presets[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AVAssetExportSession *session = [AVAssetExportSession exportSessionWithAsset:_asset
                                                                      presetName:_presets[indexPath.row]];
    NSURL *outputURL = [_assetURL URLByAppendingPathExtension:@"exp.mov"];
    [session setOutputURL:outputURL];
    [session setOutputFileType:AVFileTypeQuickTimeMovie];
    [session exportAsynchronouslyWithCompletionHandler:^{
        NSLog(@"Exported");
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:outputURL
                                    completionBlock:^(NSURL *assetURL, NSError *error) {
                                        NSLog(@"Saved");
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exported"
                                                                                            message:@"Saved to Camera Roll" delegate:nil
                                                                                  cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
                                            [alert show];
                                        });
                                    }];
    }];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
