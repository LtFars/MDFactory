import UIKit

final class MainPageAssembly {
    static func assembly() -> UIViewController {
        let mainPageViewController = MainPageViewController()
        let mainPagePresenter = MainPagePresenter(view: mainPageViewController)
        mainPageViewController.presenter = mainPagePresenter
        return mainPageViewController
    }
}
