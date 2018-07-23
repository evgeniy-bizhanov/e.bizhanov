/**
 Структура позволяет использовать протокол или класс в качестве ключа для словаря или набора
 */

struct Key {
    let type: Any.Type
    
    init(_ service: Any.Type) {
        type = service
    }
}

// MARK: - Hashable
extension Key: Hashable {
    var hashValue: Int {
        return ObjectIdentifier(type).hashValue
    }
    
    static func == (lhs: Key, rhs: Key) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
