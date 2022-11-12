import UIKit

protocol MainPageViewControllerOutput {
    
    
}

protocol MainPageViewControllerInput: AnyObject {
    
}

final class MainPagePresenter {
    
    // MARK: - Elements
    
    private weak var view: MainPageViewControllerInput?
    
    // MARK: - Lifecycle
    
    init(view: MainPageViewControllerInput) {
        self.view = view
    }
}

// MARK: - MainPageViewControllerOutput

extension MainPagePresenter: MainPageViewControllerOutput {
    
}
