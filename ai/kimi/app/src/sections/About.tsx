import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { Wrench, Heart, Lightbulb } from 'lucide-react';

gsap.registerPlugin(ScrollTrigger);

export function About() {
  const sectionRef = useRef<HTMLElement>(null);
  const imageRef = useRef<HTMLDivElement>(null);
  const textRef = useRef<HTMLDivElement>(null);
  const frameRef = useRef<SVGSVGElement>(null);

  useEffect(() => {
    const ctx = gsap.context(() => {
      // Image parallax
      gsap.fromTo(imageRef.current,
        { y: 80 },
        {
          y: -80,
          ease: 'none',
          scrollTrigger: {
            trigger: sectionRef.current,
            start: 'top bottom',
            end: 'bottom top',
            scrub: 1,
          },
        }
      );

      // Text parallax (slower)
      gsap.fromTo(textRef.current,
        { y: 40 },
        {
          y: -40,
          ease: 'none',
          scrollTrigger: {
            trigger: sectionRef.current,
            start: 'top bottom',
            end: 'bottom top',
            scrub: 1,
          },
        }
      );

      // Hologram frame draw animation
      if (frameRef.current) {
        const path = frameRef.current.querySelector('rect');
        if (path) {
          const length = (path as SVGRectElement).getTotalLength?.() || 1000;
          gsap.set(path, {
            strokeDasharray: length,
            strokeDashoffset: length,
          });
          gsap.to(path, {
            strokeDashoffset: 0,
            duration: 2,
            ease: 'power2.out',
            scrollTrigger: {
              trigger: sectionRef.current,
              start: 'top 60%',
              end: 'top 20%',
              scrub: 1,
            },
          });
        }
      }

      // Text reveal
      gsap.fromTo(textRef.current,
        { opacity: 0, x: -50 },
        {
          opacity: 1,
          x: 0,
          duration: 1,
          scrollTrigger: {
            trigger: sectionRef.current,
            start: 'top 70%',
            toggleActions: 'play none none reverse',
          },
        }
      );
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  const stats = [
    { icon: Wrench, value: '100+', label: 'Hours Crafted' },
    { icon: Heart, value: '50+', label: 'Neon Elements' },
    { icon: Lightbulb, value: '∞', label: 'Possibilities' },
  ];

  return (
    <section 
      ref={sectionRef}
      id="about"
      className="relative py-24 md:py-32 px-6 md:px-12 lg:px-24 bg-cyber-dark overflow-hidden"
    >
      {/* Background Elements */}
      <div className="absolute top-1/4 right-0 w-96 h-96 bg-cyber-pink/5 rounded-full blur-3xl" />
      <div className="absolute bottom-1/4 left-0 w-96 h-96 bg-cyber-blue/5 rounded-full blur-3xl" />

      <div className="max-w-7xl mx-auto">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-24 items-center">
          {/* Text Content - Left Side */}
          <div 
            ref={textRef}
            className="relative z-10 lg:pr-8"
            style={{ opacity: 0 }}
          >
            <span className="inline-block px-4 py-1 rounded-full glass-panel text-xs font-mono text-cyber-blue uppercase tracking-wider mb-4">
              The Architect
            </span>
            
            <h2 className="font-display text-4xl md:text-5xl lg:text-6xl text-cyber-cream mb-6">
              THE STORY BEHIND
              <br />
              <span className="text-cyber-blue">THE NOOK</span>
            </h2>
            
            <div className="space-y-4 text-cyber-cream/70 font-light leading-relaxed">
              <p>
                Every miniature tells a story. This cyberpunk book nook is a labor of love, 
                crafted with meticulous attention to detail. From the flickering neon signs 
                to the scurrying creatures, every element breathes life into this tiny world.
              </p>
              <p>
                Inspired by the neon-soaked streets of Blade Runner and the intimate scale 
                of Japanese miniature art, this interactive experience bridges the gap between 
                digital art and physical dioramas. You are not just a viewer—you are the 
                master of this cyberpunk domain.
              </p>
              <p>
                Control the pulse of the city. Watch as day turns to night, as creatures 
                emerge from shadows, as the neon signs flicker to life. This is your world 
                to explore.
              </p>
            </div>

            {/* Stats */}
            <div className="grid grid-cols-3 gap-4 mt-8">
              {stats.map((stat, i) => (
                <div 
                  key={i}
                  className="text-center p-4 glass-panel rounded-lg"
                >
                  <stat.icon className="w-6 h-6 text-cyber-green mx-auto mb-2" />
                  <div className="font-display text-2xl text-cyber-cream">{stat.value}</div>
                  <div className="text-xs text-cyber-cream/50">{stat.label}</div>
                </div>
              ))}
            </div>
          </div>

          {/* Image - Right Side */}
          <div className="relative">
            {/* Holographic Frame */}
            <svg 
              ref={frameRef}
              className="absolute -inset-4 w-[calc(100%+32px)] h-[calc(100%+32px)] pointer-events-none"
              style={{ zIndex: 15 }}
            >
              <defs>
                <linearGradient id="frameGradient" x1="0%" y1="0%" x2="100%" y2="100%">
                  <stop offset="0%" stopColor="#ff0080" stopOpacity="0.8" />
                  <stop offset="50%" stopColor="#8b00ff" stopOpacity="0.8" />
                  <stop offset="100%" stopColor="#00ffff" stopOpacity="0.8" />
                </linearGradient>
              </defs>
              <rect 
                x="16" y="16" 
                width="calc(100% - 32px)" 
                height="calc(100% - 32px)" 
                fill="none" 
                stroke="url(#frameGradient)" 
                strokeWidth="2"
                rx="8"
              />
            </svg>

            {/* Glitch Effect Overlay */}
            <div 
              className="absolute inset-0 bg-gradient-to-r from-cyber-pink/10 via-transparent to-cyber-blue/10 animate-neon-flicker pointer-events-none"
              style={{ zIndex: 20 }}
            />

            {/* Main Image */}
            <div 
              ref={imageRef}
              className="relative rounded-lg overflow-hidden shadow-2xl"
              style={{ transform: 'translateY(80px)' }}
            >
              <img 
                src="/about-crafter.jpg" 
                alt="Crafting the book nook" 
                className="w-full h-auto"
              />
              {/* Scan Line Effect */}
              <div className="absolute inset-0 scanlines pointer-events-none" />
            </div>

            {/* Floating Particles */}
            <div className="absolute -top-4 -right-4 w-3 h-3 bg-cyber-pink rounded-full animate-float" />
            <div className="absolute top-1/2 -left-8 w-2 h-2 bg-cyber-blue rounded-full animate-float" style={{ animationDelay: '1s' }} />
            <div className="absolute -bottom-4 right-1/4 w-4 h-4 bg-cyber-green rounded-full animate-float" style={{ animationDelay: '2s' }} />
          </div>
        </div>
      </div>

      {/* Decorative Lines */}
      <div className="absolute top-1/2 left-0 w-32 h-px bg-gradient-to-r from-cyber-pink to-transparent" />
      <div className="absolute top-1/3 right-0 w-32 h-px bg-gradient-to-l from-cyber-blue to-transparent" />
    </section>
  );
}
