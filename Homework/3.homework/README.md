# 3. Homework
The third homework assignment consists of two subtasks: (a) Rabbit the Savior and (b) Inter-process Express. The rabbit is worth 30 points, the Express 10 points (both assignments are worth 40). During the defenses you can achieve additional 60 points. Name the script of the first subtask as DN3a.sh, and the second one DN3b.sh.

## a) DN3a.sh: Rabbit the Savior
Sometimes in live we wish that certain process runs as quick as possible. Here "Rabbit the Savior" that will take care of the selected processes, will come in handy. We select processes by providing a path to the process when we run Rabbit the Savior, together with some optional arguments. The Rabbit will then set priority p (default -10) to this group of processes and lower priority to all the other processes that are running on the system for s levels (default 2, ie. increase of value for 2). Rabbit the Savior must, in a case when less then n processes (default n=3) that we selected are running, run new instances up to the total number of n (with optional arguments if provided). If there are more than n processes running, we do not run any new process. If no instances of that program are running we run it up to the number n (with optional arguments, if provided). These new instance-running should be executed in a t-millisecond intervals (default 300). When the target number of instances is achieved, Rabbit the Savior ends its execution. Rabbit the Savior must output to the standard output time and message of its success: "Na tem mestu, <d>. <m>. 2019 je Zajec Veliki pomagal procesu <name of the process>.” (where day d in month m are without leading zeros).

When searching for the same processes, take into the account canonical paths to the programs, that were executed and ignore their arguments.

If we supply Rabbit the Savior with the argument with the path to the configuration file, it should read configuration from it. Each element of this configuration file is in its own line, where first key is written, followed by a semicolon and then the value of that setting. Order line-wise is not important, also every configuration element is optional. Configuration options:


- log: path to the log file where everything that is being written to the standard output is logged (everything should also be written to the standard output),

- n: number of instances of the target processes,

- p: new level of niceness for the target processes,

- s: level of niceness reduction for all the other processes,

- t: time between separate instance creation in milliseconds.

An example of a call and an output, where default values are used:
```
> ./dn3a.sh /usr/bin/xeyes
Na tem mestu, 6. 5. je Zajec Veliki pomagal procesu /usr/bin/xeyes.
```
An example of a call, where configuration file korenje.conf is used and also arguments to the program are supplied:
```
> ./dn3a.sh "/bin/sleep infinity" korenje.conf
```
Na tem mestu, 6. 5. je Zajec Veliki pomagal procesu /bin/sleep.
## (b) DN3b.sh: Inter-process express 
Sometimes in life we find ourselves in difficult moments. One of those is definitely the fact that some programs do not read from standard input the way we would like them to in those difficult moments. One such program is diff, which does not enable us to read content of both files through standard input. This means, that with what we have learned during lab sessions so far, we cannot solve this without writting files to the disk (we did not cover the process substitution of ramdisk creation). We do not like this, of course, since for the eminent FRI programmers it is not appropriate to trash the precious disk space like that. We do process substitution using <(commands), e.g. diff <(commands over file1) <(commands over file2).

Armed with this knowledge you will write a program for a club Steel way, which tracks departures of selected trains from their initial stops. Their members do not know how to use database management systems, which means they collected departures data unsorted into CSV files (check the appended podatkiA.csv, podatkiB.csv and podatkiC.csv). Also, they have their disk drives completely filled up with some videos and you cannot afford that your program would write to the disk. Because these members are very fearful persons you cannot allow to write anything to the standard output. They are interested in a program that, given two input files, returns status 0, if the time order of train types is the same, or 1 if it is not. Type is provided in the second column: Gomuljka, TGV, etc.; ignore names of the trains. Solution must be exactly one line long (without the use of semicolons), or two lines together with the path to the interpreter script needs to be exactly two lines long. Also, take into the account that script needs to work if we run it as any arbitrary user. Two call examples:
```
> ./dn3b.sh podatkiA.csv podatkiB.csv
> echo $?
0
```
```
> ./dn3b.sh podatkiB.csv podatkiC.csv
> echo $?
1
```
