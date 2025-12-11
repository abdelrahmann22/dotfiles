#!/bin/bash

# Compile the NvChad theme after matugen updates
nvim --headless +"lua require('base46').compile()" +qa 2>/dev/null


