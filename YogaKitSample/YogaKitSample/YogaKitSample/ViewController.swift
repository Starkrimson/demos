//
//  ViewController.swift
//  YogaKitSample
//
//  Created by Tsui on 2018/4/6.
//  Copyright © 2018 Starkrimson. All rights reserved.
//

import UIKit
import YogaKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.configureLayout { (layout) in
            layout.isEnabled = true
//            layout.height = YGValue(UIScreen.main.bounds.height)
//            layout.width = YGValue(UIScreen.main.bounds.width)
            let bounds = UIScreen.main.bounds
            layout.aspectRatio = bounds.width / bounds.height
            layout.alignItems = .center
            layout.justifyContent = .center
        }
        
        let contentView = UIView()
        contentView.backgroundColor = .lightGray
        contentView.configureLayout { (layout) in
            layout.isEnabled = true
            layout.flexDirection = .row
            layout.width = 280
            layout.height = 80
//            layout.marginTop = 40
//            layout.marginLeft = 20
            
            layout.padding = 10
        }
        view.addSubview(contentView)
        
        let child1 = UIView()
        child1.backgroundColor = .red
        child1.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 80
            layout.flexGrow = 1
        }
        contentView.addSubview(child1)
        
        let child2 = UIView()
        child2.backgroundColor = .purple
        child2.configureLayout { (layout) in
            layout.isEnabled = true
            layout.width = 80
            layout.marginLeft = 10
            layout.height = 40
            layout.alignSelf = .flexEnd
        }
        contentView.addSubview(child2)
        
        view.yoga.applyLayout(preservingOrigin: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        view.configureLayout { (layout) in
            layout.aspectRatio = size.width / size.height
        }
        view.yoga.applyLayout(preservingOrigin: true)
    }
}

