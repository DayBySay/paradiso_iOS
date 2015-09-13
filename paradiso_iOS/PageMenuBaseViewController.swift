//
//  PageMenuBaseViewController.swift
//  paradiso_iOS
//
//  Created by 清 貴幸 on 2015/09/12.
//  Copyright © 2015年 Team Paradiso. All rights reserved.
//

import UIKit
import PageMenu

 @objc protocol ParadisoPageMenuDelegate {
    func menuTitle() -> String
    func pageMenu(pageMenu: CAPSPageMenu, didTouchUpRightBarButton: UIBarButtonItem) -> String?
}

class PageMenuBaseViewController: UIViewController, CAPSPageMenuDelegate {
    var pageMenu :CAPSPageMenu?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = "Paradiso"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.Done, target: self, action: "didTapRightMenu")
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllers : [UIViewController] = []
        let firstViewController = self.storyboard?.instantiateViewControllerWithIdentifier("VideoFeedsTableViewController")
        firstViewController?.title = "Feed"
        controllers.append(firstViewController!)
        let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DownloadedVideosTableViewController")
        secondViewController?.title = "Downloaded"
        controllers.append(secondViewController!)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllers, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu?.delegate = self
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMoveToParentViewController(self)
    }
    
    func didTapRightMenu() {
        guard let currentPageIndex = pageMenu?.currentPageIndex else {
            return
        }
        
        let controller = pageMenu?.controllerArray[currentPageIndex]
        
        if controller is ParadisoPageMenuDelegate {
            let implements = controller as! ParadisoPageMenuDelegate
            let buttonTitle = implements.pageMenu(pageMenu!, didTouchUpRightBarButton: self.navigationItem.rightBarButtonItem!)
            if let buttonTitle = buttonTitle {
                self.navigationItem.rightBarButtonItem?.title = buttonTitle
            }
        }
    }
    
    // MARK: - Container View Controller
    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
        return true
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
    // MARK: - CAPSPageMenuDelegate
    func didMoveToPage(controller: UIViewController, index: Int) {
        if controller is ParadisoPageMenuDelegate {
            let implemented = controller as! ParadisoPageMenuDelegate
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: implemented.menuTitle(), style: UIBarButtonItemStyle.Done, target: self, action: "didTapRightMenu")

        }
    }
}
