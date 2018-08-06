//
//  Регистрирует зависимости для сервиса отзывов о товаре
//

import Swinject

/// Сборщик сервиса отзывов о товаре
class ReviewsServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(ReviewsRequestFactory.self) { resolver in
            Injector.makeFactory(ReviewsRequestManager.self, resolver: resolver)
        }
    }
}
