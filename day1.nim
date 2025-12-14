import std/strutils
import std/streams

const TEST_INPUT =
  """
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
  """

proc do_rotations(input: string): int =
  var dial_position = 50
  var zero_count = 0

  for line in input.split("\n"):
    var line = line.strip()
    if "" == line:
      continue
  
    let direction = line[0]
    let count = parseInt(line[1..^1])
    echo line, " -> Direction: ", direction, ", Count: ", count

    var rotation = 0
    case direction:
      of 'L':
        rotation = 100 - count
      of 'R':
        rotation = count
      else: continue

    dial_position = (dial_position + rotation).mod(100)
    echo "New dial position: ", dial_position
  
    if dial_position == 0:
      zero_count += 1

  return zero_count

let count = do_rotations(TEST_INPUT)
echo "Final count: ", count

try:
  var stream = openFileStream("./day1_input.txt")
  let count = do_rotations(stream.readAll())
  echo "Final count: ", count
except:
  stderr.write getCurrentExceptionMsg()
