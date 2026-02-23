# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a flashcard application project intended for learning Chinese

Each word or phrase can be represented in 3 ways:

* simplified Chinese character(s)
* pinyin
* English translation

Use-cases:

* main screen - present flash card options
* start a simplified Chinese flash card sequence:
    * show a simplified Chinese character(s).
    * user click's "reveal" to see the pinyin and English translation
* start an English flash card sequence:
    * show the English translation.
    * user click's "reveal" to see the pinyin and simplified Chinese character(s)
* repeats until use clicks "end" to go back to main screen

## Architecture

This is a single-page web application

* Flashcard data model
    * fixed vocab loaded from associated json file
    * each entry includes:
        * simplified Chinese character(s)
        * pinyin
        * English translation
    * seed with at least 100 words/phrases
* User interface:
    * single HTML page with associated CSS and JS assets
    * clean, responsive UI design
* Provide a sinatra app stub for loading/running locally

## Next Steps
