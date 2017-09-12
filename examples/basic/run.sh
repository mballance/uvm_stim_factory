#!/bin/sh

vsim -solvefaildebug -c -do "run -a; quit -f" basic_top_opt
