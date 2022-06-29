package main

import (
	"fmt"
	"os"
	"time"
)

func main() {
	file, err := os.Create("crudeTimerlog.txt")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer file.Close()

	pause := make(chan bool)
	start := time.Now()
	go func() {
		for {
			select {
			case <-pause:
				<-pause
			default:
				fmt.Println(time.Since(start))
				time.Sleep(time.Second)
			}
		}
	}()
	for {
		fmt.Scanln()
		fmt.Fprintln(file, time.Since(start), "Time worked until paused....")
		pause <- true
		fmt.Scanln()
		pause <- false
		fmt.Fprintln(file, time.Since(start), "Amount of time spent paused....")
	}
}
