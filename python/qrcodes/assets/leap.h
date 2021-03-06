#pragma once

// Original QR code details
// * Version : 2
// * Error correction : 0
// * Box size (pixels) : 8
// * Border size (boxes) : 0
// * Message : https://leap.tardate.com

#define qrcode_width  200
#define qrcode_height  200

static const uint8_t PROGMEM qrcode_data[] = {
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0xff,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0x00,0x00,0xff,0xff,0xff,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0xff,0x00,0x00,0xff,0x00,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0xff,0xff,0x00,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
  0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff
};
