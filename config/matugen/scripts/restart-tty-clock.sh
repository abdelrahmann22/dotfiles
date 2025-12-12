#!/bin/bash

# Restart tty-clock to apply new terminal colors
# tty-clock doesn't support reload signals, so it must be restarted

if pgrep -x tty-clock >/dev/null; then
    # Save current tty-clock arguments if possible
    TTYCLOCK_PID=$(pgrep -x tty-clock)
    
    # Kill existing tty-clock
    pkill tty-clock
    
    # Wait a moment
    sleep 0.2
    
    # Restart with themed wrapper
    # Run in background and detach from current terminal
    setsid -f tty-clock-themed >/dev/null 2>&1
    
    echo "tty-clock restarted with new colors"
else
    echo "tty-clock is not running"
fi
