import terminal, os, strutils

const numbers = [
  [
  "   ___  ",
  "  / _ \\ ",
  " | | | |",
  " | |_| |",
  "  \\___/ "],

  [
  "  _ ",
  " / |",
  " | |",
  " | |",
  " |_|"],

  [
  "  ____  ",
  " |___ \\ ",
  "   __) |",
  "  / __/ ",
  " |_____|"],

  [
  "  _____ ",
  " |___ / ",
  "   |_ \\ ",
  "  ___) |",
  " |____/ "],

  [
  "  _  _   ",
  " | || |  ",
  " | || |_ ",
  " |__   _|",
  "    |_|  "],

  [
  "  ____  ",
  " | ___| ",
  " |___ \\ ",
  "  ___) |",
  " |____/ "],

  [
  "   __   ",
  "  / /_  ",
  " |  _ \\ ",
  " | (_) |",
  "  \\___/ "],

  [
  "  _____ ",
  " |___  |",
  "    / / ",
  "   / /  ",
  "  /_/   "],

  [
  "   ___  ",
  "  ( _ ) ",
  "  / _ \\ ",
  " | (_) |",
  "  \\___/ "],

  [
  "   ___  ",
  "  / _ \\ ",
  " | (_) |",
  "  \\__, |",
  "    /_/ "]

]

proc `*`(c: char, n: int): string =
  result = ""
  for i in 0..n:
    result &= c

proc digits(n: int): seq[int] =
  result = newSeq[int]()
  var tmp = n

  while tmp != 0:
    result = @[tmp mod 10] & result
    tmp = int(tmp/10)


proc toBig(n: int): string =
  var bigNums = newSeq[array[5, string]]()

  for d in digits(n):
    bigNums.add(numbers[d])

  result = ""

  for i in 0..4:
    var lenCounter = 0
    for num in bigNums:
      result &= num[i]
      lenCounter += num[i].len()
    result &= (' ' * (terminalWidth() - lenCounter - 1)) & "\n"


if paramCount() < 1:
  quit(0)

var counter: int


try:
  counter = paramStr(1).parseInt()

except ValueError:
  stderr.writeLine("The argument '" & paramStr(1) & "' is not a valid integer.")
  quit(1)


if counter < 0:
  stderr.writeLine("Argument must be positive")
  quit(1)


while counter != 0:
  echo toBig(counter)
  sleep(1000)
  cursorUp(6)
  counter -= 1
