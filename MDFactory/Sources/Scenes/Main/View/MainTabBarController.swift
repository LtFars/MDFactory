import UIKit

class MainTabBarController: UIViewController {
    private let _tabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTabBar()
    }
    
    func setupTabBar() {
        _tabBarController.tabBar.tintColor = UIColor(hex: "#6A4CE2FF")
        let main = UINavigationController(rootViewController: MainPage())
        main.tabBarItem.image = UIImage(systemName: "person")
        main.title = "Main"
        let course = UINavigationController(rootViewController: MainPage())
        course.tabBarItem.image = UIImage(systemName: "person")
        course.title = "Course"
        let lesson = UINavigationController(rootViewController: MainPage())
        lesson.tabBarItem.image = UIImage(systemName: "person")
        lesson.title = "Lesson"
        let testing = UINavigationController(rootViewController: MainPage())
        testing.tabBarItem.image = UIImage(systemName: "person")
        testing.title = "Testing"
        let views = [main, course, lesson, testing]
        _tabBarController.setViewControllers(views, animated: true)
                _tabBarController.modalPresentationStyle = .fullScreen
        present(_tabBarController, animated: false)
    }
}
