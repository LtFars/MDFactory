import UIKit

protocol MainPagePresenterProtocol {
    var model: [ItemForMain] { get }
    func getItemsCount() -> Int
    func getItemTitle(index: Int) -> String
    func getItemDescription(index: Int) -> String
    func getItemImage(index: Int) -> UIImage?
    func getItemHandler(index: Int)
    
}

class MainPagePresenter: MainPagePresenterProtocol {
    var model: [ItemForMain] = MainPageModel().itemForCollection()
    
    func getItemsCount() -> Int {
        return model.count
    }
    
    func getItemTitle(index: Int) -> String {
        return model[index].title
    }
    
    func getItemDescription(index: Int) -> String {
        return model[index].description
    }
    
    func getItemImage(index: Int) -> UIImage? {
        return model[index].image
    }
    
    func getItemHandler(index: Int) {
        model[index].handler(model[index].title)
    }
}
