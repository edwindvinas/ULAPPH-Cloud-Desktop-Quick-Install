package main

import (
    "os/exec"
    "fmt"
    "bufio"
)
func main() {
	cmd := exec.Command("sh", "/data/data/com.termux/files/home/.shortcuts/sensors/tilt_detector.sh")
	stdout, err := cmd.StdoutPipe()
	if err != nil {
		fmt.Println(err)
	}

	err = cmd.Start()
	fmt.Println("The command is running")
	if err != nil {
		fmt.Println(err)
	}
	
	// print the output of the subprocess
	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		m := scanner.Text()
		fmt.Println(m)
	}
	cmd.Wait()
}
