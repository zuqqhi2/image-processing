require 'imlib2'
include Math

def calcHue(c1, c2)
    hue = 0.0
    if c2 == 0.0
        if c1 == 0
            hue = 0.0
        elsif c1 > 0
            hue = 90.0
        else
            hude = 270.0
        end
    elsif c2 > 0.0
        if 1 > 0.0
            hue = atan(c1 / c2) * 180.0 / PI;
        else
            hue = 360.0 - atan(c1.abs / c2) * 180.0 / PI;
        end
    else
        if c1 > 0.0
            hue = 180.0 - atan(c1 / c2.abs) * 180.0 / PI;
        else
            hue = 180.0 + atan((c1 / c2).abs) * 180.0 / PI;
        end
    end
    if hue < 0
        hue += 360.0;
    end
    return hue
end

def calcBrightness(r, g, b)
    return (0.299 * r + 0.587 * g + 0.114 * b).to_i
end

def calcSaturation(c1, c2)
    return sqrt(c1 * c1 + c2 * c2)
end

# Main part
img = Imlib2::Image.load("srcimg/lena.jpg")
minHue = 120.0
maxHue = 140.0
maxSat = 0.52
minBright = 0.28

img.h.times do |y|
    img.w.times do |x|
        color = img.pixel(x, y)
        
        bright = calcBrightness(color.r, color.g, color.b)
        
        c1 = color.r - bright
        c2 = color.b - bright
        hue = calcHue(c1, c2)

        saturation = calcSaturation(c1, c2)
        col = 255
        if hue >= minHue and hue <= maxHue and bright > minBright
            col = 0
        end
        color.r = color.g = color.b = col
        img.draw_pixel(x, y, color)
    end
end

img.save("dstimg/binarize.jpg")
