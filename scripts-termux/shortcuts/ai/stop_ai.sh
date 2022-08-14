#!/data/data/com.termux/files/usr/bin/bash
echo "Stopping ai processes..."
ps aux | grep "acc_detector.sh" | grep -v "grep acc_detector.sh" | awk '{print $2}' | xargs kill -9
ps aux | grep "ai-robot.sh" | grep -v "grep ai-robot.sh" | awk '{print $2}' | xargs kill -9
ps aux | grep "ulapph-speak-ENGLISH.sh" | grep -v "grep ulapph-speak-ENGLISH.sh" | awk '{print $2}' | xargs kill -9
ps aux | grep "termux-tts-speak" | grep -v "grep termux-tts-speak" | awk '{print $2}' | xargs kill -9
#ps aux | grep "termux-api" | grep -v "grep termux-api" | awk '{print $2}' | xargs kill -9
ps -ax

