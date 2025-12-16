import std/strutils, strformat, streams, math

# R68
# L1000
# R20
# R80
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

func do_rotations_left(base_pos: int, rotation: int): (int, bool) =

  let new_position = base_pos - rotation

  (floorMod(new_position, 100), new_position < 0 and base_pos != 0)

func do_rotations_right(base_pos: int, rotation: int): (int, bool) =

  let new_position = base_pos + rotation

  (floorMod(new_position, 100), new_position > 100)

proc do_rotations(input: string): int =
  var dial_position = 50
  var zero_count = 0

  for line in input.split("\n"):
    var line = line.strip()
    if "" == line:
      continue

    let direction = line[0]
    let count = parseInt(line[1..^1])

    # Increment count for passing zero
    zero_count += floorDiv(count, 100)
    let final_rotation = floorMod(count, 100)

    if final_rotation == 0:
      continue

    var strictly_passed_zero: bool
    case direction:
      of 'L':
        (dial_position, strictly_passed_zero) = do_rotations_left(dial_position, final_rotation)
      of 'R':
        (dial_position, strictly_passed_zero) = do_rotations_right(
            dial_position, final_rotation)
      else: continue

    if strictly_passed_zero or dial_position == 0:
      zero_count += 1

    echo fmt"{line:>4} -> Pass zero count: {strictly_passed_zero:>2}, Dial position: {dial_position:>2}, Total {zero_count:>5}"

  return zero_count

let count = do_rotations(TEST_INPUT)
echo "Final count: ", count

try:
  var stream = openfilestream("./day1_input.txt")
  let count = do_rotations(stream.readall())
  echo "final count: ", count
except:
  stderr.write getcurrentexceptionmsg()
