# #200 Cheatsheet

A place to record some of my favourite MacOS tools, tips and tricks.

## Digital Color Meter

[Digital Color Meter](https://en.wikipedia.org/wiki/Digital_Color_Meter) is a utility provided in MacOS that can be
used to easily ready the pixel color from anywhere on the screen.
Great for quickly color matching.

![digital_color_meter](./assets/digital_color_meter.png?raw=true)

## How to retrieve windows that have moved 'off-screen'

Occasionally I seem to be able to move a window entirely off-screen, especially when connecting an external monitor.

Hold the Option key down and choose "Arrange in Front" from the Window menu.
It will then arrange all the windows of that application in a cascade from the top left of the screen.

See [apple.stackexchange.com](https://apple.stackexchange.com/questions/709/how-to-retrieve-windows-that-have-moved-off-screen)

## Setting the Screencapture Location

In macOS Mojave and later, the screenshot location can be selected from the Screenshot app options menu.

In early versions, the location can be read and set using the defaults command:

	$ defaults write com.apple.screencapture location /Users/myname/Downloads/Screenshots
	$ defaults read com.apple.screencapture
	{
		location = "/Users/myname/Downloads/Screenshots"
	}

See also: 

* [How to Change Where Screenshots Are Saved on Mac](https://www.hellotech.com/guide/for/how-to-change-where-screenshots-are-saved-on-mac)
* [Take a screenshot on your Mac](https://support.apple.com/en-gb/102646)
