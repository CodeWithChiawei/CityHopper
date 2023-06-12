import Foundation

enum FetchError: Error {
    case fileNotFound
    case decodingError(Error)
    case unknownError(Error)
}

enum FetchCityError: Error {
    case networkError(Error)
    case decodingError(Error)
    case noCityDataAvailable
}

class NetworkManager {
    
    var countryCode: String?
    
    func fetchCountryJSON(with continent: String, completion: @escaping (Result<FetchCityModel,FetchError>) -> Void) {
        do {
            if let filePath = Bundle.main.path(forResource: "CountryJSON", ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let json = try JSONDecoder().decode(CountryFetchModel.self, from: data)
                
                switch continent {
                case "Africa":
                    let randomNum = Int.random(in: 0..<json.Africa.count)
                    self.countryCode = json.Africa[Int(randomNum)].country_code
                case "Antarctica":
                    let randomNum = Int.random(in: 0..<json.Antarctica.count)
                    self.countryCode = json.Antarctica[Int(randomNum)].country_code
                case "Asia":
                    let randomNum = Int.random(in: 0..<json.Asia.count)
                    self.countryCode = json.Asia[Int(randomNum)].country_code
                case "Europe":
                    let randomNum = Int.random(in: 0..<json.Europe.count)
                    self.countryCode = json.Europe[Int(randomNum)].country_code
                case "North America":
                    let randomNum = Int.random(in: 0..<json.NorthAmerica.count)
                    self.countryCode = json.NorthAmerica[Int(randomNum)].country_code
                case "South America":
                    let randomNum = Int.random(in: 0..<json.SouthAmerica.count)
                    self.countryCode = json.SouthAmerica[Int(randomNum - 1)].country_code
                case "Oceania":
                    let randomNum = Int.random(in: 0..<json.Oceania.count)
                    self.countryCode = json.Oceania[Int(randomNum)].country_code
                default:
                    return
                }
                guard let countryCode = self.countryCode else { return }
                fetchCity(with: countryCode, completion: { result in
                              switch result {
                              case .success(let city):
                                  completion(.success(city))
                              case .failure(let error):
                                  completion(.failure(.unknownError(error)))
                              }
                          })
                      } else {
                          completion(.failure(.fileNotFound))
                      }
        } catch {
            print("error: \(error)")
        }
    }
    
    private let baseURL = "https://airlabs.co/api/v9/cities"
    
    func fetchCity(with countryCode: String, completion: @escaping (Result<FetchCityModel, FetchCityError>) -> Void ) {
        
        let param = [
            "api_key": APIKey.airLabKey,
            "country_code": countryCode
        ]
        
        guard let url = URL(string: baseURL) else { return }
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponent?.queryItems = param.map({URLQueryItem(name: $0.key, value: $0.value)})
        guard let resultURL = urlComponent?.url else { return }
        
        URLSession.shared.dataTask(with: resultURL) { data, _, error in
            if let error = error {
                print(error)
            }
            if let data = data {
                let cityDatas = try? JSONDecoder().decode(CityFetchModel.self, from: data)
                if cityDatas?.city?.count == 0 {
                    completion(.failure(.noCityDataAvailable))
                } else {
//                    let randomNum = Int.random(in: 0..<(cityDatas?.city.count ?? 0))
//                    let randomCityData = cityDatas?.city[Int(randomNum)]
//                    guard let cityData = randomCityData else { return }
//                    completion(.success(cityData))
                    completion(.success(FetchCityModel(name: "", latitude: 0, longitude: 0, countryCode: "US")))
                }
            }
        }.resume()
    }
    
    func fetchFlagImageData(with countryCode: String, completion: @escaping (Data) -> Void) {
        let code = countryCode.lowercased()
        guard let url = URL(string: "https://flagcdn.com/h240/\(code).png") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                completion(data)
            }
        }.resume()
    }
}

