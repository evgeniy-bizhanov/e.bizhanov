//
//  Паттерн внедрения зависимостей
//

import Swinject

// Необязательно делать замыкание,
// т.к. переменная уже по факту является ленивой (объявлена глобально)

/// Сборщик модулей
private let assembler: Assembler = Assembler(
    [
        ServiceAssembler(),
        AuthServiceAssembler(),
        CatalogServiceAssembler(),
        ReviewsServiceAssembler(),
        BasketServiceAssembler()
    ]
)

class AbstractModuleBuilder: NSObject {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.resolve(resolver: assembler.resolver)
    }
    
    func resolve(resolver: Resolver) {}
}
