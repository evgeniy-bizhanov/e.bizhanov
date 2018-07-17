struct ChangeUserDataResult: Codable {
    let result: Int
}

struct UserData {
    let id: Int
    let username: String
    let password: String
    let email: String
    let gender: String
    let creditCard: String
    let bio: String
}
