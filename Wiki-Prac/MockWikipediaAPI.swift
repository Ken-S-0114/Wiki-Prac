//
//  MockWikipediaAPI.swift
//  Wiki-Prac
//
//  Created by 佐藤賢 on 2019/06/09.
//  Copyright © 2019 佐藤賢. All rights reserved.
//

import Foundation
import RxSwift

class MockWikipediaAPI {
    private let results: Observable<[WikipediaPage]>

    init(results: Observable<[WikipediaPage]>) {
        self.results = results
    }
}

extension MockWikipediaAPI: WikipediaAPI {
    func search(from word: String) -> Observable<[WikipediaPage]> {
        return results
    }
}
