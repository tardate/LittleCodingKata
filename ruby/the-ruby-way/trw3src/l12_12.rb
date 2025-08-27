require 'Qt'

class TimerClock < Qt::Widget
  def initialize(parent = nil)
    super(parent)
    @timer = Qt::Timer.new(self)
    connect(@timer, SIGNAL('timeout()'), self, SLOT('update()'))
    @timer.start(25)
    setWindowTitle('Stop Watch')
    resize(200, 200)
  end

  def paintEvent(e)
    fastHand = Qt::Polygon.new([Qt::Point.new(7, 8),
                                Qt::Point.new(-7, 8),
                                Qt::Point.new(0, -80)])
    secondHand = Qt::Polygon.new([Qt::Point.new(7, 8),
                                  Qt::Point.new(-7, 8),
                                  Qt::Point.new(0, -65)])

    secondColor = Qt::Color.new(100, 0, 100)
    fastColor = Qt::Color.new(0, 150, 150, 150)

    side = [width, height].min
    time = Qt::Time.currentTime

    painter = Qt::Painter.new(self)
    painter.renderHint = Qt::Painter::Antialiasing
    painter.translate(width() / 2, height() / 2)
    painter.scale(side / 200.0, side / 200.0)
    painter.pen = Qt::NoPen
    painter.brush = Qt::Brush.new(secondColor)
    painter.save
    painter.rotate(6.0 * time.second)
    painter.drawConvexPolygon(secondHand)
    painter.restore
    painter.pen = secondColor

    (0...12).each do |i|
        painter.drawLine(88, 0, 96, 0)
        painter.rotate(30.0)
    end

    painter.pen = Qt::NoPen
    painter.brush = Qt::Brush.new(fastColor)
    painter.save
    painter.rotate(36.0 * (time.msec / 100.0) )
    painter.drawConvexPolygon(fastHand)
    painter.restore
    painter.pen = fastColor
    (0...60).each do |j|
      if (j % 5) != 0
        painter.drawLine(92, 0, 96, 0)
      end
      painter.rotate(6.0)
    end
    painter.end
  end
end

app = Qt::Application.new(ARGV)
wid = TimerClock.new
wid.show
app.exec

