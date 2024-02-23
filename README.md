# water_jug

Water Jug Challenge

## Getting Started

The Water Jug Challenge involves using two jugs with different capacities 
to measure out a specific amount of water.

## Algorithmic Approach

I started by separating the UI from the logic using a Controller, as this would 
make it easier to work with validations and calculations in a smaller file.

Then I checked the numbers entered using the Euclidean Algorithm, to find the 
Greatest Common Divisor and see if the problem has a solution.

After that, I started checking the solutions from smallest to largest number 
and vice versa, keeping track of the number of steps to solve it. I did an 
extra check to see if the solution doesn't fit into any of the cases below, 
which have no solution:
1) If the jug exceeds the target volume
2) If the jug does not reach the target volume

After both calculations have been made, the best solution is the one with 
fewer steps.

## Test Cases for Validation

1) Bucket X: 3
   Bucket Y: 12
   Amount wanted Z: 9

| Bucket X | Bucket Y | Explanation                        |
|----------|----------|------------------------------------|
| 0        | 12       | Fill Bucket Y                      |
| 3        | 9        | Transfer from Bucket Y to Bucket X |

2) Bucket X: 4
   Bucket Y: 90
   Amount wanted Z: 82

| Bucket X | Bucket Y | Explanation                        |
|----------|----------|------------------------------------|
| 0        | 90       | Fill Bucket Y                      |
| 4        | 86       | Transfer from Bucket Y to Bucket X |
| 0        | 86       | Empty Bucket X                     |
| 4        | 82       | Transfer from Bucket Y to Bucket X |

3) Bucket X: 1
   Bucket Y: 5
   Amount wanted Z: 2

| Bucket X | Bucket Y | Explanation                        |
|----------|----------|------------------------------------|
| 1        | 0        | Fill Bucket X                      |
| 0        | 1        | Transfer from Bucket X to Bucket Y |
| 1        | 1        | Fill Bucket X                      |
| 0        | 2        | Transfer from Bucket X to Bucket Y |

4) Bucket X: 8
   Bucket Y: 32
   Amount wanted Z: 17

No solution to these values.

## Instruction

Just enter the values for X, Y and Z and tap the "Solve" button.