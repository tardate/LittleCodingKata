import { useEffect, useRef } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { Download, Sparkles, Zap } from 'lucide-react';
import { Button } from '@/components/ui/button';

gsap.registerPlugin(ScrollTrigger);

export function CTA() {
  const sectionRef = useRef<HTMLElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const titleRef = useRef<HTMLHeadingElement>(null);
  const buttonRef = useRef<HTMLButtonElement>(null);

  // Starfield/Warp Tunnel Effect
  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    let animationId: number;
    let stars: { x: number; y: number; z: number }[] = [];
    const numStars = 200;
    let speed = 2;
    let isWarpSpeed = false;

    const resize = () => {
      canvas.width = canvas.offsetWidth;
      canvas.height = canvas.offsetHeight;
    };

    const initStars = () => {
      stars = [];
      for (let i = 0; i < numStars; i++) {
        stars.push({
          x: Math.random() * canvas.width - canvas.width / 2,
          y: Math.random() * canvas.height - canvas.height / 2,
          z: Math.random() * canvas.width,
        });
      }
    };

    const animate = () => {
      ctx.fillStyle = 'rgba(10, 10, 10, 0.2)';
      ctx.fillRect(0, 0, canvas.width, canvas.height);

      const centerX = canvas.width / 2;
      const centerY = canvas.height / 2;

      ctx.save();
      ctx.translate(centerX, centerY);

      stars.forEach((star) => {
        star.z -= speed;
        if (star.z <= 0) {
          star.x = Math.random() * canvas.width - centerX;
          star.y = Math.random() * canvas.height - centerY;
          star.z = canvas.width;
        }

        const sx = (star.x / star.z) * 300;
        const sy = (star.y / star.z) * 300;
        const size = Math.max(0.5, (1 - star.z / canvas.width) * 3);

        // Draw star trail
        const px = (star.x / (star.z + speed * 10)) * 300;
        const py = (star.y / (star.z + speed * 10)) * 300;

        ctx.beginPath();
        ctx.moveTo(px, py);
        ctx.lineTo(sx, sy);
        ctx.strokeStyle = `rgba(255, 0, 128, ${1 - star.z / canvas.width})`;
        ctx.lineWidth = size;
        ctx.stroke();

        // Draw star point
        ctx.beginPath();
        ctx.arc(sx, sy, size / 2, 0, Math.PI * 2);
        ctx.fillStyle = `rgba(255, 255, 255, ${1 - star.z / canvas.width})`;
        ctx.fill();
      });

      ctx.restore();
      animationId = requestAnimationFrame(animate);
    };

    resize();
    initStars();
    animate();

    window.addEventListener('resize', () => {
      resize();
      initStars();
    });

    // Scroll-based warp speed
    const handleScroll = () => {
      const rect = sectionRef.current?.getBoundingClientRect();
      if (rect) {
        const progress = 1 - (rect.top / window.innerHeight);
        isWarpSpeed = progress > 0.5;
        speed = isWarpSpeed ? 8 : 2;
      }
    };

    window.addEventListener('scroll', handleScroll, { passive: true });

    return () => {
      cancelAnimationFrame(animationId);
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  // Text and button animations
  useEffect(() => {
    const ctx = gsap.context(() => {
      // Text fill animation
      gsap.fromTo(titleRef.current,
        { 
          backgroundSize: '100% 0%',
        },
        {
          backgroundSize: '100% 100%',
          duration: 1.5,
          ease: 'power2.out',
          scrollTrigger: {
            trigger: sectionRef.current,
            start: 'top 60%',
            end: 'top 20%',
            scrub: 1,
          },
        }
      );

      // Button magnetic effect
      const button = buttonRef.current;
      if (button) {
        button.addEventListener('mouseenter', () => {
          gsap.to(button, { scale: 1.05, duration: 0.3 });
        });
        button.addEventListener('mouseleave', () => {
          gsap.to(button, { scale: 1, duration: 0.3 });
        });
      }
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  return (
    <section 
      ref={sectionRef}
      id="cta"
      className="relative py-32 md:py-48 overflow-hidden bg-cyber-dark"
    >
      {/* Canvas Background - Warp Tunnel */}
      <canvas 
        ref={canvasRef}
        className="absolute inset-0 w-full h-full"
      />

      {/* Content */}
      <div className="relative z-10 text-center px-6">
        {/* Badge */}
        <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass-panel mb-8">
          <Sparkles className="w-4 h-4 text-cyber-pink" />
          <span className="text-xs font-mono text-cyber-cream uppercase tracking-wider">
            Ready to Dive In?
          </span>
        </div>

        {/* Main Title */}
        <h2 
          ref={titleRef}
          className="font-display text-5xl md:text-7xl lg:text-8xl mb-6"
          style={{
            background: 'linear-gradient(to top, #e7d9cf 50%, transparent 50%)',
            backgroundSize: '100% 0%',
            backgroundRepeat: 'no-repeat',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
            textShadow: '0 0 40px rgba(255, 0, 128, 0.5)',
          }}
        >
          READY TO
          <br />
          <span className="text-cyber-pink">EXPLORE?</span>
        </h2>

        {/* Subtitle */}
        <p className="text-lg md:text-xl text-cyber-cream/70 max-w-2xl mx-auto mb-10 font-light">
          Download the complete experience and immerse yourself in a living, 
          breathing cyberpunk world. Your journey into the neon-lit streets awaits.
        </p>

        {/* CTA Button */}
        <Button 
          ref={buttonRef}
          className="group relative px-12 py-6 bg-cyber-pink text-white font-display text-xl rounded-lg overflow-hidden shadow-neon hover:shadow-neon-purple transition-all"
        >
          {/* Animated Background */}
          <div className="absolute inset-0 bg-gradient-to-r from-cyber-purple via-cyber-blue to-cyber-green opacity-0 group-hover:opacity-100 transition-opacity duration-500" 
            style={{ backgroundSize: '200% 100%', animation: 'gradient-shift 3s linear infinite' }}
          />
          
          <span className="relative z-10 flex items-center gap-3">
            <Download className="w-5 h-5" />
            DOWNLOAD EXPERIENCE
            <Zap className="w-5 h-5" />
          </span>
        </Button>

        {/* Trust Badges */}
        <div className="flex flex-wrap justify-center gap-6 mt-10 text-cyber-cream/40 text-sm font-mono">
          <span>NO INSTALLATION</span>
          <span className="text-cyber-pink">•</span>
          <span>CROSS-PLATFORM</span>
          <span className="text-cyber-pink">•</span>
          <span>FREE FOREVER</span>
        </div>
      </div>

      {/* Vignette Effect */}
      <div className="absolute inset-0 pointer-events-none" 
        style={{
          background: 'radial-gradient(circle at center, transparent 30%, rgba(10, 10, 10, 0.8) 100%)',
        }}
      />
    </section>
  );
}
