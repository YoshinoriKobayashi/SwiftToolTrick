//
//  ViewController.swift
//  TabBarController
//
//  Created by Swift-Beginners on 2021/03/03.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ①ViewControllerのインスタンスの空配列を作成
        var viewControllers: [UIViewController] = []
        
        // ②各ViewControllerのインスタンスを作成
        let firstViewController = FirstViewController()
        let secondViewController = SecondViewController()
        let thirdViewController = ThirdViewController()

        // ③インスタンスのViewControllerに対して、アイコンなどのTabBarIteｍを設定
        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        thirdViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)

        // ④空配列に各ViewControllerをappend
        viewControllers.append(firstViewController)
        viewControllers.append(secondViewController)
        viewControllers.append(thirdViewController)
        
        // ⑤setCiewControllerにviewControllersを渡す
        self.setViewControllers(viewControllers, animated: false)
        
    }
}

