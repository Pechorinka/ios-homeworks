//
//  TabBarController.swift
//  Navigation
//
//  Created by Tatyana Sidoryuk on 17.02.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
        private enum TabBarItem {
        case feed
        case profile
        case gest
        
        var title: String {
            switch self {
            case .feed:
                return "Лента"
                
            case .profile:
                return "Профиль"
                
            case .gest:
                return "Жесты"
                
            }
        }
        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "person.3")
            case .profile:
                return UIImage(systemName: "person.crop.circle.fill")
            case .gest:
                return UIImage(systemName: "pencil.and.outline")
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }

    func setupTabBar() {
        let items: [TabBarItem] = [.feed, .profile, .gest]
        
        self.viewControllers = items.map( { tabBarItem in
            switch tabBarItem {
                case .feed:
                    return UINavigationController(rootViewController: FeedViewController())
                case .profile:
                    return UINavigationController(rootViewController: ProfileViewController())
                case .gest:
                    return UINavigationController(rootViewController: GesturesViewController())
            }
        })
        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = items[index].title
            vc.tabBarItem.image = items[index].image
        })
    }
    
}
