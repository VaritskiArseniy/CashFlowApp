import RealmSwift

protocol RealmManagerProtocol {
    func create(_ object: Object)
    func delete(_ object: Object)
    func write(completion: () -> Void)
    func fetchCollection(_ type: Object.Type) -> Results<Object>
}

final class RealmManager {
    let realm = try! Realm()
}

extension RealmManager: RealmManagerProtocol {
    func create(_ object: Object) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func write(completion: () -> Void) {
        try? realm.write {
            completion()
        }
    }
    
    func fetchCollection(_ type: Object.Type) -> Results<Object> {
        realm.objects(type)
    }
    
    func delete(_ object: Object) {
        try? realm.write {
            realm.delete(object)
        }
    }
}
