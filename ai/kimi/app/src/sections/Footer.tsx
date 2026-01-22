import { Github, Twitter, Mail, Heart } from 'lucide-react';

const footerLinks = {
  explore: [
    { label: 'The Nook', href: '#nook' },
    { label: 'Interactive Demo', href: '#demo' },
    { label: 'Features', href: '#features' },
    { label: 'About', href: '#about' },
  ],
  resources: [
    { label: 'Documentation', href: '#' },
    { label: 'Tutorials', href: '#' },
    { label: 'Community', href: '#' },
    { label: 'Support', href: '#' },
  ],
  legal: [
    { label: 'Privacy Policy', href: '#' },
    { label: 'Terms of Service', href: '#' },
    { label: 'Cookie Policy', href: '#' },
  ],
};

const socialLinks = [
  { icon: Twitter, href: '#', label: 'Twitter' },
  { icon: Github, href: '#', label: 'GitHub' },
  { icon: Mail, href: '#', label: 'Email' },
];

export function Footer() {
  return (
    <footer className="relative bg-cyber-dark border-t border-cyber-cream/10">
      {/* Scanline Effect */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        <div 
          className="w-full h-px bg-cyber-pink/20"
          style={{
            animation: 'scanline 8s linear infinite',
          }}
        />
      </div>

      <div className="max-w-7xl mx-auto px-6 md:px-12 lg:px-24 py-16">
        {/* Main Footer Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-12 mb-12">
          {/* Brand Column */}
          <div className="lg:col-span-2">
            <div className="flex items-center gap-2 mb-4">
              <span className="font-display text-3xl text-cyber-pink">CYBER</span>
              <span className="font-display text-3xl text-cyber-blue">NOOK</span>
            </div>
            <p className="text-sm text-cyber-cream/60 mb-6 max-w-sm leading-relaxed">
              A living, breathing cyberpunk diorama. Immerse yourself in the neon-lit 
              streets and control every aspect of this miniature world.
            </p>
            
            {/* Social Links */}
            <div className="flex gap-4">
              {socialLinks.map((social) => (
                <a
                  key={social.label}
                  href={social.href}
                  aria-label={social.label}
                  className="w-10 h-10 rounded-lg glass-panel flex items-center justify-center text-cyber-cream/60 hover:text-cyber-pink hover:border-cyber-pink/30 transition-all"
                >
                  <social.icon className="w-5 h-5" />
                </a>
              ))}
            </div>
          </div>

          {/* Links Columns */}
          <div>
            <h4 className="font-mono text-xs text-cyber-pink uppercase tracking-wider mb-4">
              EXPLORE
            </h4>
            <ul className="space-y-3">
              {footerLinks.explore.map((link) => (
                <li key={link.label}>
                  <a 
                    href={link.href}
                    className="text-sm text-cyber-cream/60 hover:text-cyber-green transition-colors font-mono"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h4 className="font-mono text-xs text-cyber-blue uppercase tracking-wider mb-4">
              RESOURCES
            </h4>
            <ul className="space-y-3">
              {footerLinks.resources.map((link) => (
                <li key={link.label}>
                  <a 
                    href={link.href}
                    className="text-sm text-cyber-cream/60 hover:text-cyber-green transition-colors font-mono"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>

          <div>
            <h4 className="font-mono text-xs text-cyber-green uppercase tracking-wider mb-4">
              LEGAL
            </h4>
            <ul className="space-y-3">
              {footerLinks.legal.map((link) => (
                <li key={link.label}>
                  <a 
                    href={link.href}
                    className="text-sm text-cyber-cream/60 hover:text-cyber-green transition-colors font-mono"
                  >
                    {link.label}
                  </a>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Newsletter */}
        <div className="glass-panel rounded-lg p-6 mb-12">
          <div className="flex flex-col md:flex-row items-center justify-between gap-4">
            <div>
              <h4 className="font-display text-xl text-cyber-cream mb-1">
                JOIN THE NEON NEWSLETTER
              </h4>
              <p className="text-sm text-cyber-cream/50">
                Get updates on new features and exclusive content.
              </p>
            </div>
            <div className="flex gap-2 w-full md:w-auto">
              <input 
                type="email"
                placeholder="your@email.com"
                className="flex-1 md:w-64 px-4 py-2 bg-cyber-dark/50 border border-cyber-cream/20 rounded-lg text-cyber-cream placeholder:text-cyber-cream/30 focus:outline-none focus:border-cyber-pink/50 font-mono text-sm"
              />
              <button className="px-6 py-2 bg-cyber-pink text-white rounded-lg font-mono text-sm hover:bg-cyber-pink/80 transition-colors">
                SUBSCRIBE
              </button>
            </div>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="flex flex-col md:flex-row items-center justify-between gap-4 pt-8 border-t border-cyber-cream/10">
          <p className="text-xs text-cyber-cream/40 font-mono flex items-center gap-1">
            © 2077 CYBERPUNK BOOK NOOK
            <span className="mx-2">|</span>
            BUILT WITH <Heart className="w-3 h-3 text-cyber-pink inline" /> IN THE NEON CITY
          </p>
          
          {/* System Status */}
          <div className="flex items-center gap-4 text-xs text-cyber-cream/40 font-mono">
            <span className="flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-cyber-green animate-pulse" />
              SYSTEM ONLINE
            </span>
            <span className="flex items-center gap-1">
              <span className="w-2 h-2 rounded-full bg-cyber-pink" />
              NEON ACTIVE
            </span>
          </div>
        </div>
      </div>

      {/* Decorative Corner */}
      <div className="absolute bottom-0 right-0 w-32 h-32 border-r border-b border-cyber-pink/20" />
    </footer>
  );
}
