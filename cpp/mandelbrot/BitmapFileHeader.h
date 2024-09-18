#pragma once

#include <cstdint>

using namespace std;

namespace lck {

#pragma pack(push, 2)

struct BitmapFileHeader {
  char header[2] { 'B', 'M' };
  int32_t fileSize;
  int32_t reserved { 0 };
  int32_t dataOffset;
};

#pragma pack(pop)

} /* namespace lck */
