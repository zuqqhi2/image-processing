require 'imlib2'
include Math

def rgb2hsv(r, g, b)
    h = s = v = 0.0

    color = [r, g, b]
    cmax = color.max
    cmin = color.min
    v = cmax
    
    c = cmax - cmin
    if cmax == 0.0
        s = 0.0
    else
        s = c/cmax
    end

    if s != 0.0
        if r == cmax
            h = (g - b)/c
        elsif g == cmax
            h = 2 + (g - r)/c
        elsif b == cmax
            h = 4 + (r - g)/c
        end
        h *= 60.0
        if h < 0.0
            h += 360.0
        end
    end
    return h, s, v
end

# Main part
img = Imlib2::Image.load("srcimg/lena.jpg")
minHue = 30.0
maxHue = 50.0

img.h.times do |y|
    img.w.times do |x|
        color = img.pixel(x, y)
        
        h, s, v = rgb2hsv(color.r, color.g, color.b)

        col = 255
        if h >= minHue and h <= maxHue
            col = 0
        end
        color.r = color.g = color.b = col
        img.draw_pixel(x, y, color)
    end
end

img.save("dstimg/binarize.jpg")
