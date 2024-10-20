# #094 YouTube

An experiment in scripting the YouTube player with external controls and the IFrame API.

## Notes

I have some ideas for how I'd like to be able to embed YouTube, but they hinge on the ability
to control a YouTube player and also get feedback on current player position.
this is a quick test to see if all these possibilities are realistic.

A quick search yeilded the [YouTube Player API Reference for iframe Embeds](https://developers.google.com/youtube/iframe_api_reference),
which appears to be the right medicine. So that's what I'm going to try..

Objectives:

* external play trigger
* mark times
* play section between marked times
* loop between marked times

## Some Useful Features of the API

[onYouTubeIframeAPIReady](https://developers.google.com/youtube/iframe_api_reference#Requirements)
is a function that must be implemented. It is called by the API when loaded and ready.

[Playback controls](https://developers.google.com/youtube/iframe_api_reference#Playback_controls) include

* `player.playVideo():Void`
* `player.pauseVideo():Void`
* `player.stopVideo():Void`
* `player.seekTo(seconds:Number, allowSeekAhead:Boolean):Void`

[Playback status](https://developers.google.com/youtube/iframe_api_reference#Playback_status)

* `player.getPlayerState():Number`
* `player.getCurrentTime():Number`

## Mark and Loop

The `getCurrentTime()` function gets the appropriate video position for a "Mark" operation.

Rewind/set to play from a specific time mark can be achieved with the `seekTo()` function.

It seems there's no direct way to directly combine an end time with `seekTo()`.

To play a specific time window (from `startSeconds` to `endSeconds`) appears only to be directly supported
by the `loadVideoById` and `cueVideoById` functions. But these entail reloading the entire video,
so not ideal for performing a loop between start/end in an already-loaded video.

So the approach that appears best is:

* use `getCurrentTime()` to mark start/end points
* start a loop with `seekTo()`, and use `setTimeout` to fire at approximately the desired end point.
* at the end point, either stop the video or loop back with another `seekTo()` depending on whether infinite looping is desired.


## An Example

The [example.html](https://codingkata.tardate.com/javascript/scripting_youtube/example.html)
loads a [preset video](https://youtu.be/M7lc1UVf-VE), initially stopped, and enables some simple controls.
Only plain-old-Javascript and the IFrame API are used.

Play, Pause and Stop buttons have their expected effect.

A Mark button is use to set/reset the start and end markers.

* when the second mark has been added, it will automatically replay the video between the two marks
* if the 'loop' checkbox is selected, the video will loop between the two marks

[![running](./assets/running.png?raw=true)](https://codingkata.tardate.com/javascript/scripting_youtube/example.html)

## Credits and References

* [YouTube Player API Reference for iframe Embeds](https://developers.google.com/youtube/iframe_api_reference)
