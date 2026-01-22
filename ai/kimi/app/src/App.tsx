import { useEffect } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { Navigation } from '@/components/Navigation';
import { Hero } from '@/sections/Hero';
import { Nook } from '@/sections/Nook';
import { About } from '@/sections/About';
import { Features } from '@/sections/Features';
import { Testimonials } from '@/sections/Testimonials';
import { Demo } from '@/sections/Demo';
import { CTA } from '@/sections/CTA';
import { Footer } from '@/sections/Footer';
import './App.css';

gsap.registerPlugin(ScrollTrigger);

function App() {
  useEffect(() => {
    // Initialize smooth scroll behavior
    document.documentElement.style.scrollBehavior = 'smooth';

    // Refresh ScrollTrigger on load
    ScrollTrigger.refresh();

    // Cleanup
    return () => {
      ScrollTrigger.getAll().forEach(trigger => trigger.kill());
    };
  }, []);

  return (
    <div className="relative min-h-screen bg-cyber-dark">
      {/* Navigation */}
      <Navigation />

      {/* Main Content */}
      <main>
        <Hero />
        <Nook />
        <About />
        <Features />
        <Testimonials />
        <Demo />
        <CTA />
      </main>

      {/* Footer */}
      <Footer />

      {/* Global Effects */}
      <div className="fixed inset-0 pointer-events-none z-50">
        {/* Subtle Grain Overlay */}
        <div 
          className="absolute inset-0 opacity-[0.03]"
          style={{
            backgroundImage: `url("data:image/svg+xml,%3Csvg viewBox='0 0 400 400' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E")`,
          }}
        />
        
        {/* Vignette */}
        <div 
          className="absolute inset-0"
          style={{
            background: 'radial-gradient(circle at center, transparent 40%, rgba(10, 10, 10, 0.4) 100%)',
          }}
        />
      </div>
    </div>
  );
}

export default App;
