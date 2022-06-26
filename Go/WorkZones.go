package main

import (
	"fmt"
	"time"
)

func main() {
	for {
		fmt.Printf("=========================\n")
		fmt.Printf("Local  %s\n", time.Now().Format("Mon 3:04:00 PM MST"))
		fmt.Printf("est    %s\n", time.Now().In(time.FixedZone("EST", -4*60*60)).Format("Mon 3:04:00 PM MST"))
		fmt.Printf("pst    %s\n", time.Now().In(time.FixedZone("PST", -7*60*60)).Format("Mon 3:04:00 PM MST"))
		fmt.Printf("mst    %s\n", time.Now().In(time.FixedZone("MST", -6*60*60)).Format("Mon 3:04:00 PM MST"))
		fmt.Printf("=========================\n")
		fmt.Printf("Tokyo  %s\n", time.Now().In(time.FixedZone("UST+9", 9*60*60)).Format("Mon 3:04:00 PM MST"))
		fmt.Printf("London %s\n", time.Now().In(time.FixedZone("UST+1", 1*60*60)).Format("Mon 3:04:00 PM MST"))
		time.Sleep(time.Minute) // or 30 * time.Second
	}
}
