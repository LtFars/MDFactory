import UIKit

struct ItemForMain {
    let title: String
    let description: String
    let image: UIImage?
    let handler: ((String) -> Void)
}

struct MainPageModel {
    static var gridMode: Bool = false
    
    static func itemForCollection() -> [ItemForMain] {
        return [
            ItemForMain(
                title: "Lessons",
                description: "Последний пройденный урок",
                image: UIImage(named: "leasons"),
                handler: { print("Нажата ячейка \($0)") }
            ),
            ItemForMain(
                title: "Rate",
                description: "Превью рейтинга студента",
                image: UIImage(named: "rate"),
                handler: { print("Нажата ячейка \($0)") }
            ),
            ItemForMain(
                title: "Testing",
                description: "Превью результатов тестирования",
                image: UIImage(named: "tests"),
                handler: { print("Нажата ячейка \($0)") }
            ),
            ItemForMain(
                title: "WebView",
                description: "Полезные статьи",
                image: UIImage(named: "webView"),
                handler: { print("Нажата ячейка \($0)") }
            )
        ]
    }
}
