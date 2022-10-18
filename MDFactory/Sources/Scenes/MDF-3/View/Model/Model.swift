import UIKit

struct ItemForMain: Hashable {
    let title: String
    let description: String
    let image: UIImage?
}


struct Model {
    static var gridMode: Bool = false
    
    func itemForCollection() -> [ItemForMain] {
        return [
            ItemForMain(title: "Lessons", description: "Последний пройденный урок", image: UIImage(named: "leasons")),
            ItemForMain(title: "Rate", description: "Превью рейтинга студента",  image: UIImage(named: "rate")),
            ItemForMain(title: "Testing", description: "Превью результатов тестирования",  image: UIImage(named: "tests")),
            ItemForMain(title: "WebView", description: "Полезные статьи",  image: UIImage(named: "webView")),
           // ItemForMain(title: "Test", description: "Test test test",  image: UIImage(systemName: "person"))
        ]
    }
}



