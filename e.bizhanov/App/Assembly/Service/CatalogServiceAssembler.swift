//
//  Регистрирует зависимости для сервиса каталога товаров
//

import Swinject

/// Сборщик сервиса каталога
class CatalogServiceAssembler: Assembly {
    func assemble(container: Container) {
        
        container.register(CatalogRequestFactory.self) { resolver in
            Injector.makeFactory(CatalogRequestManager.self, resolver: resolver)
        }
    }
}
