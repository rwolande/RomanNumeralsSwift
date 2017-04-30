//Ryan Wolande - code sample

import UIKit
import PlaygroundSupport

//Simple abstract structures for convenience
struct rmw_numeral
{
        let symbol: String!
        let value: Int!
        
        init(symbol: String, value: Int)
        {
                self.symbol = symbol
                self.value = value
        }
}

struct rmw_roman_test
{
        let input: Int!
        let output: String!
        
        init(_ input: Int, _ output: String)
        {
                self.input = input
                self.output = output
        }
        
        public func evaluate(result: String)
        {
                result == output ? print_success() : print_failure(result: result)
        }
        
        private func print_success()
        {
                print("\(input!) ~> \(output!) ... Correct!")
        }
        
        private func print_failure(result: String)
        {
                print("\(input!) ~> \(result) ... Failed Test! The expected answer is \(output!).")
        }
}

let roman_error_large = "This value is greater than Roman Numerals represent. Please enter something smaller."
let roman_error_negative = "This value is negative. Try a positive value on for size instead!"


//Core function to convert a decimal Int into a Roman String
func decimalToRoman(decimal: Int) -> String
{
        var numerals: [rmw_numeral] = [rmw_numeral(symbol: "M", value: 1000),
                                       rmw_numeral(symbol: "D", value: 500),
                                       rmw_numeral(symbol: "C", value: 100),
                                       rmw_numeral(symbol: "L", value: 50),
                                       rmw_numeral(symbol: "X", value: 10),
                                       rmw_numeral(symbol: "V", value: 5),
                                       rmw_numeral(symbol: "I", value: 1)]
        
        //Error checking (generally should be handled outside of function for complete projects)
        if decimal > (4 * numerals.first!.value)
        {
                return roman_error_large
        }
        else if decimal < 0
        {
                return roman_error_negative
        }
        
        var remainder = decimal
        var result = ""
        
        for (i,numeral) in numerals.enumerated()
        {
                //subtract a value from the remainder and add it's roman equivalent to our string
                while remainder >= numeral.value
                {
                        remainder -= numeral.value
                        result += numeral.symbol
                }
                
                if numeral.value != numerals.last!.value
                {
                        let position = i + (i % 2 == 0 ? 2 : 1)
                        let next_numeral = numerals[position]
                        //reverse endian situation, add the next symbol before this symbol to indicate the "less than" relationship
                        if remainder + next_numeral.value >= numeral.value
                        {
                                remainder -= (numeral.value - next_numeral.value)
                                result += next_numeral.symbol + numeral.symbol
                        }
                }
        }
        
        return result
}

/* -- TESTS -- */
let roman_tests = [rmw_roman_test(24, "XXIV"), rmw_roman_test(497, "CDXCVII"), rmw_roman_test(167, "CLXVII"), rmw_roman_test(988, "CMLXXXVIII"), rmw_roman_test(9, "IX"), rmw_roman_test(2395, "MMCCCXCV"), rmw_roman_test(3999, "MMMCMXCIX"), rmw_roman_test(6, "VI"), rmw_roman_test(2409, "MMCDIX"), rmw_roman_test(12367, roman_error_large)]
for test in roman_tests
{
        let decimal = decimalToRoman(decimal: test.input)
        test.evaluate(result: decimal)
}