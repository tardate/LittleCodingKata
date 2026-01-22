# Cyberpunk Book Nook Website Design

## Overview
- **Motion Style**: Cyberpunk Atmospheric Immersion (Neon-noir with kinetic energy)
- **Animation Intensity**: Ultra-Dynamic
- **Technology Stack**: GSAP + ScrollTrigger, Three.js for fog/depth, Custom Shaders for neon effects, CSS Houdini

## Brand Foundation
- **Colors**: 
  - Primary: #e7d9cf (Warm beige/cream)
  - Accent: #f6e7d9 (Light beige)
  - Dark: #0a0a0a (Near black)
  - Deep Blue: #0a1628 (Midnight blue)
  - Neon Pink: #ff0080
  - Neon Purple: #8b00ff
  - Neon Yellow: #ffff00
  - Neon Orange: #ff8000
  - Neon Green: #39ff14
  - Neon Blue: #00ffff
  - Text: #333333
  - Text Light: #666666
  - Error: #f56565
  - Success: #48bb78
- **Typography**: 
  - Display: "Bebas Neue" (Headers, neon text)
  - Body: "Montserrat" (Standard text)
  - Monospace: "PT Mono" (Technical readouts, UI elements)
- **Core Message**: A nostalgic, retro-futuristic sanctuary where stories come alive in neon.

## Global Motion System

### Animation Timing
- **Easing Library**: 
  - `neon-flicker`: cubic-bezier(0.4, 0, 0.2, 1)
  - `cyber-slide`: cubic-bezier(0.16, 1, 0.3, 1)
  - `hover-glow`: cubic-bezier(0.25, 0.46, 0.45, 0.94)
- **Duration Scale**: 
  - Micro-interactions: 200ms
  - Ambient cycles: 8s-20s
  - Scene transitions: 1.2s
- **Stagger Patterns**: 
  - Text reveals: 30ms per character
  - Grid items: 100ms cascade

### Continuous Effects
- **Neon Pulse**: All neon elements breathe with a subtle 4s cycle (opacity 0.9-1.0).
- **Atmospheric Fog**: Low-lying CSS fog layers drift horizontally across the viewport.
- **Data Rain**: Subtle vertical "digital rain" particle streams in background (opacity 0.05).

### Scroll Engine
- **Parallax Depth**: 5 distinct z-layers for background, midground, content, foreground, and overlay.
- **Scroll Smoothing**: Virtual momentum scrolling (lenis.js or similar) for weight.
- **Progress-driven**: Time of day in the "nook" scene progresses with scroll position.

## Section 1: Hero - "The Portal"

### Layout
**Asymmetric Diagonal Split**
The screen is sliced diagonally (75deg) by the main book nook image. The left side contains the title, the right side contains the interactive controls. The diagonal line itself is a glowing neon seam that pulses.

#### Spatial Composition
- **Z-Index Layering**: Background Image (-1), Fog Layer (0), Title (1), Controls (2), Floating Particles (3).
- **Overflow**: Hidden, but elements break boundaries (title bleeds off edge).

### Content
- **Title**: "CYBERPUNK BOOK NOOK"
- **Subtitle**: "Interactive Miniature Diorama"
- **Controls**: 3 interactive sliders (Lights, Signs, Time)

### Images
**Hero Book Nook Image**
- **Resolution:** 1920x1080
- **Aspect Ratio:** 16:9
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature diorama with cyberpunk aesthetic
- **Subject:** Multi-level street scene with neon signs, tram wires, tiny characters
- **Color Palette:** Neon pink, purple, yellow, orange, blue; deep blue night sky
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene in a book nook format, viewed from street level at night. The scene features multi-level buildings with glowing neon signs in pink, purple, yellow, and blue, narrow streets with wet pavement reflecting neon lights, and tiny human figures walking through the streets. The buildings are highly detailed with tiny windows, some lit, some dark, and include small storefronts, apartments, and stairways. The street is lined with miniature street lamps, vending machines, and potted plants. Overhead, there are tram wires and a small tram car. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic, with a sense of depth and immersion."

### Motion Choreography

#### Entrance Sequence
| Element | Animation | Values | Duration | Delay | Easing |
|---------|-----------|--------|----------|-------|--------|
| Title | Split-Char Reveal | y: 100% → 0% | 1.2s | 0.2s | cyber-slide |
| Diagonal Seam | Draw Line | scaleX: 0 → 1 | 1.0s | 0.5s | ease-out |
| Image | Zoom Out | scale: 1.2 → 1.0 | 1.5s | 0s | ease-out |
| Controls | Slide Up | y: 50px → 0px | 0.8s | 1.0s | back-out |

#### Scroll Effects
| Trigger | Element | Effect | Start | End | Values |
|---------|---------|--------|-------|-----|--------|
| Scroll | Title | Parallax Y | Top | Bottom | y: -150px |
| Scroll | Image | Parallax Y | Top | Bottom | y: 50px |
| Scroll | Controls | Fade Out | 0% | 30% | opacity: 1 → 0 |

#### Continuous Animations
- **Neon Flicker**: The title text has a CSS filter `drop-shadow` that flickers randomly every 3-5 seconds.
- **Mouse Interaction**: The diagonal seam "bends" slightly towards the cursor (magnetic distortion via CSS transform).

---

## Section 2: The Nook - "Living Diorama"

### Layout
**3D Perspective Theater**
The scene is presented as a deep 3D box. The user looks *into* the book nook. UI controls float on the glass surface of the screen.

#### Spatial Composition
- **Perspective**: 1000px container perspective.
- **Layers**: Background buildings (z: -100), Midground (z: 0), Foreground (z: 50), UI (z: 100).

### Content
- **Headline**: "PEER INTO THE ALLEY"
- **Description**: "Control the pulse of the city."

### Images
**Cyberpunk Book Nook Scene**
- **Resolution:** 1920x1080
- **Aspect Ratio:** 16:9
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature diorama, cyberpunk night market
- **Subject:** Narrow alley with neon signs, vending machines, tram wires, tiny people
- **Color Palette:** Neon pink, purple, yellow, blue; dark blues and blacks
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a low angle. The scene features a narrow, winding alley with towering, multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is wet, reflecting the vibrant neon lights. Tiny human figures walk through the alley, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

### Motion Choreography

#### Entrance Sequence
| Element | Animation | Values | Duration | Delay | Easing |
|---------|-----------|--------|----------|-------|--------|
| Container | 3D Unfold | rotateX: 45deg → 0 | 1.5s | 0s | cyber-slide |
| Scene | Zoom In | scale: 0.8 → 1 | 1.5s | 0.2s | ease-out |
| UI Panel | Glass Slide | x: 100% → 0% | 1.0s | 1.0s | cyber-slide |

#### Interaction Effects
- **Gyroscope (Mobile)**: Tilting the phone shifts the camera perspective within the 3D scene.
- **Mouse Move**: The scene rotates slightly (max 5deg) to follow the cursor, creating a "looking around" effect.

### Advanced Effects
- **Dynamic Lighting**: A WebGL overlay that adds "god rays" and light bloom to the neon signs, intensity controlled by the "Lights" slider.
- **Fog Shader**: Volumetric fog that drifts *in front* of the background buildings but *behind* the midground.

---

## Section 3: About - "The Architect"

### Layout
**Broken Grid / Overlap**
The text block overlaps the image by 20%. The image is framed by a "holographic" border that glitches occasionally.

#### Spatial Composition
- **Text**: Floats on the left (z: 2).
- **Image**: Anchored right (z: 1).
- **Frame**: Decorative SVG border that sits between text and image (z: 1.5).

### Content
- **Title**: "THE STORY BEHIND THE NOOK"
- **Body**: "Every miniature tells a story..." (Standard About Text)

### Images
**About Image**
- **Resolution:** 800x1000
- **Aspect Ratio:** 4:5
- **Transparent Background:** No
- **Visual Style:** Candid, documentary-style workshop photography
- **Subject:** Person's hands crafting miniature building, tools and materials scattered
- **Color Palette:** Warm browns, golds, soft whites; muted and cozy
- **Generation Prompt:** "A close-up, documentary-style photograph of a person's hands carefully crafting a miniature building. The scene is set on a cluttered workbench with tools, paintbrushes, and tiny building materials scattered around. The focus is on the detailed miniature structure, which features intricate architectural details. The lighting is warm and soft, creating a cozy, inviting atmosphere. The color palette includes warm browns, golds, and soft whites. The background is softly blurred, emphasizing the craftsmanship and the tactile nature of the work."

### Motion Choreography

#### Scroll Effects
| Trigger | Element | Effect | Start | End | Values |
|---------|---------|--------|-------|-----|--------|
| Scroll | Image | Parallax Y | Enter | Exit | y: -80px |
| Scroll | Text Block | Parallax Y | Enter | Exit | y: -40px |
| Scroll | Hologram Frame | Draw Path | Enter | 50% | stroke-dashoffset: 100% → 0% |

#### Continuous Animations
- **Hologram Glitch**: The frame around the image flickers/shifts horizontally by 2px every 5-8 seconds.
- **Dust Motes**: Tiny particles float in the foreground (canvas overlay) catching the "light".

---

## Section 4: Features - "Neon Grid"

### Layout
**Hexagonal/Offset Grid**
Cards are not aligned perfectly. They are offset in a brick-lay pattern. The grid lines are glowing neon.

#### Spatial Composition
- **Grid**: CSS Grid with variable column starts.
- **Connections**: Subtle SVG lines connect the cards, pulsing with data.

### Content
- **Title**: "FEATURES"
- **Cards**: Interactivity, Time Control, Customization.

### Images
**Feature 1 - Interactivity**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk alley
- **Subject:** Narrow alley with neon signs, people, tram wires
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a low angle. The scene features a narrow, winding alley with towering, multi-level buildings adorned with glowing neon signs in pink, purple, and yellow. The street is wet, reflecting the neon lights. Tiny human figures walk through the alley, some with umbrellas. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts and vending machines. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, and yellows against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

**Feature 2 - Time Control**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk night market
- **Subject:** Bustling street scene with neon signs, tiny people, tram
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a slightly elevated angle. The scene features a busy, narrow street with multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is filled with tiny human figures walking, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

**Feature 3 - Customization**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk scene
- **Subject:** Alley with neon signs, people, tram wires
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a low angle. The scene features a narrow, winding alley with towering, multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is wet, reflecting the neon lights. Tiny human figures walk through the alley, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

### Motion Choreography

#### Entrance Sequence
| Element | Animation | Values | Duration | Delay | Easing |
|---------|-----------|--------|----------|-------|--------|
| Cards | 3D Flip Up | rotateX: 90 → 0 | 0.8s | Stagger 0.1s | back-out |
| Grid Lines | Draw | scaleX: 0 → 1 | 1.2s | 0.5s | ease-out |

#### Interaction Effects
- **Card Hover**: 
  - Image zooms (scale 1.1).
  - A "scan line" gradient moves down the card.
  - The border glows brighter.

---

## Section 5: Testimonials - "Echoes"

### Layout
**Vertical Infinite Marquee**
Testimonials are arranged in two vertical columns moving in opposite directions (Up/Down). The user can "grab" the stream to slow it down or speed it up.

#### Spatial Composition
- **Columns**: Two flex columns, `justify-content: space-around`.
- **Masking**: Top and bottom of the section have gradient masks to fade content in/out.

### Content
- **Title**: "COMMUNITY ECHOES"
- **Cards**: Quotes from users.

### Images
**Testimonial 1 - Sarah Chen**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk scene
- **Subject:** Alley with neon signs, people, tram wires
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a low angle. The scene features a narrow, winding alley with towering, multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is wet, reflecting the neon lights. Tiny human figures walk through the alley, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

**Testimonial 2 - Marcus Rodriguez**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk scene
- **Subject:** Bustling street scene with neon signs, tiny people, tram
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a slightly elevated angle. The scene features a busy, narrow street with multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is filled with tiny human figures walking, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

**Testimonial 3 - Jin Wei**
- **Resolution:** 600x400
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk scene
- **Subject:** Alley with neon signs, people, tram wires
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene at night, viewed from a low angle. The scene features a narrow, winding alley with towering, multi-level buildings adorned with glowing neon signs in pink, purple, yellow, and blue. The street is wet, reflecting the neon lights. Tiny human figures walk through the alley, some with umbrellas, others in futuristic clothing. The buildings are detailed with tiny windows, some lit, some dark, and include small storefronts, vending machines, and potted plants. Overhead, tram wires and a small tram car are visible. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

### Motion Choreography
- **Infinite Loop**: CSS animation `translateY` from 0% to -100% (reversed for column 2).
- **Hover Pause**: Marquee slows to a stop on hover.
- **Cursor**: Changes to "Drag" icon over this section.

---

## Section 6: Interactive Demo - "The Lab"

### Layout
**Floating Control Deck**
The controls are not a flat bar but a 3D "deck" that tilts with mouse movement. The scene preview is a glowing window into the world.

#### Spatial Composition
- **Scene Container**: Centered, glowing border.
- **Controls**: Floating below, glassmorphism effect.

### Content
- **Controls**: Light Toggle, Sign Message Input, Time Slider.

### Images
**Interactive Scene - Day/Dusk/Night**
- **Resolution:** 1920x1080
- **Transparent Background:** No
- **Visual Style:** Hyper-realistic miniature cyberpunk diorama
- **Subject:** Narrow alley with neon signs, people, tram wires
- **Generation Prompt:** "A hyper-realistic, miniature cyberpunk city street scene in a book nook format, viewed from street level at night. The scene features multi-level buildings with glowing neon signs in pink, purple, yellow, and blue, narrow streets with wet pavement reflecting neon lights, and tiny human figures walking through the streets. The buildings are highly detailed with tiny windows, some lit, some dark, and include small storefronts, apartments, and stairways. The street is lined with miniature street lamps, vending machines, and potted plants. Overhead, there are tram wires and a small tram car. The color palette is dominated by neon pinks, purples, yellows, and blues against a deep blue night sky. The atmosphere is moody, vibrant, and cinematic."

### Motion Choreography
- **Time Slider**: As the user drags the slider, the scene cross-fades between 4 distinct states (Dawn, Day, Dusk, Night). The transition includes a hue-rotate and brightness filter.
- **Neon Sign Input**: As the user types, the text appears in the scene preview with a "flicker-on" animation.
- **Light Toggle**: A "thunderclap" flash effect (screen flash white then fade) occurs when lights turn on.

---

## Section 7: CTA - "The Jump"

### Layout
**Warp Speed Tunnel**
The background is a starfield/wireframe tunnel effect. The text sits in the center. The "Download" button is the focal point.

#### Spatial Composition
- **Background**: Canvas element rendering a starfield.
- **Text**: Centered, large, outlined (stroke) font that is transparent with glowing edges.

### Content
- **Title**: "READY TO EXPLORE?"
- **Button**: "DOWNLOAD EXPERIENCE"

### Motion Choreography
- **Tunnel Effect**: The background stars move towards the viewer (Z-axis movement).
- **Button Gravity**: The button attracts the cursor (magnetic button effect).
- **Text Reveal**: On scroll, the letters fill with solid color from bottom to top.

---

## Section 8: Footer - "System Boot"

### Layout
**Terminal Grid**
Clean, structured grid using monospace fonts. The background is a very subtle scanline texture.

### Content
- **Links**: Standard footer links.
- **Copyright**: "© 2024 Cyberpunk Book Nook"

### Motion Choreography
- **Scanlines**: A subtle horizontal line scan moves down the footer continuously.
- **Hover**: Links glow neon pink on hover.

---

## Technical Implementation Notes

### Required Libraries
- **GSAP (GreenSock)**: Core animation engine (ScrollTrigger, Flip).
- **Three.js / React-Three-Fiber**: For the Hero fog and Interactive Demo lighting effects.
- **Lenis**: For smooth momentum scrolling.
- **SplitType**: For text decomposition animations.

### Critical Performance Rules
- ✅ **Use transform3d()**: Force hardware acceleration for all moving parts.
- ✅ **Opacity over Visibility**: For fade effects, opacity is cheaper.
- ✅ **Will-Change**: Apply `will-change: transform` to the hero image and marquee elements only.
- ❌ **No Layout Thrashing**: Do not animate `width`, `height`, or `margin`.
- ❌ **Limit Filters**: Use `backdrop-filter` sparingly (only on the Control Deck).

### Browser Support
- **Feature Detection**: `@supports (backdrop-filter: blur(10px))` for glassmorphism fallbacks.
- **Reduced Motion**: If `prefers-reduced-motion` is true, disable parallax and marquee, switch to simple fades.

### Accessibility
- **Contrast**: Ensure text over images has sufficient shadow/backing.
- **Focus States**: All interactive elements have visible neon-green focus rings.
- **Screen Readers**: Text split for animation must be hidden from screen readers (`aria-hidden="true"`) and replaced with a clean version (`aria-label`).
