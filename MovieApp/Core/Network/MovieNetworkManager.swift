//
//  MovieManager.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

class MovieNetworkManager {
    
// MARK: - Properties
    let filmsNowShowingURL = "https://api-gate2.movieglu.com/filmsNowShowing?n=10"
    let filmDetailsURL = "https://api-gate2.movieglu.com/filmDetails/"
    let filmsComingSoonURL = "https://api-gate2.movieglu.com/filmsComingSoon/?n=10"
    let filmLiveSearch = "https://api-gate2.movieglu.com/filmLiveSearch/"
    

// MARK: - Methods
    func fetchFilmsNowShowing(completion: @escaping (Result<MovieNetworkData, Error>) -> Void) {
        performRequest(with: filmsNowShowingURL, type: MovieNetworkData.self, completion: completion)
    }
    
    func detailsURL(id: Int, completion: @escaping (Result<DetailsNetworkData, Error>) -> Void) {
        let urlString = "\(filmDetailsURL)?film_id=\(id)"
        performRequest(with: urlString, type: DetailsNetworkData.self, completion: completion)
    }
    
    func fetchFilmsComingSoon(completion: @escaping (Result<MovieNetworkData, Error>) -> Void) {
        performRequest(with: filmsComingSoonURL, type: MovieNetworkData.self, completion: completion)
    }
    
    func fetchFilmLiveSearch(query: String, completion: @escaping (Result<MovieNetworkData, Error>) -> Void) {
        let urlString = "\(filmLiveSearch)?query=\(query)&n=10"
        performRequest(with: urlString, type: MovieNetworkData.self, completion: completion)
        print(urlString)
    }
    
    // MARK: - API request
    func performRequest<T: Decodable>(with urlString: String, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        if let url = URL(string: urlString) {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Constants.Header.data
            
            let session = URLSession(configuration: configuration)
    
            let task = session.dataTask(with: url) { data, response, error in
                if let error {
                    completion(.failure(error))
                    return
                }
                if let safeData = data {
                    if let movieData = self.parseJSON(movieNetworkData: safeData, type: T.self) {
                        completion(.success(movieData))
                    } else {
                        completion(.failure(CustomError.ParsingError))
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON<T: Decodable>(movieNetworkData: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(T.self, from: movieNetworkData)
            return decodedData
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

enum CustomError: Error {
    case ParsingError
    case ClientError
}

private extension MovieNetworkManager {
    enum Constants {
        enum Header {
           static let data = [
                "Client": "SPAC_0",
                "x-api-key": "CNmOP1lNPg6jWGF4eQ8jZ4bPKsbtivE5Wfpv3wAc",
                "territory": "XX",
                "api-version": "v200",
                "Authorization": "Basic U1BBQ18wX1hYOkJaRFdwdHdkcXl5Vg==",
                "device-datetime": "\(formattedTodayDate)"
            ]
        }
    }
}
