/**
 Контейнер зависимостей. Хранит конфигурацию зависимостей и разрешает их
 */

// MARK: - Ошибки
/// Ошибки возникающие при использовании контейнера зависимостей
enum ContainerError: Error {
    case notFound(Any.Type)
    case castFailure(Any.Type)
}

// MARK: - Container
/// Контейнер зависимостей
final class Container {
    
    typealias Initializer = (Resolver) -> Any
    typealias Instance = Any
    
    typealias Factory = (
        `init`: Initializer,
        scope: Scope,
        instance: Instance?
    )
    
    private var dictionary = [Key: Factory]()
    private var lastKey: Key? // Нужно как-то опотокобезопасить)
    
    /**
     Регистрация зависимостей в контейнере
     
     - Parameter service: Сервис для которого регистрируется фабрика
     - Parameter factory: Фабрика, с помощью которой разрешается зависимость
     */
    @discardableResult
    func register(_ service: Any.Type, factory: @escaping Initializer) -> ScopeResolver {
        let key = Key(service)
        let value: Factory = (factory, .default, nil)
        
        dictionary[key] = value
        lastKey = key
        
        return self
    }
    
    // Не уверен на счет синглтона, но пусть пока будет так,
    // наверное надо инстанцировать в начале запуска, что бы не было соблазна
    // использовать еще где то в коде
    private init() {}
    public static let shared = Container()
}

// MARK: - ScopeResolver
extension Container: ScopeResolver {
    func inScope(_ scope: Scope) {
        guard let key = lastKey else {
            return
        }
        
        dictionary[key]?.scope = scope
    }
}

// MARK: - Resolver
extension Container: Resolver {
    
    func resolve<T>(service: T.Type) throws -> T {
        print(service)
        let key = Key(service)
        
        guard var factory = dictionary[key] else {
            throw ContainerError.notFound(service)
        }
        
        guard let instance = (factory.instance ?? factory.init(self)) as? T else {
            throw ContainerError.castFailure(service)
        }
        
        if factory.scope == .singleton {
            factory.instance = instance
        }
        
        return instance
    }
}
