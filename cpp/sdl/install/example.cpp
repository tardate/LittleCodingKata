#include <iostream>
#include <iomanip>
#include <SDL.h>

void show_sdl_details() {
  SDL_version compiled;
  SDL_version linked;
  SDL_VERSION(&compiled);
  SDL_GetVersion(&linked);

  std::cout << "## SDL LIBRARY INFO" << std::endl;
  std::cout << "SDL compiled version " <<
    unsigned(compiled.major) << "." << unsigned(compiled.minor) << "." << unsigned(compiled.patch) << std::endl;
  std::cout << "SDL linked version " <<
    unsigned(linked.major) << "." << unsigned(linked.minor) << "." << unsigned(linked.patch) << std::endl;
}

void show_renderer_details() {
  std::cout << "## RENDER DRIVERS" << std::endl;
  std::cout <<
    std::setw(8) << "Renderer" <<
    std::setw(20) << "Name" <<
    std::setw(8) << "Flags" <<
    std::setw(21) << "max_texture_width" <<
    std::setw(21) << "max_texture_height" << std::endl;

  for(int render_index = 0; render_index < SDL_GetNumRenderDrivers(); ++render_index) {
    SDL_RendererInfo renderer;
    SDL_GetRenderDriverInfo(render_index, &renderer);

    std::cout <<
      std::setw(8) << render_index <<
      std::setw(20) << renderer.name <<
      std::setw(8) << std::hex << renderer.flags <<
      std::setw(21) << renderer.max_texture_width <<
      std::setw(21) << renderer.max_texture_height << std::endl;
  }
}

int main() {
  show_sdl_details();
  show_renderer_details();
  return 0;
}
