# music-theory
small tools for music theory learning and validation

## Interval Vector Calculator
Given a major scale:
```
$ echo '0 2 4 5 7 9 11' | ruby vector.rb
[0, 2, 4, 5, 7, 9, 11]
[2, 5, 4, 3, 6, 1]
```

Given a minor scale:
```
$ echo '0 2 3 5 7 8 10' | ruby vector.rb
[0, 2, 3, 5, 7, 8, 10]
[2, 5, 4, 3, 6, 1]
```

So major scales are as expressive as minor scales.

## Scale Calculator
```
$ruby scale.rb C
C major scale:
C D E F G A B

$ruby scale.rb a
A minor scale:
A B C D E F G
```
