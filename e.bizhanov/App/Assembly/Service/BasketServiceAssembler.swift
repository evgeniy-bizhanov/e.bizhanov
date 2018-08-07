//
//  Регистрирует зависимости для сервиса корзины товаров
//

import Swinject

/// Сборщик сервиса корзины
class BasketServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(BasketRequestFactory.self) { resolver in
            Injector.makeFactory(BasketRequestManager.self, resolver: resolver)
        }
    }
}
