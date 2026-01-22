import { useState, useEffect, useRef, useCallback } from 'react';
import { Switch } from '@/components/ui/switch';
import { Slider } from '@/components/ui/slider';
import { Input } from '@/components/ui/input';
import { Lightbulb, Sun, Moon, Sparkles, Wind, Fan } from 'lucide-react';

type TimeOfDay = 'dawn' | 'day' | 'dusk' | 'night';

interface BookNookSceneProps {
  className?: string;
}

export function BookNookScene({ className = '' }: BookNookSceneProps) {
  const [timeOfDay, setTimeOfDay] = useState<TimeOfDay>('night');
  const [lightsOn, setLightsOn] = useState(true);
  const [signOn, setSignOn] = useState(true);
  const [neonMessage, setNeonMessage] = useState('CYBER');
  const [fanSpeed, setFanSpeed] = useState(0.5);
  const [laundryActive, setLaundryActive] = useState(true);
  const [birdsActive, setBirdsActive] = useState(true);
  const [catsActive, setCatsActive] = useState(true);
  const [ratsActive, setRatsActive] = useState(true);
  const [fogIntensity, setFogIntensity] = useState(0.5);
  
  const sceneRef = useRef<HTMLDivElement>(null);
  const [mousePos, setMousePos] = useState({ x: 0, y: 0 });

  // Mouse tracking for 3D perspective
  const handleMouseMove = useCallback((e: MouseEvent) => {
    if (!sceneRef.current) return;
    const rect = sceneRef.current.getBoundingClientRect();
    const x = (e.clientX - rect.left) / rect.width - 0.5;
    const y = (e.clientY - rect.top) / rect.height - 0.5;
    setMousePos({ x, y });
  }, []);

  useEffect(() => {
    const scene = sceneRef.current;
    if (!scene) return;
    
    scene.addEventListener('mousemove', handleMouseMove, { passive: true });
    return () => scene.removeEventListener('mousemove', handleMouseMove);
  }, [handleMouseMove]);

  // Auto time progression
  useEffect(() => {
    const interval = setInterval(() => {
      setTimeOfDay(prev => {
        const times: TimeOfDay[] = ['dawn', 'day', 'dusk', 'night'];
        const currentIndex = times.indexOf(prev);
        return times[(currentIndex + 1) % 4];
      });
    }, 8000); // Change every 8 seconds
    return () => clearInterval(interval);
  }, []);

  const timeConfig = {
    dawn: {
      bg: 'linear-gradient(to bottom, #ff7e5f 0%, #feb47b 30%, #6a82fb 100%)',
      filter: 'brightness(0.8) contrast(1.1)',
      neonOpacity: 0.6,
    },
    day: {
      bg: 'linear-gradient(to bottom, #4a7c9d 0%, #7eb6d9 50%, #b8e0f0 100%)',
      filter: 'brightness(1.2) contrast(1) saturate(0.9)',
      neonOpacity: 0.3,
    },
    dusk: {
      bg: 'linear-gradient(to bottom, #1a1a2e 0%, #4a4e69 40%, #9a8c98 100%)',
      filter: 'brightness(0.7) contrast(1.2)',
      neonOpacity: 0.8,
    },
    night: {
      bg: 'linear-gradient(to bottom, #0a0a0a 0%, #1a1a2e 50%, #16213e 100%)',
      filter: 'brightness(0.6) contrast(1.3)',
      neonOpacity: 1,
    },
  };

  const currentConfig = timeConfig[timeOfDay];

  // Animated creatures
  const creatures = {
    cats: catsActive ? [
      { delay: '0s', duration: '20s', y: '60%', size: '24px' },
      { delay: '7s', duration: '25s', y: '65%', size: '20px' },
      { delay: '12s', duration: '18s', y: '70%', size: '22px' },
    ] : [],
    rats: ratsActive ? [
      { delay: '3s', duration: '15s', y: '75%', size: '12px' },
      { delay: '8s', duration: '12s', y: '78%', size: '10px' },
    ] : [],
    birds: birdsActive ? [
      { delay: '0s', duration: '12s', y: '20%' },
      { delay: '4s', duration: '10s', y: '15%' },
      { delay: '8s', duration: '14s', y: '25%' },
    ] : [],
  };

  return (
    <div className={`relative overflow-hidden ${className}`}>
      {/* Main Scene Container */}
      <div 
        ref={sceneRef}
        className="relative w-full aspect-video overflow-hidden rounded-lg neon-border perspective-1000"
        style={{
          background: currentConfig.bg,
          filter: currentConfig.filter,
          transform: `rotateY(${mousePos.x * 5}deg) rotateX(${-mousePos.y * 5}deg)`,
          transition: 'transform 0.3s ease-out, filter 1s ease-in-out',
        }}
      >
        {/* Scene Image */}
        <div className="absolute inset-0">
          <img 
            src={`/scene-${timeOfDay}.jpg`}
            alt={`Cyberpunk scene at ${timeOfDay}`}
            className="w-full h-full object-cover transition-all duration-1000"
            style={{
              opacity: lightsOn ? 1 : 0.4,
            }}
          />
        </div>

        {/* Fog Layer */}
        <div 
          className="absolute inset-0 fog-layer transition-opacity duration-1000"
          style={{ 
            opacity: fogIntensity,
            background: `linear-gradient(to top, rgba(10, 22, 40, ${fogIntensity * 0.8}) 0%, transparent 60%)`,
          }}
        />

        {/* Animated Cats */}
        {creatures.cats.map((cat, i) => (
          <div
            key={`cat-${i}`}
            className="absolute text-white"
            style={{
              top: cat.y,
              left: '-10%',
              fontSize: cat.size,
              animation: `cat-walk ${cat.duration} linear infinite`,
              animationDelay: cat.delay,
              opacity: lightsOn ? 0.9 : 0.3,
              filter: lightsOn ? 'drop-shadow(0 0 5px rgba(255,255,255,0.5))' : 'none',
            }}
          >
            🐈
          </div>
        ))}

        {/* Animated Rats */}
        {creatures.rats.map((rat, i) => (
          <div
            key={`rat-${i}`}
            className="absolute text-gray-400"
            style={{
              top: rat.y,
              right: '-10%',
              fontSize: rat.size,
              animation: `rat-scurry ${rat.duration} linear infinite`,
              animationDelay: rat.delay,
              opacity: lightsOn ? 0.7 : 0.2,
            }}
          >
            🐀
          </div>
        ))}

        {/* Animated Birds */}
        {creatures.birds.map((bird, i) => (
          <div
            key={`bird-${i}`}
            className="absolute text-white"
            style={{
              top: bird.y,
              left: '-20%',
              fontSize: '16px',
              animation: `bird-fly ${bird.duration} ease-in-out infinite`,
              animationDelay: bird.delay,
              opacity: 0.8,
            }}
          >
            🕊️
          </div>
        ))}

        {/* Spinning Fans */}
        <div 
          className="absolute top-[30%] right-[15%] text-cyber-blue"
          style={{
            fontSize: '32px',
            animation: `fan-spin ${1 / fanSpeed}s linear infinite`,
            opacity: fanSpeed > 0.1 ? 0.8 : 0.3,
            filter: lightsOn ? 'drop-shadow(0 0 10px rgba(0,255,255,0.5))' : 'none',
          }}
        >
          <Fan className="w-8 h-8" />
        </div>
        <div 
          className="absolute top-[45%] left-[20%] text-cyber-blue"
          style={{
            fontSize: '28px',
            animation: `fan-spin ${1.2 / fanSpeed}s linear infinite`,
            opacity: fanSpeed > 0.1 ? 0.7 : 0.3,
            filter: lightsOn ? 'drop-shadow(0 0 8px rgba(0,255,255,0.4))' : 'none',
          }}
        >
          <Fan className="w-7 h-7" />
        </div>

        {/* Fluttering Laundry */}
        <div 
          className="absolute top-[25%] left-[35%]"
          style={{
            opacity: laundryActive ? (lightsOn ? 0.7 : 0.3) : 0,
            animation: laundryActive ? 'laundry-flutter 3s ease-in-out infinite' : 'none',
          }}
        >
          <div className="flex flex-col gap-1">
            {['🎽', '👕', '👖'].map((item, i) => (
              <span 
                key={i}
                className="text-2xl"
                style={{
                  animationDelay: `${i * 0.3}s`,
                  filter: lightsOn ? 'drop-shadow(0 0 5px rgba(255,255,255,0.3))' : 'none',
                }}
              >
                {item}
              </span>
            ))}
          </div>
        </div>

        {/* Neon Signs Overlay */}
        <div 
          className="absolute inset-0 pointer-events-none"
          style={{
            opacity: signOn ? currentConfig.neonOpacity : 0,
            transition: 'opacity 0.5s ease-in-out',
          }}
        >
          {/* Main Neon Sign */}
          <div 
            className="absolute top-[15%] left-1/2 -translate-x-1/2 font-display text-4xl md:text-6xl animate-neon-flicker"
            style={{
              color: '#ff0080',
              textShadow: '0 0 10px #ff0080, 0 0 20px #ff0080, 0 0 40px #ff0080, 0 0 80px #ff0080',
            }}
          >
            {neonMessage || 'CYBER'}
          </div>

          {/* Secondary Neon */}
          <div 
            className="absolute top-[40%] right-[10%] font-mono text-lg md:text-xl"
            style={{
              color: '#00ffff',
              textShadow: '0 0 8px #00ffff, 0 0 16px #00ffff',
              animation: 'neon-pulse 2s ease-in-out infinite',
            }}
          >
            2077
          </div>

          {/* Vertical Neon Bar */}
          <div 
            className="absolute bottom-[20%] left-[10%] w-2 h-32"
            style={{
              background: 'linear-gradient(180deg, #8b00ff, #ff0080)',
              boxShadow: '0 0 20px #8b00ff, 0 0 40px #ff0080',
              animation: 'neon-pulse 3s ease-in-out infinite',
            }}
          />
        </div>

        {/* Light Bloom Effect */}
        <div 
          className="absolute inset-0 pointer-events-none mix-blend-screen"
          style={{
            opacity: lightsOn ? 0.3 : 0,
            background: 'radial-gradient(circle at 50% 50%, rgba(255,0,128,0.2) 0%, transparent 50%)',
            transition: 'opacity 0.5s ease-in-out',
          }}
        />

        {/* Time Indicator */}
        <div className="absolute top-4 left-4 glass-panel px-3 py-2 rounded-lg font-mono text-sm text-cyber-cream">
          <div className="flex items-center gap-2">
            {timeOfDay === 'dawn' && <Sparkles className="w-4 h-4 text-yellow-400" />}
            {timeOfDay === 'day' && <Sun className="w-4 h-4 text-yellow-400" />}
            {timeOfDay === 'dusk' && <Wind className="w-4 h-4 text-orange-400" />}
            {timeOfDay === 'night' && <Moon className="w-4 h-4 text-blue-400" />}
            <span className="uppercase">{timeOfDay}</span>
          </div>
        </div>
      </div>

      {/* Control Panel */}
      <div className="glass-panel rounded-lg p-4 mt-4 space-y-4">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {/* Light Controls */}
          <div className="space-y-3">
            <h3 className="font-display text-xl text-cyber-pink flex items-center gap-2">
              <Lightbulb className="w-5 h-5" />
              LIGHTS
            </h3>
            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">Street Lights</span>
                <Switch 
                  checked={lightsOn} 
                  onCheckedChange={setLightsOn}
                  className="data-[state=checked]:bg-cyber-pink"
                />
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">Neon Signs</span>
                <Switch 
                  checked={signOn} 
                  onCheckedChange={setSignOn}
                  className="data-[state=checked]:bg-cyber-blue"
                />
              </div>
            </div>
          </div>

          {/* Animation Controls */}
          <div className="space-y-3">
            <h3 className="font-display text-xl text-cyber-green">ANIMATIONS</h3>
            <div className="space-y-2">
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">🐈 Cats</span>
                <Switch checked={catsActive} onCheckedChange={setCatsActive} />
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">🐀 Rats</span>
                <Switch checked={ratsActive} onCheckedChange={setRatsActive} />
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">🕊️ Birds</span>
                <Switch checked={birdsActive} onCheckedChange={setBirdsActive} />
              </div>
            </div>
          </div>

          {/* Environment Controls */}
          <div className="space-y-3">
            <h3 className="font-display text-xl text-cyber-purple">ENVIRONMENT</h3>
            <div className="space-y-3">
              <div>
                <label className="text-sm text-cyber-cream block mb-1">Fan Speed</label>
                <Slider 
                  value={[fanSpeed]} 
                  onValueChange={([v]) => setFanSpeed(v)}
                  min={0} max={1} step={0.1}
                  className="w-full"
                />
              </div>
              <div className="flex items-center justify-between">
                <span className="text-sm text-cyber-cream">Laundry</span>
                <Switch checked={laundryActive} onCheckedChange={setLaundryActive} />
              </div>
              <div>
                <label className="text-sm text-cyber-cream block mb-1">Fog</label>
                <Slider 
                  value={[fogIntensity]} 
                  onValueChange={([v]) => setFogIntensity(v)}
                  min={0} max={1} step={0.1}
                  className="w-full"
                />
              </div>
            </div>
          </div>

          {/* Time & Sign Controls */}
          <div className="space-y-3">
            <h3 className="font-display text-xl text-cyber-orange">CUSTOMIZE</h3>
            <div className="space-y-3">
              <div>
                <label className="text-sm text-cyber-cream block mb-1">Time of Day</label>
                <div className="grid grid-cols-2 gap-2">
                  {(['dawn', 'day', 'dusk', 'night'] as TimeOfDay[]).map((time) => (
                    <button
                      key={time}
                      onClick={() => setTimeOfDay(time)}
                      className={`px-3 py-1 rounded text-xs font-mono uppercase transition-all ${
                        timeOfDay === time 
                          ? 'bg-cyber-pink text-white shadow-neon' 
                          : 'bg-cyber-dark/50 text-cyber-cream hover:bg-cyber-dark'
                      }`}
                    >
                      {time}
                    </button>
                  ))}
                </div>
              </div>
              <div>
                <label className="text-sm text-cyber-cream block mb-1">Neon Sign</label>
                <Input 
                  value={neonMessage}
                  onChange={(e) => setNeonMessage(e.target.value.slice(0, 10))}
                  placeholder="Enter text"
                  className="bg-cyber-dark/50 border-cyber-pink/30 text-cyber-cream font-display"
                  maxLength={10}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
