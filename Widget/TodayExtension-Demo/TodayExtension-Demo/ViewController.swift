//
//  ViewController.swift
//  TodayExtension-Demo
//
//  Created by Tsui on 03/04/2017.
//  Copyright © 2017 Starkrimson. All rights reserved.
//

import UIKit
import HelloTodayKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let userDefault = UserDefaults(suiteName: groupSuiteName)
        userDefault?.set(textView.text, forKey: kTextValue)
        userDefault?.synchronize()
    }
    
}
