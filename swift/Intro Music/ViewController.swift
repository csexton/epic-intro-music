//
//  ViewController.swift
//  Intro Music
//
//  Created by Christopher Sexton on 9/21/14.
//  Copyright (c) 2014 Radius Networks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet var text: UITextField!
  @IBOutlet weak var button: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    text.text = NSUserDefaults.standardUserDefaults().stringForKey("name")

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    NSUserDefaults.standardUserDefaults().setObject(textField.text, forKey:"name")
    NSUserDefaults.standardUserDefaults().synchronize()
    textField.resignFirstResponder()

    return true
  }

  


}

