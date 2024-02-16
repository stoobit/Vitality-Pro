import Foundation

let vitamins: [Vitamin] = [
    Vitamin(
        title: "Vitamin A", 
        alternative: "Retinol",
        identifier: .dietaryVitaminA,
        rdam: 0.85,
        rdaf: 0.7,
        description: "Important for vision, immune function, and skin health."
    ),
    Vitamin(
        title: "Vitamin B2",
        alternative: "Riboflavin",
        identifier: .dietaryRiboflavin,
        rdam: 1.4,
        rdaf: 1.1,
        description: "Important for energy production, growth, and red blood cell maintenance."
    ),
    Vitamin(
        title: "Vitamin B3",
        alternative: "Niacin",
        identifier: .dietaryNiacin,
        rdam: 15,
        rdaf: 12,
        description: "Supports energy production and skin health."
    ),
    Vitamin(
        title: "Vitamin B6",
        alternative: "Pyridoxine",
        identifier: .dietaryVitaminB6,
        rdam: 1.6,
        rdaf: 1.4,
        description: "Involved in brain development and function, and helps convert food into energy."
    ),
    Vitamin(
        title: "Vitamin C",
        alternative: "Ascorbic Acid", identifier: .dietaryVitaminC,
        rdam: 110,
        rdaf: 95,
        description: "Essential for collagen formation, wound healing, and immune function."
    ),
    Vitamin(
        title: "Vitamin E",
        alternative: "Tocopherol", 
        identifier: .dietaryVitaminE,
        rdam: 14,
        rdaf: 12,
        description: "Acts as an antioxidant, protecting cells from damage."
    ),
]
