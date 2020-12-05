import Alamofire
import Foundation

let runLoop = CFRunLoopGetCurrent()

print("Enter a Nickname or 'quit' to quit:")
while let input = readLine() {
guard input != "quit" else {
    break
    }
    fetchRepo(userName: input)
}


struct UserRepo: Decodable {
    let name: String
}

func fetchRepo(userName: String) {

    Alamofire.request("https://api.github.com/users/\(userName)/repos").validate().responseData { (response) in
        switch response.result {
            case .success:
                guard let data = response.data else {
                    print("Handle error: empty data received;")
                    return
                }
                do {
                    print("\(userName)'s repositories:")
                    let repo = try JSONDecoder().decode([UserRepo].self, from: data)
                    print(repo)
                } catch {
                    print("Handle error: serialization JSON; \(error)")
                }
                
            case .failure(let error):
                print("Handle error: user does not exist;  \(error)")
            }
    }

RunLoop.main.run(until: Date(timeIntervalSinceNow: 3))//Alamofire использует асинхронные запросы, если не создать RunLoop, код завершится задолго до того, как с сервера поступит ответ.
}

