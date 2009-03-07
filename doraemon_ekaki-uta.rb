# doraemon_ekaki-uta.rb
require 'thread'
require 'render'
require 'menu'

W, H = 400, 440
T = 'doraemon ekaki-uta r0.8'

class Doraemon < Shoes
  include Render
  url '/', :index
  url '/drawing', :drawing
  
  def index
    mk_lyrics
  end

  def drawing
    opening
    
    stroke royalblue
    strokewidth 5
    nofill
    cap :round

    @q = Queue.new

    circle 181, 48, 36, 40, 180, 360
    dot 189, 48
    circle 222, 48, 36, 40, 0, 360
    dot 210, 48
    circle 201, 77, 30, 20, 90, 360
    wire 201, 87, 201, 124
    circle 199, 124, 210, 154, 250, -320
    circle 201, 104, 250, 194, 132, 280
    circle 206, 250, 280, 180, 230, -60
    circle 87, 259, 40, 40, 180, -360
    circle 186, 250, 280, 180, 310, 60
    circle 305, 257, 40, 40, 0, 360

    circle 201, 222, 40, 33, 180, 360
    wire 184, 218, 218, 218
    circle 201, 187, 160, 60, 101, 72
    circle 201, 187, 150, 62, 72, -72
    circle 137, 266, 50, 150, 240, -110
    circle 253, 266, 54, 150, 305, 100
    circle 152, 352, 96, 62, 225, -360
    circle 254, 352, 96, 62, 290, -360

    circle 201, 265, 140, 116, 240, -300
    circle 201, 265, 100, 70, 180, -180
    wire 251, 263, 150, 263
    circle 201, 104, 160, 150, 170, -170
    circle 201, 114, 160, 25, 0, 170

    fwire 71, 45, 141, 73
    fwire 58, 78, 139, 86
    fwire 55, 116, 139, 96
    fwire 249, 76, 319, 51
    fwire 257, 90, 340, 79
    fwire 256, 102, 337, 113
  end
end

Shoes.app :width => W, :height => H, :title => T