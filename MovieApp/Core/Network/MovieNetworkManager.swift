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
    
    func detailsURL(id: Int, completion: @escaping (Result<DetailsNetworkData, Error>) -> Void) {
        let urlString = "\(filmDetailsURL)?film_id=\(id)"
        performRequest(with: urlString, type: DetailsNetworkData.self, completion: completion)
    }
    
// MARK: - Methods
    func fetchFilmsNowShowing(completion: @escaping (Result<MovieNetworkData, Error>) -> Void) {
        performRequest(with: filmsNowShowingURL, type: MovieNetworkData.self, completion: completion)
    }

    func performRequest<T: Decodable>(with urlString: String, type: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) {
        if let url = URL(string: urlString) {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "Client": "SPAC_0",
                "x-api-key": "CNmOP1lNPg6jWGF4eQ8jZ4bPKsbtivE5Wfpv3wAc",
                "territory": "XX",
                "api-version": "v200",
                "Authorization": "Basic U1BBQ18wX1hYOkJaRFdwdHdkcXl5Vg==",
                "device-datetime": "2023-08-12"
            ]
            
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
                        completion(.failure(AnaError.ParsingError))
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
            return nil
        }
    }
}

enum AnaError: Error {
    case ParsingError
    case ClientError
}
