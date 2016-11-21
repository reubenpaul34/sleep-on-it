//
//  ViewController.m
//  SensortagBleReceiver
//
//  Created by Yuuki Nishiyama on 2015/09/05.
//  Copyright (c) 2015年 Yuuki NISHIYAMA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    double latitude;
    double longitude;
    double altitude;
    bool eventState;
}

@end

@implementation ViewController

NSString *UUID_KEY = @"CC2650 SensorTag";
NSString *UUID = @"";
int accRange = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    eventState = true;
    accRange = ACC_RANGE_4G;
    // Do any additional setup after loading the view, typically from a nib.
    _myCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"centralManagerDidUpdateState");
    if([central state] == CBCentralManagerStatePoweredOff){
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }else if([central state] == CBCentralManagerStatePoweredOn){
        NSLog(@"CoreBluetooth BLE hardware is powered on");
        //NSArray *services = @[[CBUUID UUIDWithString:SENSORTAG_SERVICE_UUID]];
        [central scanForPeripheralsWithServices:nil options:nil];
    }else if([central state] == CBCentralManagerStateUnauthorized){
        NSLog(@"CoreBluetooth BLE hardware is unauthorized");
    }else if([central state] == CBCentralManagerStateUnknown){
        NSLog(@"CoreBluetooth BLE hardware is unknown");
    }else if([central state] == CBCentralManagerStateUnsupported){
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}




- (void) centralManager:(CBCentralManager *)central
  didDiscoverPeripheral:(CBPeripheral *)peripheral
      advertisementData:(NSDictionary *)advertisementData
                   RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discovered %@", peripheral.name);
    NSLog(@"UUID %@", peripheral.identifier);
    NSLog(@"%@", peripheral);
    _peripheralDevice = peripheral;
    _peripheralDevice.delegate = self;
    if([peripheral.name isEqualToString:@"Project Zero"])
        [_myCentralManager connectPeripheral:_peripheralDevice options:nil];
    
}



- (void) centralManager:(CBCentralManager *) central
   didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral connected");
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    [central stopScan];
}



- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered service %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}




- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", characteristic);
        NSLog(@"This is the %@", characteristic.UUID);
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BUTTON0]]){
            //[peripheral readValueForCharacteristic:characteristic];
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        } else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BUTTON1]]){
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            //[peripheral readValueForCharacteristic:characteristic];
        }
    }
}



- (CBCharacteristic *) getCharateristicWithUUID:(NSString *)uuid from:(CBService *) cbService
{
    for (CBCharacteristic *characteristic in cbService.characteristics) {
        if([characteristic.UUID isEqual:[CBUUID UUIDWithString:uuid]]){
            return characteristic;
        }
    }
    return nil;
}


- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error
{
    if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BUTTON1]]){
        [self getMotionData:characteristic.value];
        NSLog(@"BUTTON 1 GETTING");
    } else if([characteristic.UUID isEqual:[CBUUID UUIDWithString:UUID_BUTTON0]]){
        [self getHumidityData:characteristic.value];
        NSLog(@"BUTTON 0 GETTING %@", characteristic.value);
    }
    
    if (error) {
        
        NSLog(@"Error changing notification state: %@",
              
              [error localizedDescription]);
        
    }
}



- (void) getHumidityData:(NSData *)data{
    const Byte *orgBytes = [data bytes];
    int16_t hum = *orgBytes;
    _tagHum = [[NSNumber alloc] initWithFloat:hum];
    NSLog(@"Getting there");
    [_humLabel setText:[_tagHum stringValue]];
}

- (void) getMotionData:(NSData *) data
{
    const Byte *orgBytes = [data bytes];
    int16_t hum = *orgBytes;
    _tagHum = [[NSNumber alloc] initWithFloat:hum];
    NSLog(@"Getting there2");
    [_objTempLabel setText:[_tagHum stringValue]];
}


@end