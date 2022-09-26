package main

import (
	"fmt"
	"math/rand"
	"time"
)

const alphanumericspecial = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#?<>$%^&*()"

func RandomAlphaNumericSpecialString(length int) string {
	var buf [16]byte // change []byte number to whatever for bigger or smaller random strings
	if length < 0 {
		length = 0
	}
	buflen := length
	for i := 0; i < buflen; i++ {
		buf[i] = alphanumericspecial[rand.Intn(len(alphanumericspecial))]
	}
	return string(buf[:length])
}

func main() {
	rand.Seed(time.Now().UnixNano())
	fmt.Println(RandomAlphaNumericSpecialString(11))
}
