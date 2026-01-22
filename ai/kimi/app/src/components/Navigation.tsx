import { useState, useEffect } from 'react';
import { Menu, X, Zap } from 'lucide-react';

const navLinks = [
  { label: 'Nook', href: '#nook' },
  { label: 'Features', href: '#features' },
  { label: 'About', href: '#about' },
  { label: 'Demo', href: '#demo' },
];

export function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 100);
    };

    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const handleNavClick = (href: string) => {
    setIsMobileMenuOpen(false);
    const element = document.querySelector(href);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <>
      <nav 
        className={`fixed top-0 left-0 right-0 z-50 transition-all duration-500 ${
          isScrolled 
            ? 'bg-cyber-dark/80 backdrop-blur-lg border-b border-cyber-cream/10' 
            : 'bg-transparent'
        }`}
      >
        <div className="max-w-7xl mx-auto px-6 md:px-12 lg:px-24">
          <div className="flex items-center justify-between h-16 md:h-20">
            {/* Logo */}
            <a href="#" className="flex items-center gap-2 group">
              <Zap className="w-6 h-6 text-cyber-pink group-hover:text-cyber-blue transition-colors" />
              <span className="font-display text-xl text-cyber-cream">
                <span className="text-cyber-pink">CYBER</span>
                <span className="text-cyber-blue">NOOK</span>
              </span>
            </a>

            {/* Desktop Navigation */}
            <div className="hidden md:flex items-center gap-8">
              {navLinks.map((link) => (
                <button
                  key={link.label}
                  onClick={() => handleNavClick(link.href)}
                  className="text-sm text-cyber-cream/70 hover:text-cyber-pink transition-colors font-mono uppercase tracking-wider"
                >
                  {link.label}
                </button>
              ))}
              
              <button 
                onClick={() => handleNavClick('#cta')}
                className="px-4 py-2 bg-cyber-pink text-white text-sm font-mono rounded hover:bg-cyber-pink/80 transition-colors"
              >
                DOWNLOAD
              </button>
            </div>

            {/* Mobile Menu Button */}
            <button 
              className="md:hidden text-cyber-cream"
              onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
            >
              {isMobileMenuOpen ? <X className="w-6 h-6" /> : <Menu className="w-6 h-6" />}
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile Menu */}
      <div 
        className={`fixed inset-0 z-40 md:hidden transition-all duration-500 ${
          isMobileMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
        }`}
      >
        {/* Backdrop */}
        <div 
          className="absolute inset-0 bg-cyber-dark/95 backdrop-blur-lg"
          onClick={() => setIsMobileMenuOpen(false)}
        />
        
        {/* Menu Content */}
        <div className="relative h-full flex flex-col items-center justify-center gap-8">
          {navLinks.map((link, i) => (
            <button
              key={link.label}
              onClick={() => handleNavClick(link.href)}
              className="text-2xl font-display text-cyber-cream hover:text-cyber-pink transition-all"
              style={{ 
                transitionDelay: isMobileMenuOpen ? `${i * 50}ms` : '0ms',
                transform: isMobileMenuOpen ? 'translateY(0)' : 'translateY(20px)',
                opacity: isMobileMenuOpen ? 1 : 0,
              }}
            >
              {link.label}
            </button>
          ))}
          
          <button 
            onClick={() => handleNavClick('#cta')}
            className="mt-4 px-8 py-3 bg-cyber-pink text-white font-display text-lg rounded"
            style={{ 
              transitionDelay: isMobileMenuOpen ? '200ms' : '0ms',
              transform: isMobileMenuOpen ? 'translateY(0)' : 'translateY(20px)',
              opacity: isMobileMenuOpen ? 1 : 0,
            }}
          >
            DOWNLOAD
          </button>
        </div>
      </div>
    </>
  );
}
