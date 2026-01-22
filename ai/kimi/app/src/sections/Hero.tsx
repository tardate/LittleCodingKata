import { useEffect, useRef, useState } from 'react';
import { gsap } from 'gsap';
import { ChevronDown, Sparkles } from 'lucide-react';

export function Hero() {
  const sectionRef = useRef<HTMLElement>(null);
  const titleRef = useRef<HTMLHeadingElement>(null);
  const subtitleRef = useRef<HTMLParagraphElement>(null);
  const imageRef = useRef<HTMLDivElement>(null);
  const seamRef = useRef<HTMLDivElement>(null);
  const [isLoaded, setIsLoaded] = useState(false);

  useEffect(() => {
    setIsLoaded(true);
    
    const ctx = gsap.context(() => {
      const tl = gsap.timeline({ defaults: { ease: 'power3.out' } });
      
      // Image zoom out
      tl.fromTo(imageRef.current, 
        { scale: 1.2, opacity: 0 },
        { scale: 1, opacity: 1, duration: 1.5 }
      );
      
      // Diagonal seam draw
      tl.fromTo(seamRef.current,
        { scaleX: 0, transformOrigin: 'left center' },
        { scaleX: 1, duration: 1 },
        '-=1'
      );
      
      // Title reveal
      tl.fromTo(titleRef.current,
        { y: 100, opacity: 0 },
        { y: 0, opacity: 1, duration: 1.2 },
        '-=0.5'
      );
      
      // Subtitle
      tl.fromTo(subtitleRef.current,
        { y: 50, opacity: 0 },
        { y: 0, opacity: 1, duration: 0.8 },
        '-=0.6'
      );
      
      // Continuous neon flicker on title
      gsap.to(titleRef.current, {
        filter: 'brightness(1.2)',
        duration: 0.1,
        repeat: -1,
        yoyo: true,
        repeatDelay: 3,
        ease: 'steps(1)',
      });
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section 
      ref={sectionRef}
      className="relative min-h-screen w-full overflow-hidden bg-cyber-dark"
    >
      {/* Background Image Layer */}
      <div 
        ref={imageRef}
        className="absolute inset-0 z-0"
        style={{ opacity: 0 }}
      >
        <div className="absolute inset-0 bg-gradient-to-br from-cyber-dark via-cyber-deepblue to-cyber-dark" />
        <img 
          src="/scene-night.jpg" 
          alt="Cyberpunk book nook" 
          className="w-full h-full object-cover opacity-60 mix-blend-lighten"
        />
        {/* Fog overlay */}
        <div className="absolute inset-0 bg-gradient-to-t from-cyber-dark via-transparent to-transparent" />
      </div>

      {/* Diagonal Neon Seam */}
      <div 
        ref={seamRef}
        className="absolute top-0 left-1/4 w-1 h-full -skew-x-12 z-10"
        style={{
          background: 'linear-gradient(180deg, transparent, #ff0080, #8b00ff, #00ffff, transparent)',
          boxShadow: '0 0 20px #ff0080, 0 0 40px #8b00ff',
          transform: 'scaleX(0)',
        }}
      />

      {/* Content */}
      <div className="relative z-20 min-h-screen flex flex-col justify-center px-6 md:px-12 lg:px-24">
        <div className="max-w-4xl">
          {/* Badge */}
          <div 
            className={`inline-flex items-center gap-2 px-4 py-2 rounded-full glass-panel mb-6 transition-all duration-700 ${
              isLoaded ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
            }`}
            style={{ transitionDelay: '0.8s' }}
          >
            <Sparkles className="w-4 h-4 text-cyber-pink" />
            <span className="text-xs font-mono text-cyber-cream uppercase tracking-wider">
              Interactive Miniature Diorama
            </span>
          </div>

          {/* Main Title */}
          <h1 
            ref={titleRef}
            className="font-display text-6xl sm:text-7xl md:text-8xl lg:text-9xl leading-none mb-6"
            style={{ 
              opacity: 0,
              color: '#e7d9cf',
              textShadow: '0 0 20px #ff0080, 0 0 40px #8b00ff, 0 0 60px #00ffff',
            }}
          >
            CYBERPUNK
            <br />
            <span className="text-cyber-pink">BOOK</span>{' '}
            <span className="text-cyber-blue">NOOK</span>
          </h1>

          {/* Subtitle */}
          <p 
            ref={subtitleRef}
            className="text-lg md:text-xl text-cyber-cream/80 max-w-xl mb-8 font-light"
            style={{ opacity: 0 }}
          >
            Step into a living, breathing cyberpunk world. Control the lights, 
            customize neon signs, and watch as the city comes alive with animated 
            creatures and the passage of time.
          </p>

          {/* CTA Buttons */}
          <div 
            className={`flex flex-wrap gap-4 transition-all duration-700 ${
              isLoaded ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
            }`}
            style={{ transitionDelay: '1.2s' }}
          >
            <a 
              href="#nook"
              className="group relative px-8 py-3 bg-cyber-pink text-white font-display text-lg rounded overflow-hidden transition-all hover:shadow-neon"
            >
              <span className="relative z-10">ENTER THE NOOK</span>
              <div className="absolute inset-0 bg-gradient-to-r from-cyber-purple to-cyber-blue opacity-0 group-hover:opacity-100 transition-opacity" />
            </a>
            <a 
              href="#demo"
              className="px-8 py-3 border border-cyber-cream/30 text-cyber-cream font-display text-lg rounded hover:bg-cyber-cream/10 transition-all"
            >
              TRY THE DEMO
            </a>
          </div>
        </div>
      </div>

      {/* Decorative Elements */}
      <div className="absolute bottom-0 left-0 right-0 h-32 bg-gradient-to-t from-cyber-dark to-transparent z-30" />
      
      {/* Grid Pattern */}
      <div className="absolute inset-0 cyber-grid opacity-10 z-5" />

      {/* Scroll Indicator */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2 z-30 animate-float">
        <a href="#nook" className="flex flex-col items-center text-cyber-cream/50 hover:text-cyber-pink transition-colors">
          <span className="text-xs font-mono mb-2">SCROLL</span>
          <ChevronDown className="w-5 h-5" />
        </a>
      </div>

      {/* Side Text */}
      <div className="absolute right-6 top-1/2 -translate-y-1/2 hidden lg:block">
        <div 
          className="font-mono text-xs text-cyber-cream/30 tracking-widest"
          style={{ writingMode: 'vertical-rl', textOrientation: 'mixed' }}
        >
          BOOK NOOK EXPERIENCE
        </div>
      </div>
    </section>
  );
}
