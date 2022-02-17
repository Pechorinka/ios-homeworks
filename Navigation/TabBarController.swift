//
//  TabBarController.swift
//  Navigation
//
//  Created by Alexey Sidoryuk on 17.02.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private enum TabBarItem {
        case feed
        case profile
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
                
            case .profile:
                return "Профиль"
            }
        }
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "person.3")
            case .profile:
                return UIImage(systemName: "person.crop.circle.fill")
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }
    
    func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile]
        self.viewControllers = items.map( { tabBarItem in
            switch tabBarItem {
                case .feed:
                    return UINavigationController(rootViewController: ViewController())
                case .profile:
                    return UINavigationController(rootViewController: ProfileViewController())
            }
        })
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
    
}
