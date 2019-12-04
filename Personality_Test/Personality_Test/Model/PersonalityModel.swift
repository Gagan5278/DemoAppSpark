//
//  PersonalityModel.swift
//  Personality_Test
//
//  Created by Gagan Vishal on 2019/12/03.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct PersonalityModel: Decodable {
    let categories: Categories
    let questions: [QuestionsModel]
    
    private enum CodingKeys: String, CodingKey {
        case categories
        case questions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categories = try container.decode(Categories.self, forKey: .categories)
        self.questions = try container.decode([QuestionsModel].self, forKey: .questions)
    }

}

struct QuestionsModel: Decodable {
    let question: String
    let category: String
    let question_type: QuestionType
    
    private enum QuestionsCodingKeys: String, CodingKey {
        case question
        case category
        case question_type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: QuestionsCodingKeys.self)
        self.question = try container.decode(String.self, forKey: .question)
        self.category = try container.decode(String.self, forKey: .category)
        self.question_type = try container.decode(QuestionType.self, forKey: .question_type)
    }
}


struct QuestionType: Decodable {
    let type: String
    let options: [String]
    
    private enum CodingKeys: String, CodingKey {
        case type
        case options
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.options = try container.decode([String].self, forKey: .options)
    }
}

struct Categories: Decodable {
    let hard_fact: String
    let lifestyle: String
    let introversion: String
    let passion: String
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.hard_fact = try container.decode(String.self)
        self.lifestyle = try container.decode(String.self)
        self.introversion = try container.decode(String.self)
        self.passion = try container.decode(String.self)

    }
}
