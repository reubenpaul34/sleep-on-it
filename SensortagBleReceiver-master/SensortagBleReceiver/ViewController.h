//
//  ViewController.h
//  SensortagBleReceiver
//
//  Created by Yuuki Nishiyama on 2015/09/05.
//  Copyright (c) 2015年 Yuuki NISHIYAMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>



#define UUID_BUTTON1 @"F0001121-0451-4000-B000-000000000000"
#define UUID_BUTTON2 @"F0001122-0451-4000-B000-000000000000"



@property (nonatomic, strong) CBCentralManager *myCentralManager;
@property (nonatomic, strong) CBPeripheral *peripheralDevice;




@property (nonatomic, strong) NSNumber *tagHum;




//-- Labels --

@property (weak, nonatomic) IBOutlet UILabel *gyrozLabel;
@property (weak, nonatomic) IBOutlet UILabel *humLabel;
@property (weak, nonatomic) IBOutlet UILabel *objTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *ambTempLabel;



@end


