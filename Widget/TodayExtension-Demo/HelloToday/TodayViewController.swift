//
//  TodayViewController.swift
//  HelloToday
//
//  Created by Tsui on 03/04/2017.
//  Copyright © 2017 Starkrimson. All rights reserved.
//

import UIKit
import NotificationCenter
import HelloTodayKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        if #available(iOSApplicationExtension 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // Fallback on earlier versions
        }

        let userDefault = UserDefaults(suiteName: groupSuiteName)
        label.text = userDefault?.value(forKey: kTextValue) as? String ?? "sth. wrong"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(tap)
    }
    
    func tapAction() {
        guard let url = URL(string: "todayDemo://helloToday") else {
            return
        }
        extensionContext?.open(url, completionHandler: nil)
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        print(activeDisplayMode)
        print(maxSize)
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = CGSize(width: 0, height: 110)
        case .expanded:
            preferredContentSize = CGSize(width: 0, height: 220)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
