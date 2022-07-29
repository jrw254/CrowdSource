/*
  Version 0.1 MultiPaste
  Note: Current version does not save results after close.
        12 MultiPaste sections provided. 
        Submit to save. Copy to copy. Clear to erase label. 
*/
package main

import (
	"fmt"
	"image/color"
	"time"

	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/canvas"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/data/binding"
	"fyne.io/fyne/v2/layout"
	"fyne.io/fyne/v2/theme"
	"fyne.io/fyne/v2/widget"
	"golang.design/x/clipboard"
)

func MultiPasteBTNs(a fyne.App, newWIN fyne.Window) *fyne.Container {
	grid := container.New(layout.NewGridLayout(3))
	for index := 0; index < 12; index++ {
		text := canvas.NewText("MultiPaste", color.Black)
		labelBind := binding.NewString()
		label := widget.NewLabelWithData(labelBind)
		// Submit Button Paste into Label Field
		btn := widget.NewButton("Submit", func() {
			output := func(s string) {
				if label.Text != "" {
					label.Text += "\n"
				}
				label.SetText(label.Text + "" + s)
			}
			f := clipboard.Init()
			if f != nil {
				fmt.Println(f)
			}
			output((string(clipboard.Read(clipboard.FmtText))))

		})
		// Copies from the Label Field back into the Clipboard
		copyBTN := widget.NewButtonWithIcon("Copy", theme.ContentCopyIcon(), func() {
			newWIN.Clipboard().SetContent(label.Text)
		})
		// Clear the Label Field
		clearput := widget.NewButton("Clear", func() {
			label.SetText("")
		})
		btn.Importance = widget.HighImportance
		content := container.New(layout.NewVBoxLayout(),
			container.New(layout.NewCenterLayout(), text),
			container.New(layout.NewCenterLayout(), label),
			container.New(layout.NewCenterLayout(),
				container.New(layout.NewHBoxLayout(),
					btn,
					copyBTN,
					clearput,
				),
			),
		)
		grid.Add(content)
	}
	newWIN.SetContent(grid)
	return grid
}

func localClock() *widget.Label {
	local_time := binding.NewString()
	local_timeLabel := widget.NewLabelWithData(local_time)
	//
	go func() {
		for {
			time.Sleep(time.Second)
			local_time.Set(time.Now().Format("Monday 3:04:05 PM MST 2006-January-02"))
		}
	}()
	return local_timeLabel
}

func main() {
	myApp := app.New()
	myWindow := myApp.NewWindow("Tab Demo")
	//
	toolbar := widget.NewToolbar(widget.NewToolbarAction(theme.ColorChromaticIcon(), func() {
		myApp.Settings().SetTheme(theme.LightTheme())
	}), widget.NewToolbarSeparator(), widget.NewToolbarAction(theme.ColorAchromaticIcon(), func() {
		myApp.Settings().SetTheme(theme.DarkTheme())
	}))
	//
	myWindow.SetContent(container.NewBorder(
		toolbar, // Top
		container.New(layout.NewCenterLayout(),
			container.NewHBox( // Bottom
				localClock(),
			),
		),
		nil, // Left
		nil, // Right
		container.NewScroll( // Center
			container.NewVBox(
				MultiPasteBTNs(myApp, myWindow),
			),
		),
	))
	myWindow.CenterOnScreen()
	myWindow.Resize(fyne.NewSize(800, 500))
	myWindow.ShowAndRun()

}
