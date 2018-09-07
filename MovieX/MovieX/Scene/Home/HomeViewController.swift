//
//  HomeViewController.swift
//  MovieX
//
//  Created by Da on 9/11/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "XXX"
        setupSideMenu()
    }

    func setupSideMenu() {
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuAnimationBackgroundColor = UIColor.white
    }
    
    @IBAction func touchMenu(_ sender: Any) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
}
