//
//  WikipediaAPI.swift
//  Wiki-Prac
//
//  Created by 佐藤賢 on 2019/06/08.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import Foundation
import RxSwift

protocol WikipediaAPI {
    func search(from word: String) -> Observable<[WikipediaPage]>
}

class WikipediaDefaultAPI: WikipediaAPI {
    private let host = URL(string: "https://ja.wikipedia.org")!
    private let path = "/w/api.php"

    private let URLSession: Foundation.URLSession

    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }

    func search(from word: String) -> Observable<[WikipediaPage]> {
        var components = URLComponents(url: host, resolvingAgainstBaseURL: false)!
        components.path = path

        let items = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "list", value: "search"),
            URLQueryItem(name: "srsearch", value: word)
        ]

        components.queryItems = items

        let request = URLRequest(url: components.url!)
        return URLSession.rx.response(request: request)
            .map { pair in
                do {
                    let response = try JSONDecoder().decode(
                        WikipediaSearchResponse.self,
                        from: pair.data
                    )
                    return response.query.search
                } catch {
                    throw error
                }
        }
    }
}
