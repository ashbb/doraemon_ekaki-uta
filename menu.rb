# menu.rb
module Render
  def menu title, items, n, pr, color
    nostroke
    nofill
    w, h = 100, 23
    tb = image(:left => 0, :top => 0, :width => w, :height => h){rect(0, 0, w, h)}
    para title, :stroke => color, :weight => 'bold'
    @f ||= []
    @f << flow do
      items.each_with_index do |e, i|
        nostroke
        nofill
        b = image(:width => w, :height => h){rect(0, 0, w, h)}
        f = image(:width => w, :height => h){rect(0, 0, w, h, :fill => orange,:curve => 8)}.hide
        yield b, f, i, e
        b.hover{f.show}
        b.leave{f.hide}
        b.click{pr.call(i, e); @f[n].toggle}
      end
    end.hide
    
    tb.click{@f[n].toggle}
  end
end
