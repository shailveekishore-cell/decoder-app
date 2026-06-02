//
//  ErrorAnalyzer.swift
//  Decoder App
//
//  Created by shailvee kishore on 4/14/26.
//
import Foundation

struct ErrorAnalysis {
    let errorType: String
    let logicExplanation: String
    let fixSteps: [String]
    let codeExample: String
}

let swiftErrors: [String: ErrorAnalysis] = [
    "IndexOutOfRange": ErrorAnalysis(
        errorType: "Index Out of Range",
        logicExplanation: "You tried to access an array position that does not exist.",
        fixSteps: [
            "Check the array count.",
            "Make sure the index is less than array.count."
        ],
        codeExample: """
        if index < items.count {
            print(items[index])
        }
        """
    ),
    "NilOptional": ErrorAnalysis(
        errorType: "Optional Nil Error",
        logicExplanation: "You tried to use an optional value before safely unwrapping it.",
        fixSteps: [
            "Use if let or guard let.",
            "Make sure the value is not nil before using it."
        ],
        codeExample: """
        if let name = optionalName {
            print(name)
        }
        """
    ),
    "CannotConvert": ErrorAnalysis(
        errorType: "Type Conversion Error",
        logicExplanation: "Swift expected one type of value, but got a different one.",
        fixSteps: [
            "Check the expected type.",
            "Convert the value if needed."
        ],
        codeExample: """
        let text = "5"
        if let num = Int(text) {
            print(num)
        }
        """
    ),
    "ExtraArgument": ErrorAnalysis(
        errorType: "Extra Argument in Call",
        logicExplanation: "You passed more arguments to a function than it accepts.",
        fixSteps: [
            "Check the function definition.",
            "Remove the extra argument."
        ],
        codeExample: """
        greet(name: "Sam")
        """
    ),
    "MissingArgument": ErrorAnalysis(
        errorType: "Missing Argument",
        logicExplanation: "A function needs a value, but you did not pass one.",
        fixSteps: [
            "Look at the function parameters.",
            "Pass all required arguments."
        ],
        codeExample: """
        greet(name: "Sam")
        """
    )
]

let pythonErrors: [String: ErrorAnalysis] = [
    "SyntaxError": ErrorAnalysis(
        errorType: "Syntax Error",
        logicExplanation: "Python found code that does not follow proper syntax rules.",
        fixSteps: [
            "Check punctuation like colons and parentheses.",
            "Make sure your code format is correct."
        ],
        codeExample: """
        if x > 5:
            print(x)
        """
    ),
    "IndentationError": ErrorAnalysis(
        errorType: "Indentation Error",
        logicExplanation: "Python depends on spacing, and your indentation is inconsistent.",
        fixSteps: [
            "Line up blocks evenly.",
            "Use consistent spaces or tabs, not both."
        ],
        codeExample: """
        if x > 5:
            print(x)
        """
    ),
    "NameError": ErrorAnalysis(
        errorType: "Name Error",
        logicExplanation: "You used a variable or function name that Python does not know.",
        fixSteps: [
            "Check spelling.",
            "Make sure the variable was created before you used it."
        ],
        codeExample: """
        x = 5
        print(x)
        """
    ),
    "TypeError": ErrorAnalysis(
        errorType: "Type Error",
        logicExplanation: "You used an operation on the wrong type of data.",
        fixSteps: [
            "Check whether values are strings, ints, or lists.",
            "Convert the value if needed."
        ],
        codeExample: """
        age = "17"
        print(int(age) + 1)
        """
    ),
    "IndexError": ErrorAnalysis(
        errorType: "Index Error",
        logicExplanation: "You asked for an item in a list that is outside its range.",
        fixSteps: [
            "Check list length.",
            "Make sure the index exists."
        ],
        codeExample: """
        if index < len(items):
            print(items[index])
        """
    )
]

let javaErrors: [String: ErrorAnalysis] = [
    "NullPointerException": ErrorAnalysis(
        errorType: "Null Pointer Exception",
        logicExplanation: "You tried to use an object that has no value yet.",
        fixSteps: [
            "Make sure the object is initialized.",
            "Check for null before using it."
        ],
        codeExample: """
        if (name != null) {
            System.out.println(name);
        }
        """
    ),
    "ArrayIndexOutOfBounds": ErrorAnalysis(
        errorType: "Array Index Out of Bounds",
        logicExplanation: "You tried to access a position in an array that does not exist.",
        fixSteps: [
            "Check array length.",
            "Use a valid index."
        ],
        codeExample: """
        if (index < arr.length) {
            System.out.println(arr[index]);
        }
        """
    ),
    "CannotFindSymbol": ErrorAnalysis(
        errorType: "Cannot Find Symbol",
        logicExplanation: "Java cannot find the variable, method, or class you named.",
        fixSteps: [
            "Check spelling and capitalization.",
            "Make sure it was declared."
        ],
        codeExample: """
        int score = 10;
        System.out.println(score);
        """
    ),
    "IncompatibleTypes": ErrorAnalysis(
        errorType: "Incompatible Types",
        logicExplanation: "You tried to store one type of value inside another type that does not match.",
        fixSteps: [
            "Check variable types.",
            "Convert the value if possible."
        ],
        codeExample: """
        int num = Integer.parseInt("5");
        """
    ),
    "MissingSemicolon": ErrorAnalysis(
        errorType: "Missing Semicolon",
        logicExplanation: "Java statements usually need a semicolon at the end.",
        fixSteps: [
            "Check the line ending.",
            "Add a semicolon if needed."
        ],
        codeExample: """
        int x = 5;
        """
    )
]

func analyzeError(input: String, language: String) -> ErrorAnalysis? {
    let lowercasedInput = input.lowercased()

    switch language {
    case "Swift":
        if lowercasedInput.contains("index out of range") {
            return swiftErrors["IndexOutOfRange"]
        } else if lowercasedInput.contains("nil") || lowercasedInput.contains("optional") {
            return swiftErrors["NilOptional"]
        } else if lowercasedInput.contains("cannot convert") || lowercasedInput.contains("convert value of type") {
            return swiftErrors["CannotConvert"]
        } else if lowercasedInput.contains("extra argument") {
            return swiftErrors["ExtraArgument"]
        } else if lowercasedInput.contains("missing argument") {
            return swiftErrors["MissingArgument"]
        }

    case "Python":
        if lowercasedInput.contains("syntaxerror") {
            return pythonErrors["SyntaxError"]
        } else if lowercasedInput.contains("indentationerror") {
            return pythonErrors["IndentationError"]
        } else if lowercasedInput.contains("nameerror") {
            return pythonErrors["NameError"]
        } else if lowercasedInput.contains("typeerror") {
            return pythonErrors["TypeError"]
        } else if lowercasedInput.contains("indexerror") {
            return pythonErrors["IndexError"]
        }

    case "Java":
        if lowercasedInput.contains("nullpointerexception") {
            return javaErrors["NullPointerException"]
        } else if lowercasedInput.contains("arrayindexoutofboundsexception") {
            return javaErrors["ArrayIndexOutOfBounds"]
        } else if lowercasedInput.contains("cannot find symbol") {
            return javaErrors["CannotFindSymbol"]
        } else if lowercasedInput.contains("incompatible types") {
            return javaErrors["IncompatibleTypes"]
        } else if lowercasedInput.contains("';' expected") || lowercasedInput.contains("semicolon") {
            return javaErrors["MissingSemicolon"]
        }

    default:
        return nil
    }

    return nil
}
