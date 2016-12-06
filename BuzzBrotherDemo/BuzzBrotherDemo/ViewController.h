//
//  ViewController.h
//  BuzzBrotherDemo
//
//  Created by niuhe on 01/12/2016.
//  Copyright © 2016 niuhe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageTargetView.h"
#import "SampleApplicationSession.h"
#import <Vuforia/Vuforia.h>
#import <Vuforia/TrackerManager.h>
#import <Vuforia/ObjectTracker.h>
#import <Vuforia/Trackable.h>
#import <Vuforia/DataSet.h>
#import <Vuforia/CameraDevice.h>
#import "AppDelegate.h"

#import <Vuforia/DataSet.h>

@interface ViewController : UIViewController <SampleApplicationControl> {
    Vuforia::DataSet*  dataSetCurrent;
    Vuforia::DataSet*  dataSetTarmac;
    Vuforia::DataSet*  dataSetStonesAndChips;
}
@property (nonatomic, strong) ImageTargetView* tarView;
@property (nonatomic, strong) UITapGestureRecognizer * tapGestureRecognizer;
@property (nonatomic, strong) SampleApplicationSession * vapp;




@end

