var ones = [
  '',
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine',
]
var tens = [
  '',
  '',
  'twenty',
  'thirty',
  'forty',
  'fifty',
  'sixty',
  'seventy',
  'eighty',
  'ninety',
]
var teens = [
  'ten',
  'eleven',
  'twelve',
  'thirteen',
  'fourteen',
  'fifteen',
  'sixteen',
  'seventeen',
  'eighteen',
  'nineteen',
]

function convert_billions(num) {
  if (num >= 1000000000) {
    return (
      convert_billions(Math.floor(num / 1000000000)) +
      ' billion ' +
      convert_millions(num % 1000000000)
    )
  } else {
    return convert_millions(num)
  }
}

function convert_millions(num) {
  if (num >= 1000000) {
    return (
      convert_millions(Math.floor(num / 1000000)) +
      ' million ' +
      convert_thousands(num % 1000000)
    )
  } else {
    return convert_thousands(num)
  }
}

function convert_thousands(num) {
  if (num >= 1000) {
    return (
      convert_hundreds(Math.floor(num / 1000)) +
      ' thousand ' +
      convert_hundreds(num % 1000)
    )
  } else {
    return convert_hundreds(num)
  }
}

function convert_hundreds(num) {
  if (num > 99) {
    return ones[Math.floor(num / 100)] + ' hundred ' + convert_tens(num % 100)
  } else {
    return convert_tens(num)
  }
}

function convert_tens(num) {
  if (num < 10) return ones[num]
  else if (num >= 10 && num < 20) return teens[num - 10]
  else {
    return tens[Math.floor(num / 10)] + ones[num % 10]
  }
}

//Function that return English words of number
function convert(num) {
  //include the word "and" between the hundreds figure and the other part
  if (num > 100 && num % 100 > 0) {
    finalString = convert_billions(num)
    let myArray = finalString.split(' ')
    let tempString = myArray[myArray.length - 1]
    myArray[myArray.length - 1] = 'and'
    myArray[myArray.length] = tempString
    var finalString = myArray.join(' ')
  }

  if (num == 0) return 'zero'
  else return finalString
}

function main() {
  var testCases = [
    0, 1, 2, 9, 56, 78, 2323, 343434, 14565, 1956, 265560, 2165, 25, 29, 30, 35,
    50, 55, 6569, 74560, 99, 100, 101, 119, 510, 900, 165000, 5001, 5019, 5555,
    10000, 11000, 100000, 199001, 1000000, 1111111, 555555, 9999999999,
  ]
  for (var i = 0; i < testCases.length; i++) {
    console.log(testCases[i] + ': ' + convert(testCases[i]))
  }
}
main()
