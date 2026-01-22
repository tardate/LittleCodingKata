import { useRef, useState } from 'react';
import { Quote, Star } from 'lucide-react';

const testimonials = [
  {
    name: 'Sarah Chen',
    role: 'Digital Artist',
    quote: 'The level of detail in this book nook is absolutely mind-blowing. I spent hours just watching the creatures move around.',
    rating: 5,
    image: '/feature-interactive.jpg',
  },
  {
    name: 'Marcus Rodriguez',
    role: 'Game Developer',
    quote: 'As a developer, I appreciate the technical mastery here. The lighting system alone is a work of art.',
    rating: 5,
    image: '/feature-time.jpg',
  },
  {
    name: 'Jin Wei',
    role: 'Miniature Collector',
    quote: 'This bridges the gap between physical miniatures and digital art perfectly. The interactivity adds a whole new dimension.',
    rating: 5,
    image: '/feature-custom.jpg',
  },
  {
    name: 'Emma Thompson',
    role: 'Cyberpunk Fan',
    quote: 'Finally, a way to live in the cyberpunk world without leaving my browser. The neon signs are gorgeous!',
    rating: 5,
    image: '/feature-interactive.jpg',
  },
  {
    name: 'Alex Park',
    role: 'Creative Director',
    quote: 'The atmospheric effects—the fog, the lighting, the animations—create an incredibly immersive experience.',
    rating: 5,
    image: '/feature-time.jpg',
  },
  {
    name: 'Nina Kowalski',
    role: 'Storyteller',
    quote: 'I use this as inspiration for my writing. Every corner tells a story. Every shadow hides a secret.',
    rating: 5,
    image: '/feature-custom.jpg',
  },
];

export function Testimonials() {
  const sectionRef = useRef<HTMLElement>(null);
  const [isPaused, setIsPaused] = useState(false);
  const [isDragging, setIsDragging] = useState(false);

  const column1 = testimonials.slice(0, 3);
  const column2 = testimonials.slice(3);

  return (
    <section 
      ref={sectionRef}
      id="testimonials"
      className="relative py-24 md:py-32 bg-cyber-dark overflow-hidden"
    >
      {/* Background */}
      <div className="absolute inset-0">
        <div className="cyber-grid opacity-5" />
      </div>

      <div className="max-w-7xl mx-auto px-6 md:px-12 lg:px-24">
        {/* Header */}
        <div className="text-center mb-16">
          <span className="inline-block px-4 py-1 rounded-full glass-panel text-xs font-mono text-cyber-yellow uppercase tracking-wider mb-4">
            Community
          </span>
          <h2 className="font-display text-4xl md:text-5xl lg:text-6xl text-cyber-cream mb-4">
            ECHOES FROM THE <span className="text-cyber-yellow">CITY</span>
          </h2>
          <p className="text-cyber-cream/70 max-w-2xl mx-auto font-light">
            Hear what fellow cyberpunk enthusiasts are saying about their journey 
            into the neon-lit streets.
          </p>
        </div>

        {/* Marquee Container */}
        <div 
          className={`relative h-[600px] overflow-hidden ${isDragging ? 'cursor-grabbing' : 'cursor-grab'}`}
          onMouseEnter={() => setIsPaused(true)}
          onMouseLeave={() => setIsPaused(false)}
          onMouseDown={() => setIsDragging(true)}
          onMouseUp={() => setIsDragging(false)}
        >
          {/* Gradient Masks */}
          <div className="absolute top-0 left-0 right-0 h-24 bg-gradient-to-b from-cyber-dark to-transparent z-10 pointer-events-none" />
          <div className="absolute bottom-0 left-0 right-0 h-24 bg-gradient-to-t from-cyber-dark to-transparent z-10 pointer-events-none" />

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
            {/* Column 1 - Scroll Up */}
            <div className="relative overflow-hidden">
              <div 
                className={`flex flex-col gap-6 ${isPaused ? '' : 'animate-marquee-up'}`}
                style={{ animationPlayState: isPaused ? 'paused' : 'running' }}
              >
                {[...column1, ...column1].map((testimonial, i) => (
                  <TestimonialCard key={i} {...testimonial} />
                ))}
              </div>
            </div>

            {/* Column 2 - Scroll Down */}
            <div className="relative overflow-hidden hidden md:block">
              <div 
                className={`flex flex-col gap-6 ${isPaused ? '' : 'animate-marquee-down'}`}
                style={{ animationPlayState: isPaused ? 'paused' : 'running' }}
              >
                {[...column2, ...column2].map((testimonial, i) => (
                  <TestimonialCard key={i} {...testimonial} />
                ))}
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}

interface TestimonialCardProps {
  name: string;
  role: string;
  quote: string;
  rating: number;
  image: string;
}

function TestimonialCard({ name, role, quote, rating, image }: TestimonialCardProps) {
  return (
    <div className="glass-panel rounded-xl p-6 hover:border-cyber-pink/30 transition-all group">
      {/* Header */}
      <div className="flex items-start gap-4 mb-4">
        <div className="w-12 h-12 rounded-full overflow-hidden flex-shrink-0">
          <img 
            src={image} 
            alt={name}
            className="w-full h-full object-cover"
          />
        </div>
        <div>
          <h4 className="font-display text-lg text-cyber-cream">{name}</h4>
          <p className="text-xs text-cyber-cream/50">{role}</p>
        </div>
      </div>

      {/* Quote */}
      <div className="relative">
        <Quote className="absolute -top-2 -left-2 w-6 h-6 text-cyber-pink/30" />
        <p className="text-sm text-cyber-cream/70 leading-relaxed pl-4">
          {quote}
        </p>
      </div>

      {/* Rating */}
      <div className="flex gap-1 mt-4">
        {Array.from({ length: rating }).map((_, i) => (
          <Star key={i} className="w-4 h-4 fill-cyber-yellow text-cyber-yellow" />
        ))}
      </div>
    </div>
  );
}
