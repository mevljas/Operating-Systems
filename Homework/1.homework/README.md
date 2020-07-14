# 1. homework
Write 3 scripts (DN1a.sh, DN1b.sh, DN1c.sh) that perform the following tasks:

## (a) DN1a.sh
Script receives 1 argument:
```
DN1a.sh directory
```
The script should create a subdirectory of skel in the specified directory (if the directory does not exist, create it with the entire path), which should contain the entire content, as in /etc/skel/ (/etc/skel/ otherwise differs in different distributions). It then adds subdirectories to the new directory: Desktop, Documents, Downloads, Public. It should also add a symbolic link to the /var/www directory, named www-root. If the script does not receive the expected number of arguments, it should print the instructions for running and end with the appropriate status (select or write the appropriate instructions and the appropriate status yourself).

## (b) DN1b.sh
The script receives 2 or 3 arguments:
```
DN1b.sh file directory [skel]
```
The script receives a file with usernames and passwords as the first argument. The passwords in the file are not given as plain text, but as a condensed-scatter value converted by the cryptographic hash-scatter function SHA-512. The script should only be created by users who have a password specified with SHA-512 (when checking, you can assume that it is enough to look only at the number of the algorithm used). Print usernames of users who do not have a password converted by the correct algorithm to standard error output. The user home directories (the directory name should be the same as the user name) should be created by the script as subdirectories in the directory specified as the second argument. The script can also receive a third argument. The third argument is the path to the skel directory. Each user's home directory should contain all files and directories from the skel directory (note ownership). If the third argument is not used, then the default scale is used. The default shell of created users should be bash. If the script does not receive the expected number of arguments, it should print the running instructions and end with the appropriate status.

Example file with users:
```
ales: $ 6 $ 42482 / fWZt $ xdJ3BXYuqLc.DKB1WPxr22ZDV.QB7UCbyyeChf9yLnyowFijaLePqFa23Srn / pPUEko1nYic438qyo.xZWV5P1
borut: $ 5 $ / dVpf3092yvLxQi $ HP.YuQmxfrrmX8E5oXWat0mMU2WAkGLKNbzAYGm9GS1
ciril: $ 6 $ fbpgMg5coAm $ nrqkIkIYaEDcKxkqsba7FG0MhUhsgxGGojJVnlDpEDlkVMzzfee1q0IBrg0X8Rc9FxveWdA6XERK6lq8jY.eX0
damjan: $ 6 $ X6Rbe7AbnY $ rnwbffQbWOKgvoXkVgAOLcUBVBN6asgA6nKhdu27KuXy8Hv9NZQ3kc0zwdv11jVS25X4p4e.Iq1cu5V7nP4H11
```
In the file, each line represents a user. The first data is the username, the second the password; they are separated by a colon. In the above example, the script creates users ales, cyril, damjan, but not the user borut because it uses SHA-256 instead of SHA-512.

## (c) DN1c.sh
The script receives 2 or more arguments:
```
DN1c.sh file user [user] ...
 ```
The script receives the path to the file as the first argument, and gets a list of users from the second argument onwards. Grants all specified users the ACL (Access Control List) the ability to read and run the file (even if they are not file owners or members of a file group; however, not all other system users receive these two rights). Tip: Find the command to change the ACL for the file.
