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



#define UUID_ACCELZ_SIGN @"FFFF0001-CAB1-DAD1-BAD2-000000000000"
#define UUID_ACCELZ_VALUE @"FFFF0001-CAB1-DAD1-BAD3-000000000000"

#define UUID_ACCELY_SIGN @"FFFF0003-CAB1-DAD1-BAD1-000000000000"
#define UUID_ACCELY_VALUE @"FFFF0003-CAB1-DAD1-BAD3-000000000000"

#define UUID_ACCELX_SIGN @"FFFF0002-CAB1-DAD1-BAD1-000000000000"
#define UUID_ACCELX_VALUE @"FFFF0002-CAB1-DAD1-BAD2-000000000000"

#define UUID_BUTTON1 @"F0001121-0451-4000-B000-000000000000"
#define UUID_BUTTON2 @"F0001122-0451-4000-B000-000000000000"

#define UUID_SERV_1 @"0180A"
#define UUID_SERV_2 @"F0001110-0451-4000-B000-000000000000"
#define UUID_SERV_3 @"F0001120-0451-4000-B000-000000000000"
#define UUID_SERV_4 @"F0001130-0451-4000-B000-000000000000"




@property (nonatomic, strong) CBCentralManager *myCentralManager;
@property (nonatomic, strong) CBPeripheral *peripheralDevice_1;
@property (nonatomic, strong) CBPeripheral *peripheralDevice_2;


@property (nonatomic, strong) NSNumber *tagAccelXValue;
@property (nonatomic, strong) NSNumber *tagAccelXSign;
@property (nonatomic, strong) NSNumber *tagAccelYValue;
@property (nonatomic, strong) NSNumber *tagAccelYSign;
@property (nonatomic, strong) NSNumber *tagAccelZValue;
@property (nonatomic, strong) NSNumber *tagAccelZSign;




//-- Labels --
@property (weak, nonatomic) IBOutlet UILabel *accelXLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelXValue;

@property (weak, nonatomic) IBOutlet UILabel *accelXSignLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelXSignValue;

@property (weak, nonatomic) IBOutlet UILabel *accelYSignLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelYSignValue;

@property (weak, nonatomic) IBOutlet UILabel *accelYLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelYValue;


@property (weak, nonatomic) IBOutlet UILabel *accelZLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelZValue;
@property (weak, nonatomic) IBOutlet UILabel *connectedStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *accelZSignLabel;
@property (weak, nonatomic) IBOutlet UILabel *accelZSignValue;

@end


