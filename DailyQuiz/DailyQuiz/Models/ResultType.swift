import Foundation

enum ResultType: Int {
    case zero = 0
    case one 
    case two
    case three
    case four
    case five
    
    var feedbackText: String {
        switch self {
        case .zero:
            return "Бывает и так!"
        case .one:
            return "Сложный вопрос? "
        case .two:
            return "Есть над чем поработать"
        case .three:
            return "Хороший результат!"
        case .four:
            return "Почти идеально!"
        case .five:
            return "Идеально!"
        }
    }
    
    var descriptionText: String {
        switch self {
        case .zero:
            return "0/5 — не отчаивайтесь. Начните заново и удивите себя!"
        case .one:
            return "1/5 — иногда просто не ваш день. Следующая попытка будет лучше!"
        case .two:
            return "2/5 — не расстраивайтесь, попробуйте ещё раз!"
        case .three:
            return "3/5 — вы на верном пути. Продолжайте тренироваться!"
        case .four:
            return "4/5 — очень близко к совершенству. Ещё один шаг!"
        case .five:
            return "5/5 — вы ответили на всё правильно. Это блестящий результат!"
        }
    }
}
