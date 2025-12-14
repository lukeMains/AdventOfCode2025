import std/strutils, strformat, streams, math

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
  R68
  L1000
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

    var rotation = 0
    var pass_zero_times = 0
    case direction:
      of 'L':
        let reduced = count.floorMod(100)
        rotation = 100 - reduced

        let sum = dial_position - reduced
        if sum < 0:
          pass_zero_times = 1
        else:
          pass_zero_times = 0
      of 'R':
        rotation = count.floorMod(100)

        let sum = dial_position + rotation
        if sum >= 100:
          pass_zero_times = 1
        else:
          pass_zero_times = 0
      else: continue

    pass_zero_times += floorDiv(count, 100)

    # Save variable state
    zero_count += pass_zero_times
    dial_position = (dial_position + rotation).floorMod(100)

    echo fmt"{direction}{count:>4} -> Pass zero count: {pass_zero_times:>2}, Dial position: {dial_position:>2}, Total {zero_count:>5}"

  return zero_count

let count = do_rotations(TEST_INPUT)
echo "Final count: ", count

try:
  var stream = openFileStream("./day1_input.txt")
  let count = do_rotations(stream.readAll())
  echo "Final count: ", count
except:
  stderr.write getCurrentExceptionMsg()
