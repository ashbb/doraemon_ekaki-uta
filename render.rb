module Render
  def opening
    para strong('doraemon ekaki-uta'), :size => 24, :top => 140, :align => 'center'
    timer 5 do
      clear do
        para strong('Kawabunga!'), :top => 140, :align => 'center', :stroke => green
        timer 3 do
          clear do
            rect 10, 395, 380, 30, :fill => tomato, :stroke => tomato, :curve => 5
            @song = para '', :left => 20, :top => 400, :font => "MS UI Gothic"
            @q.push :any
          end
        end
      end
    end
  end
  
  def circle x, y, w, h, s, r
    Thread.start do
      f = r>0 ? true : false
      r = r.abs
      max = r * 40 / 360
      s = Shoes::TWO_PI * s / 360.0
      ar = nil
      song = $lyrics.shift
      a = animate 10 do |i|
        @song.text = song
        ar.remove if ar
        r = f ? (s + i * Shoes::PI * 0.05) : (s - i * Shoes::PI * 0.05)
        ar = f ? arc(x, y, w, h, s, r) : arc(x, y, w, h, r, s)
        (a.stop; @q.push :any) if i >= max
      end if @q.pop
    end
  end
  
  def dot x, y
    Thread.start do
      (oval(x, y, 5); @q.push :any) if @q.pop
    end
  end
  
  def wire x0, y0, x1, y1
    x0, y0, x1, y1 = x0.to_f, y0.to_f, x1.to_f, y1.to_f
    Thread.start do
      l = nil
      song = $lyrics.shift
      a = animate 300 do |i|
        @song.text = song
        case
          when x0 < x1
            x = x0 + i
            y = y0 + (y1 - y0) / (x1 - x0) * i  if y0 < y1
            y = y0  if y0 == y1
            y = y0 - (y0 - y1) / (x1 - x0) * i  if y0 > y1
            max = x1 - x0
          when x0 == x1
            x = x0
            y = y0 + i  if y0 < y1
            y = y0 - i  if y0 > y1
            y = y0  if y0 == y1
            max = (y1 - y0).abs
          when x0 > x1
            x = x0 - i
            y = y0 + (y1 - y0) / (x0 - x1) * i  if y0 < y1
            y = y0  if y0 == y1
            y = y0 - (y0 - y1) / (x0 - x1) * i  if y0 > y1
            max = x0 - x1
          else
        end
        l.remove if l  
        l = line x0, y0, x.to_i, y.to_i
        (a.stop; @q.push :any) if i == max
      end if @q.pop
    end
  end
  
  def fwire x0, y0, x1, y1
    Thread.start do
      song = $lyrics.shift
      a = animate 10 do |i|
        @song.text = song
        line x0, y0, x1, y1
        (a.stop; @q.push :any) if i > 3
      end  if @q.pop
    end
  end
  
  def mk_lyrics
    background './imgs/art-and-code-lady-mini.png'
    style Shoes::Link, :stroke => green, :underline => nil
    style Shoes::LinkHover, :stroke => green, :fill => nil, :underline => nil
    
    flow :left => 270, :top => 160, :width => 100 do
      pr1 = proc do|i, e|
        lyrics = IO.readlines("./lyrics/#{e.downcase}.txt")
        $lyrics = []
        [2,2,2,6,4,2,3,2,6].each_with_index do |n, i|
          n.times{$lyrics << lyrics[i]}
        end
        clear{visit '/drawing'}
      end      
      
      menu 'Language', %w[English Japanese Portuguese], 0, pr1, crimson do |b, f, i, e|
        b.move 0, i*23
        f.move 0, i*23
        para e, "\n", :stroke => green, :weight => 'bold'
      end
    end
  end
end
