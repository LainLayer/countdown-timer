import terminal, os, strutils
import flatty
import supersnappy

type Big = array[5, string]

const numbers_compressed = slurp("numbers.bin")

let numbers = numbers_compressed.uncompress().fromFlatty(array[10, Big])

const padding = "        "


proc `$`(b: seq[Big]): string {.inline.} =
  for i in 0..4:
    for number in b:
      result &= number[i]
    result &= padding & "\n"

proc toBig(n: int): string {.inline.} =
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
