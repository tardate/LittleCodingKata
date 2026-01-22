import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { MousePointer, Clock, Palette, ChevronRight } from 'lucide-react';

gsap.registerPlugin(ScrollTrigger);

const features = [
  {
    icon: MousePointer,
    title: 'Full Interactivity',
    description: 'Every element responds to your touch. Toggle lights, control animations, and watch the city react in real-time.',
    image: '/feature-interactive.jpg',
    color: 'cyber-pink',
    gradient: 'from-cyber-pink to-cyber-purple',
  },
  {
    icon: Clock,
    title: 'Time Control',
    description: 'Experience the full day cycle from dawn to night. Watch how the lighting transforms the entire atmosphere.',
    image: '/feature-time.jpg',
    color: 'cyber-blue',
    gradient: 'from-cyber-blue to-cyber-green',
  },
  {
    icon: Palette,
    title: 'Deep Customization',
    description: 'Write your own messages on neon signs. Adjust fog density, fan speeds, and creature activity levels.',
    image: '/feature-custom.jpg',
    color: 'cyber-green',
    gradient: 'from-cyber-green to-cyber-yellow',
  },
];

export function Features() {
  const sectionRef = useRef<HTMLElement>(null);
  const cardsRef = useRef<(HTMLDivElement | null)[]>([]);
  const gridLinesRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const ctx = gsap.context(() => {
      // Cards 3D flip animation
      cardsRef.current.forEach((card, i) => {
        if (!card) return;
        
        gsap.fromTo(card,
          { rotateX: 90, opacity: 0, y: 50 },
          {
            rotateX: 0,
            opacity: 1,
            y: 0,
            duration: 0.8,
            ease: 'back.out(1.7)',
            scrollTrigger: {
              trigger: card,
              start: 'top 85%',
              toggleActions: 'play none none reverse',
            },
            delay: i * 0.1,
          }
        );
      });

      // Grid lines draw animation
      if (gridLinesRef.current) {
        gsap.fromTo(gridLinesRef.current,
          { scaleX: 0, transformOrigin: 'left center' },
          {
            scaleX: 1,
            duration: 1.2,
            ease: 'power2.out',
            scrollTrigger: {
              trigger: sectionRef.current,
              start: 'top 60%',
              end: 'top 20%',
              scrub: 1,
            },
          }
        );
      }
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section 
      ref={sectionRef}
      id="features"
      className="relative py-24 md:py-32 px-6 md:px-12 lg:px-24 bg-cyber-dark overflow-hidden"
    >
      {/* Background Grid with Lines */}
      <div className="absolute inset-0">
        <div className="cyber-grid opacity-10" />
        <div 
          ref={gridLinesRef}
          className="absolute top-1/2 left-0 right-0 h-px bg-gradient-to-r from-transparent via-cyber-pink to-transparent"
          style={{ transform: 'scaleX(0)' }}
        />
      </div>

      <div className="max-w-7xl mx-auto relative">
        {/* Header */}
        <div className="text-center mb-16">
          <span className="inline-block px-4 py-1 rounded-full glass-panel text-xs font-mono text-cyber-green uppercase tracking-wider mb-4">
            Capabilities
          </span>
          <h2 className="font-display text-4xl md:text-5xl lg:text-6xl text-cyber-cream mb-4">
            NEON <span className="text-cyber-green">FEATURES</span>
          </h2>
          <p className="text-cyber-cream/70 max-w-2xl mx-auto font-light">
            A fully interactive cyberpunk experience with unprecedented control 
            over every aspect of the miniature world.
          </p>
        </div>

        {/* Feature Cards - Offset Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 md:gap-8">
          {features.map((feature, i) => (
            <div
              key={i}
              ref={el => { cardsRef.current[i] = el; }}
              className={`group relative ${i === 1 ? 'md:mt-12' : ''}`}
              style={{ 
                opacity: 0,
                perspective: '1000px',
              }}
            >
              <div className="relative h-full glass-panel rounded-xl overflow-hidden transition-all duration-500 hover:shadow-neon hover:border-cyber-pink/30">
                {/* Image */}
                <div className="relative h-48 overflow-hidden">
                  <img 
                    src={feature.image} 
                    alt={feature.title}
                    className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110"
                  />
                  {/* Scan Line on Hover */}
                  <div className="absolute inset-0 bg-gradient-to-b from-transparent via-cyber-pink/20 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-500" 
                    style={{ animation: 'scan-line 2s linear infinite' }}
                  />
                  {/* Icon Overlay */}
                  <div className="absolute inset-0 flex items-center justify-center">
                    <div className={`w-16 h-16 rounded-full bg-${feature.color}/20 backdrop-blur-sm flex items-center justify-center`}>
                      <feature.icon className={`w-8 h-8 text-${feature.color}`} />
                    </div>
                  </div>
                </div>

                {/* Content */}
                <div className="p-6">
                  <h3 className="font-display text-2xl text-cyber-cream mb-3 group-hover:text-cyber-pink transition-colors">
                    {feature.title}
                  </h3>
                  <p className="text-sm text-cyber-cream/60 leading-relaxed mb-4">
                    {feature.description}
                  </p>
                  <button className="flex items-center gap-2 text-sm text-cyber-pink font-mono group/btn">
                    LEARN MORE
                    <ChevronRight className="w-4 h-4 transition-transform group-hover/btn:translate-x-1" />
                  </button>
                </div>

                {/* Border Glow */}
                <div 
                  className={`absolute inset-0 rounded-xl opacity-0 group-hover:opacity-100 transition-opacity pointer-events-none`}
                  style={{
                    boxShadow: `inset 0 0 20px rgba(255, 0, 128, 0.2)`,
                  }}
                />
              </div>
            </div>
          ))}
        </div>

        {/* Connection Lines (SVG) */}
        <svg className="absolute top-0 left-0 w-full h-full pointer-events-none hidden lg:block" style={{ zIndex: -1 }}>
          <defs>
            <linearGradient id="lineGradient" x1="0%" y1="0%" x2="100%" y2="0%">
              <stop offset="0%" stopColor="#ff0080" stopOpacity="0.3" />
              <stop offset="50%" stopColor="#8b00ff" stopOpacity="0.3" />
              <stop offset="100%" stopColor="#00ffff" stopOpacity="0.3" />
            </linearGradient>
          </defs>
          <path 
            d="M 200 200 Q 400 150 600 200 T 1000 200"
            fill="none"
            stroke="url(#lineGradient)"
            strokeWidth="1"
            className="animate-neon-pulse"
          />
        </svg>
      </div>
    </section>
  );
}
