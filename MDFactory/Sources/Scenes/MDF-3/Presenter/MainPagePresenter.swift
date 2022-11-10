import UIKit

protocol MainPageViewControllerOutput {
    func getItemsCount() -> Int
    func getItemTitle(index: Int) -> String
    func getItemDescription(index: Int) -> String
    func getItemImage(index: Int) -> UIImage?
    func getItemHandler(index: Int)
}

protocol MainPageViewControllerInput: AnyObject {
    func getCell(index: Int) -> ItemForMain
}

final class MainPagePresenter {
    
    // MARK: - Elements
    
    private weak var view: MainPageViewControllerInput?
    
    // MARK: - Lifecycle
    
    init(view: MainPageViewControllerInput) {
        self.view = view
    }
}

extension MainPagePresenter: MainPageViewControllerOutput {
    
    func getItemsCount() -> Int {
        return MainPageModel().itemForCollection().count
    }
    
    func getItemTitle(index: Int) -> String {
        return MainPageModel().itemForCollection()[index].title
    }
    
    func getItemDescription(index: Int) -> String {
        return MainPageModel().itemForCollection()[index].description
    }
    
    func getItemImage(index: Int) -> UIImage? {
        return MainPageModel().itemForCollection()[index].image
    }
    
    func getItemHandler(index: Int) {
        MainPageModel().itemForCollection()[index].handler(
            MainPageModel().itemForCollection()[index].title
        )
    }
}
