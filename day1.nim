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

func do_rotations_left(base_pos: int, rotation: int): (int, int) =
  ## Calcualtes how many times zero was passed by rotating the dial left `rotation` number of spaces.
  let rotate = base_pos - rotation

  let dial_position = rotate.floorMod(100)

  var pass_zero_count = floorDiv(rotation, 100)
  if rotate <= 0:
    pass_zero_count += 1

  if base_pos == 0:
    pass_zero_count -= 1

  (dial_position, pass_zero_count)

func do_rotations_right(base_pos: int, rotation: int): (int, int) =
  let rotate = base_pos + rotation

  let dial_position = rotate.floorMod(100)

  let pass_zero_count = floorDiv(rotate, 100)

  (dial_position, pass_zero_count)

proc do_rotations(input: string): int =
  var dial_position = 50
  var zero_count = 0

  for line in input.split("\n"):
    var line = line.strip()
    if "" == line:
      continue

    let direction = line[0]
    let count = parseInt(line[1..^1])

    var pass_zero_times = 0
    case direction:
      of 'L':
        (dial_position, pass_zero_times) = do_rotations_left(dial_position, count)
      of 'R':
        (dial_position, pass_zero_times) = do_rotations_right(dial_position, count)
      else: continue

    zero_count += pass_zero_times
    # if dial_position == 0:
    #   zero_count += 1

    echo fmt"{direction}{count:>4} -> Pass zero count: {pass_zero_times:>2}, Dial position: {dial_position:>2}, Total {zero_count:>5}"

  return zero_count

let count = do_rotations(TEST_INPUT)
echo "Final count: ", count

try:
  var stream = openfilestream("./day1_input.txt")
  let count = do_rotations(stream.readall())
  echo "final count: ", count
except:
  stderr.write getcurrentexceptionmsg()
