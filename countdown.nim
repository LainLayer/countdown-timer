import terminal, os, strutils
import flatty

const numbers_compressed = [
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

].toFlatty()

type Big = array[5, string]
let numbers = numbers_compressed.fromFlatty(array[10, Big])

const padding = "        "


proc `$`(b: seq[Big]): string =
  for i in 0..4:
    for number in b:
      result &= number[i]
    result &= padding & "\n"

proc toBig(n: int): string =
  var
    bigDigits: seq[Big] = @[]
    temp = n
    
  while temp != 0:
    bigDigits.insert(numbers[temp mod 10])
    temp = int(temp/10)

  return $bigDigits

if paramCount() < 1:
  quit(0)

var counter: int

try:
  counter = paramStr(1).parseint()

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

echo $(@[[padding, padding, padding, padding, padding]])
cursorUp(6)
