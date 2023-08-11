//
//  MovieManager.swift
//  MovieApp
//
//  Created by Ana Dzebniauri on 10.08.23.
//

import Foundation

protocol MovieNetworkManagerDelegate: AnyObject {
    func didUpdateMovie(_ movieNetworkManager: MovieNetworkManager, movieData: [Films]?)
    func didFailWithError(error: Error)
}

class MovieNetworkManager {

    weak var delegate: MovieNetworkManagerDelegate?
    
// MARK: - Properties
    let filmsNowShowingURL = "https://api-gate2.movieglu.com/filmsNowShowing?n=10"
    
// MARK: - -Methods
    func fetchFilmsNowShowing() {
        performRequest(with: filmsNowShowingURL)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "Client": "SPAC_0",
                "x-api-key": "CNmOP1lNPg6jWGF4eQ8jZ4bPKsbtivE5Wfpv3wAc",
                "territory": "XX",
                "api-version": "v200",
                "Authorization": "Basic U1BBQ18wX1hYOkJaRFdwdHdkcXl5Vg==",
                "device-datetime": "2023-08-10"
            ]
            
            let session = URLSession(configuration: configuration)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let movieData = self.parseJSON(movieNetworkData: safeData) {
                        self.delegate?.didUpdateMovie(self, movieData: movieData)
                    }
                }
            }
            task.resume()
        }
//        Result<[MovieData, Error>]
    }
    
    
    func parseJSON(movieNetworkData: Data) -> [Films]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(MovieNetworkData.self, from: movieNetworkData)
            let movieData = decodedData.films
            return movieData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
