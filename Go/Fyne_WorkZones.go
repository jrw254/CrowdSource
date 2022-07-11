/*
  This is a crude mock up as I learn Fyne. It's set to my local time, Central Time Zone. 
  Make adjustments as you need. Check out Fyne: https://fyne.io/

  basic GUI in Fyne for WorkZones.go script
*/


package main

import (
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/data/binding"
	"fyne.io/fyne/v2/widget"
)

func main() {
  
	myApp := app.New()
	myWindow := myApp.NewWindow("Zones")

	CSTtime := binding.NewString()
	  CSTtxtWid := widget.NewLabelWithData(CSTtime)

	ESTtime := binding.NewString()
	  ESTtxtWid := widget.NewLabelWithData(ESTtime)

	PSTtime := binding.NewString()
	  PSTtxtWid := widget.NewLabelWithData(PSTtime)

	MSTtime := binding.NewString()
	  MSTtxtWid := widget.NewLabelWithData(MSTtime)

	UST9time := binding.NewString()
	  UST9txtWid := widget.NewLabelWithData(UST9time)

	UST1time := binding.NewString()
	  UST1txtWid := widget.NewLabelWithData(UST1time)

	//content := container.NewBorder(CSTtxtWid, ESTtxtWid, PSTtxtWid, MSTtxtWid) // Sets to the four rects
	content := container.NewVBox(CSTtxtWid, ESTtxtWid, PSTtxtWid, MSTtxtWid, UST9txtWid, UST1txtWid) // Puts them in a columns
	// container.NewHBox // For horizontal positioning

	go func() {
		for {
			time.Sleep(time.Second)
			  CSTtime.Set(time.Now().Format("Mon 3:04:05 PM MST"))
			  ESTtime.Set(time.Now().In(time.FixedZone("EST", -4*60*60)).Format("Mon 3:04:05 PM MST"))
			  PSTtime.Set(time.Now().In(time.FixedZone("PST", -7*60*60)).Format("Mon 3:04:05 PM MST"))
			  MSTtime.Set(time.Now().In(time.FixedZone("MST", -6*60*60)).Format("Mon 3:04:05 PM MST"))
			  UST9time.Set(time.Now().In(time.FixedZone("UST+9", 9*60*60)).Format("Mon 3:04:05 PM MST"))
			  UST1time.Set(time.Now().In(time.FixedZone("UST+1", 1*60*60)).Format("Mon 3:04:05 PM MST"))
		  }
	}()

	myWindow.SetContent(content)
	myWindow.Resize(fyne.NewSize(100, 100))
	myWindow.CenterOnScreen()
	myWindow.ShowAndRun()
}
