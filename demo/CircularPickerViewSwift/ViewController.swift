//
//  ViewController.swift
//  CircularPickerViewSwift
//
//  Created by Sergey Sokoltsov on 12/14/16.
//  Copyright © 2016 Sergey Sokoltsov. All rights reserved.
//

import UIKit
import Foundation
import AppusCircularPickerView

class ViewController: UIViewController {
    @IBOutlet weak var circularPicker : AppusCircularPickerView?
    @IBOutlet weak var valueLabel : UILabel?
    @IBOutlet weak var lineWidthStepper : UIStepper?
    @IBOutlet weak var lineWidthLabel : UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        valueLabel?.text = String(format:"%.2f", circularPicker!.currentValue)
        lineWidthLabel?.text = String(format:"%i", NSInteger(circularPicker!.lineWidth))
        lineWidthStepper?.value = Double(circularPicker!.lineWidth)
    }

    @IBAction func switchChanged(sender: UISwitch) {
        circularPicker?.autocomplete = sender.isOn
    }

    @IBAction func circularPickerValueChanged(_ sender: AppusCircularPickerView) {
        valueLabel?.text = String(format:"%.2f", sender.currentValue)
    }

    @IBAction func lineWidthChanged(sender: UIStepper) {
        lineWidthLabel?.text = String(format:"%i", NSInteger(sender.value))
        circularPicker?.lineWidth = Float(sender.value)
    }
}

