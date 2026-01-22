import { useState, useRef, useEffect } from 'react';
import { gsap } from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';
import { BookNookScene } from '@/components/BookNookScene';
import { Play, Pause, SkipBack, SkipForward, Lightbulb, MessageSquare, Clock } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Slider } from '@/components/ui/slider';
import { Input } from '@/components/ui/input';

gsap.registerPlugin(ScrollTrigger);

type TimeOfDay = 'dawn' | 'day' | 'dusk' | 'night';

export function Demo() {
  const sectionRef = useRef<HTMLElement>(null);
  const controlsRef = useRef<HTMLDivElement>(null);
  const [timeProgress, setTimeProgress] = useState(75); // Start at night
  const [isAutoPlaying, setIsAutoPlaying] = useState(false);
  const [neonText, setNeonText] = useState('NOOK');
  const [lightsOn, setLightsOn] = useState(true);
  const [showFlash, setShowFlash] = useState(false);

  // Map progress to time of day
  const getTimeOfDay = (progress: number): TimeOfDay => {
    if (progress < 25) return 'dawn';
    if (progress < 50) return 'day';
    if (progress < 75) return 'dusk';
    return 'night';
  };

  const currentTime = getTimeOfDay(timeProgress);

  // Auto-play time progression
  useEffect(() => {
    if (!isAutoPlaying) return;
    
    const interval = setInterval(() => {
      setTimeProgress(prev => (prev + 0.5) % 100);
    }, 100);
    
    return () => clearInterval(interval);
  }, [isAutoPlaying]);

  // Light toggle flash effect
  const handleLightToggle = () => {
    setShowFlash(true);
    setLightsOn(!lightsOn);
    setTimeout(() => setShowFlash(false), 200);
  };

  // 3D tilt effect on controls
  const [tilt, setTilt] = useState({ x: 0, y: 0 });
  
  const handleMouseMove = (e: React.MouseEvent<HTMLDivElement>) => {
    const rect = e.currentTarget.getBoundingClientRect();
    const x = (e.clientX - rect.left) / rect.width - 0.5;
    const y = (e.clientY - rect.top) / rect.height - 0.5;
    setTilt({ x: y * 10, y: -x * 10 });
  };

  const handleMouseLeave = () => {
    setTilt({ x: 0, y: 0 });
  };

  useEffect(() => {
    const ctx = gsap.context(() => {
      gsap.fromTo(controlsRef.current,
        { y: 100, opacity: 0 },
        {
          y: 0,
          opacity: 1,
          duration: 1,
          ease: 'power3.out',
          scrollTrigger: {
            trigger: sectionRef.current,
            start: 'top 60%',
            toggleActions: 'play none none reverse',
          },
        }
      );
    }, sectionRef);

    return () => ctx.revert();
  }, []);

  const timeLabels: Record<TimeOfDay, string> = {
    dawn: 'DAWN',
    day: 'DAY',
    dusk: 'DUSK',
    night: 'NIGHT',
  };

  const timeColors: Record<TimeOfDay, string> = {
    dawn: 'from-orange-400 to-pink-400',
    day: 'from-blue-400 to-cyan-400',
    dusk: 'from-purple-400 to-orange-400',
    night: 'from-blue-900 to-purple-900',
  };

  return (
    <section 
      ref={sectionRef}
      id="demo"
      className="relative py-24 md:py-32 px-6 md:px-12 lg:px-24 bg-cyber-dark overflow-hidden"
    >
      {/* Background */}
      <div className="absolute inset-0">
        <div className="cyber-grid opacity-5" />
      </div>

      {/* Flash Effect */}
      {showFlash && (
        <div className="fixed inset-0 bg-white z-50 pointer-events-none animate-pulse" style={{ animationDuration: '0.2s' }} />
      )}

      <div className="max-w-7xl mx-auto relative">
        {/* Header */}
        <div className="text-center mb-12">
          <span className="inline-block px-4 py-1 rounded-full glass-panel text-xs font-mono text-cyber-blue uppercase tracking-wider mb-4">
            The Lab
          </span>
          <h2 className="font-display text-4xl md:text-5xl lg:text-6xl text-cyber-cream mb-4">
            CONTROL <span className="text-cyber-blue">DECK</span>
          </h2>
          <p className="text-cyber-cream/70 max-w-2xl mx-auto font-light">
            Take full control of the cyberpunk world. Adjust every parameter 
            and watch the scene transform in real-time.
          </p>
        </div>

        {/* Demo Scene with Border */}
        <div className="relative mb-8">
          {/* Glowing Border */}
          <div 
            className={`absolute -inset-2 rounded-xl bg-gradient-to-r ${timeColors[currentTime]} opacity-50 blur-sm`}
          />
          
          {/* Scene Container */}
          <div className="relative rounded-lg overflow-hidden">
            <BookNookScene />
          </div>
        </div>

        {/* Floating Control Deck */}
        <div 
          ref={controlsRef}
          className="glass-panel rounded-xl p-6 md:p-8 perspective-1000"
          onMouseMove={handleMouseMove}
          onMouseLeave={handleMouseLeave}
          style={{
            opacity: 0,
            transform: `rotateX(${tilt.x}deg) rotateY(${tilt.y}deg)`,
            transition: 'transform 0.3s ease-out',
          }}
        >
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6 md:gap-8">
            {/* Time Control */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 text-cyber-cream">
                <Clock className="w-5 h-5 text-cyber-blue" />
                <h3 className="font-display text-lg">TIME CONTROL</h3>
              </div>
              
              {/* Time Display */}
              <div className={`text-center py-3 rounded-lg bg-gradient-to-r ${timeColors[currentTime]} text-cyber-dark font-display text-xl`}>
                {timeLabels[currentTime]}
              </div>
              
              {/* Progress Bar */}
              <div className="space-y-2">
                <Slider 
                  value={[timeProgress]}
                  onValueChange={([v]) => setTimeProgress(v)}
                  min={0} max={100} step={1}
                  className="w-full"
                />
                <div className="flex justify-between text-xs text-cyber-cream/50">
                  <span>DAWN</span>
                  <span>DAY</span>
                  <span>DUSK</span>
                  <span>NIGHT</span>
                </div>
              </div>

              {/* Auto-play Controls */}
              <div className="flex gap-2">
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={() => setIsAutoPlaying(!isAutoPlaying)}
                  className="flex-1 border-cyber-blue/30 text-cyber-cream hover:bg-cyber-blue/10"
                >
                  {isAutoPlaying ? <Pause className="w-4 h-4" /> : <Play className="w-4 h-4" />}
                </Button>
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={() => setTimeProgress(0)}
                  className="border-cyber-blue/30 text-cyber-cream hover:bg-cyber-blue/10"
                >
                  <SkipBack className="w-4 h-4" />
                </Button>
                <Button 
                  variant="outline" 
                  size="sm"
                  onClick={() => setTimeProgress(75)}
                  className="border-cyber-blue/30 text-cyber-cream hover:bg-cyber-blue/10"
                >
                  <SkipForward className="w-4 h-4" />
                </Button>
              </div>
            </div>

            {/* Light Control */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 text-cyber-cream">
                <Lightbulb className="w-5 h-5 text-cyber-yellow" />
                <h3 className="font-display text-lg">LIGHTING</h3>
              </div>
              
              <div className="space-y-3">
                <Button 
                  onClick={handleLightToggle}
                  className={`w-full font-mono ${
                    lightsOn 
                      ? 'bg-cyber-yellow text-cyber-dark hover:bg-cyber-yellow/80' 
                      : 'bg-cyber-dark/50 text-cyber-cream border border-cyber-cream/30'
                  }`}
                >
                  {lightsOn ? 'LIGHTS ON' : 'LIGHTS OFF'}
                </Button>
                
                <div className="text-center">
                  <div className="text-xs text-cyber-cream/50 mb-1">Intensity</div>
                  <div className={`h-2 w-full rounded-full transition-all ${lightsOn ? 'bg-cyber-yellow' : 'bg-cyber-dark/30'}`} 
                    style={{ opacity: lightsOn ? 1 : 0.3 }}
                  />
                </div>
              </div>

              {/* Quick Time Buttons */}
              <div className="grid grid-cols-2 gap-2">
                {(['dawn', 'day', 'dusk', 'night'] as TimeOfDay[]).map((time) => (
                  <Button 
                    key={time}
                    variant="outline"
                    size="sm"
                    onClick={() => {
                      const timeValues: Record<TimeOfDay, number> = { dawn: 12, day: 37, dusk: 62, night: 87 };
                      setTimeProgress(timeValues[time]);
                    }}
                    className={`font-mono text-xs border-cyber-cream/20 ${
                      currentTime === time 
                        ? 'bg-cyber-pink text-white border-cyber-pink' 
                        : 'text-cyber-cream hover:bg-cyber-cream/10'
                    }`}
                  >
                    {time.toUpperCase()}
                  </Button>
                ))}
              </div>
            </div>

            {/* Neon Sign Control */}
            <div className="space-y-4">
              <div className="flex items-center gap-2 text-cyber-cream">
                <MessageSquare className="w-5 h-5 text-cyber-pink" />
                <h3 className="font-display text-lg">NEON SIGN</h3>
              </div>
              
              <div className="space-y-3">
                <Input 
                  value={neonText}
                  onChange={(e) => setNeonText(e.target.value.slice(0, 8))}
                  placeholder="Enter message"
                  className="bg-cyber-dark/50 border-cyber-pink/30 text-cyber-cream font-display text-lg"
                  maxLength={8}
                />
                
                {/* Preview */}
                <div className="h-16 rounded-lg bg-cyber-dark/50 flex items-center justify-center overflow-hidden">
                  <span 
                    className="font-display text-2xl animate-neon-flicker"
                    style={{
                      color: '#ff0080',
                      textShadow: '0 0 10px #ff0080, 0 0 20px #ff0080, 0 0 40px #ff0080',
                    }}
                  >
                    {neonText || 'NOOK'}
                  </span>
                </div>

                {/* Preset Messages */}
                <div className="grid grid-cols-2 gap-2">
                  {['CYBER', '2077', 'NOVA', 'PULSE'].map((preset) => (
                    <Button 
                      key={preset}
                      variant="outline"
                      size="sm"
                      onClick={() => setNeonText(preset)}
                      className="font-mono text-xs border-cyber-pink/20 text-cyber-cream hover:bg-cyber-pink/10"
                    >
                      {preset}
                    </Button>
                  ))}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
