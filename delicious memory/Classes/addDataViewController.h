//
//  addDataViewController.h
//  delicious memory
//
//  Created by Chia Lin on 2011/7/12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AudioToolbox/AudioServices.h>


@interface addDataViewController : UIViewController <UIImagePickerControllerDelegate,UIActionSheetDelegate,
                                                     UINavigationControllerDelegate >
{	
	UIImagePickerController *imagePickerController;
	UIButton *cameraBtn;
	
}

@property (nonatomic,retain) UIImagePickerController *imagePickerController;
@property (nonatomic,retain) UIButton *cameraBtn;

-(void)cameraAction;
-(void)addAction:(id)sender;
@end
