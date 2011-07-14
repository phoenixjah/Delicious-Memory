//
//  addDataViewController.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>


@interface addDataViewController : UIViewController <UIImagePickerControllerDelegate,
                                                     UINavigationControllerDelegate >
{	
	UIImagePickerController *imagePickerController;
	//OverlayViewController *overlayViewController;//the camera custom overlay view
}

//@property (nonatomic,retain) OverlayViewController *overlayViewController;
@property (nonatomic,retain) UIImagePickerController *imagePickerController;
-(IBAction)cameraAction:(id)sender;

@end
