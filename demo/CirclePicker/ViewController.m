//
//  ViewController.m
//  CirclePicker
//
//  Created by vladyslav.anokhin on 9/22/15.
//  Copyright (c) 2015 Appus. All rights reserved.
//

#import "ViewController.h"
#import "CircularPickerView.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineWidthLabel;


@property (weak, nonatomic) IBOutlet CircularPickerView *picker;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lineWidthLabel.text = @(self.picker.lineWidth).stringValue;
    self.valueLabel.text     = @(self.picker.defaultValue).stringValue;
}

#pragma mark - Actions

- (IBAction)switchChanged:(UISwitch *)sender {
    self.picker.autocomplete = sender.isOn;
}


- (IBAction)vladuChanged:(CircularPickerView *)sender {
    self.valueLabel.text = [NSString stringWithFormat:@"%.2f",sender.currentValue];
}


- (IBAction)lineWidthChanged:(UIStepper *)sender {
     self.lineWidthLabel.text = @(sender.value).stringValue;
     self.picker.lineWidth = sender.value;
}


@end
