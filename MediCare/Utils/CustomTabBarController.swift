//
//  CustomTabBarController.swift
//  MediCare
//
//  Created by Kritagya Parajuli on 6/29/22.
//

import UIKit
import RAMAnimatedTabBarController



class CustomTabBarController: RAMAnimatedTabBarController   {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        // Do any additional setup after loading the view.
    }
   
    func configureTabBar(){
        
        if #available(iOS 13.0, *) {
            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = UIColor.systemBackground
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        
        tabBar.tintColor = UIColor(named: "PrimaryColor") ?? .systemPink
        
        
        let vc1 = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "HomeVC") as! HomeVC
        let vc2 = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(identifier: "SearchVC") as! SearchVC
        let vc3 = UIStoryboard(name: "Cart", bundle: nil).instantiateViewController(identifier: "CartVC") as! CartVC
        let vc4 = UIStoryboard(name: "ProfilesAndMore", bundle: nil).instantiateViewController(identifier: "ProfilesAndMoreVC") as! ProfilesAndMoreVC
        
        vc1.tabBarItem = RAMAnimatedTabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        (vc1.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        vc2.tabBarItem = RAMAnimatedTabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        
        (vc2.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        vc3.tabBarItem = RAMAnimatedTabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 3)
        (vc3.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        vc4.tabBarItem = RAMAnimatedTabBarItem(title: "More", image:UIImage(named: "more"), tag: 3)
        (vc4.tabBarItem as? RAMAnimatedTabBarItem)?.animation = RAMBounceAnimation()
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}
