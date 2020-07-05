#!/bin/bash
diff <( tail -n +2 "$1" | sort -t ',' --key=4,5 | cut -d "," -f2) <( tail -n +2 "$2" | sort -t ',' --key=4,5 | cut -d "," -f2) 1>/dev/null








