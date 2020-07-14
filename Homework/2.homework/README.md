# Word snack
```
piknik.sh [-n [NUM-][NUM,]NUM] [-p POS CHAR] [-f FILE] niz
```
Write a bash script piknik.sh, with following tasks:

The argument is a string of characters and the output is all possible words from these characters.

The script can also receive the switch -n to specify the length of the word that we are searching for. The length is given as the number (-n 4), but also several numbers can be separated by a comma (-n 3,5) or an interval (-n 3-5).

The script also receives the switch -p, to which 2 arguments are given; the first determines the position and the other the letter. By doing so we fix the already known letter in the word we are looking for. If we have known several letters, we can give the -p switch several times.

The script searches for words in the file besede.txt (you get it on the ucilnica), unless you specify otherwise with the switch -f.

Some examples:
```
$piknik.sh jugrot
jogurt
```
```
$piknik.sh jugrot -n 5 -f mojebesede.txt
jutro
```
```
$piknik.sh -n 3 -p 1 r jugrot
rju
rog
roj
rot
ruj
rut
```
```
$piknik.sh -n 3 -p 1 r -p 2 u jugrot
ruj
rut
```

Submit only the script file piknik.sh, not an archive (such as tar or zip). Make sure that the UTF-8 code is set and use \ n (Unix / Linux newline character) instead of \ r \ n or \ r for the new line.

You can use only BASH not use other programming languages or sed and awk commands.

Make the program useful. This means that it works above the whole word file (besede.txt) and that it also searches for words with 8 characters long in a reasonable time (read below 1 minute). It must also work for longer words.

The program must also work correctly for words containing slovenian characters (š,č, ž). Ignore the words with dashes and punctuations (dots, commas). Also note the words that are in brackets.

