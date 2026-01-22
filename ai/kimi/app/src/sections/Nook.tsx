import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { BookNookScene } from '@/components/BookNookScene';
import { Eye, Zap, Clock } from 'lucide-react';

gsap.registerPlugin(ScrollTrigger);

export function Nook() {
  const sectionRef = useRef<HTMLElement>(null);
  const containerRef = useRef<HTMLDivElement>(null);
  const titleRef = useRef<HTMLHeadingElement>(null);

  useEffect(() => {
    const ctx = gsap.context(() => {
      // Title animation
      gsap.fromTo(titleRef.current,
        { y: 50, opacity: 0 },
        {
          y: 0,
          opacity: 1,
          duration: 1,
          scrollTrigger: {
            trigger: titleRef.current,
            start: 'top 80%',
            end: 'top 50%',
            scrub: 1,
          },
        }
      );

      // 3D unfold animation for the container
      gsap.fromTo(containerRef.current,
        { rotateX: 45, opacity: 0, scale: 0.8 },
        {
          rotateX: 0,
          opacity: 1,
          scale: 1,
          duration: 1.5,
          ease: 'power3.out',
          scrollTrigger: {
            trigger: containerRef.current,
            start: 'top 80%',
            end: 'top 30%',
            scrub: 1,
          },
        }
      );
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  const features = [
    {
      icon: Eye,
      title: 'Watch Life Unfold',
      description: 'Observe cats, rats, and birds as they navigate the cyberpunk streets in real-time.',
      color: 'cyber-pink',
    },
    {
      icon: Zap,
      title: 'Control the Energy',
      description: 'Toggle street lights and neon signs to change the mood of the entire scene.',
      color: 'cyber-blue',
    },
    {
      icon: Clock,
      title: 'Master Time',
      description: 'Experience the full day cycle from dawn to night, or control it manually.',
      color: 'cyber-green',
    },
  ];

  return (
    <section 
      ref={sectionRef}
      id="nook"
      className="relative py-24 md:py-32 px-6 md:px-12 lg:px-24 bg-cyber-dark"
    >
      {/* Background Grid */}
      <div className="absolute inset-0 cyber-grid opacity-5" />

      <div className="max-w-7xl mx-auto">
        {/* Header */}
        <div className="text-center mb-12 md:mb-16">
          <span className="inline-block px-4 py-1 rounded-full glass-panel text-xs font-mono text-cyber-pink uppercase tracking-wider mb-4">
            The Experience
          </span>
          <h2 
            ref={titleRef}
            className="font-display text-4xl md:text-5xl lg:text-6xl text-cyber-cream mb-4"
            style={{ opacity: 0 }}
          >
            PEER INTO THE <span className="text-cyber-pink">ALLEY</span>
          </h2>
          <p className="text-cyber-cream/70 max-w-2xl mx-auto font-light">
            Control the pulse of the city. Every light, every sign, every creature 
            responds to your commands in this living cyberpunk diorama.
          </p>
        </div>

        {/* 3D Theater Container */}
        <div 
          ref={containerRef}
          className="perspective-1000 mb-12"
          style={{ opacity: 0 }}
        >
          <div className="preserve-3d">
            <BookNookScene />
          </div>
        </div>

        {/* Feature Pills */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {features.map((feature, i) => (
            <div 
              key={i}
              className="glass-panel rounded-xl p-6 hover:border-cyber-pink/30 transition-all group"
              style={{ animationDelay: `${i * 100}ms` }}
            >
              <div className={`w-12 h-12 rounded-lg bg-${feature.color}/20 flex items-center justify-center mb-4 group-hover:scale-110 transition-transform`}>
                <feature.icon className={`w-6 h-6 text-${feature.color}`} />
              </div>
              <h3 className="font-display text-xl text-cyber-cream mb-2">
                {feature.title}
              </h3>
              <p className="text-sm text-cyber-cream/60">
                {feature.description}
              </p>
            </div>
          ))}
        </div>
      </div>

      {/* Decorative Corner Elements */}
      <div className="absolute top-12 left-12 w-24 h-24 border-l-2 border-t-2 border-cyber-pink/30" />
      <div className="absolute bottom-12 right-12 w-24 h-24 border-r-2 border-b-2 border-cyber-blue/30" />
    </section>
  );
}
