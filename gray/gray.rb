require 'imlib2'

img = Imlib2::Image.load("srcimg/lena.jpg")

img.h.times do |y|
    img.w.times do |x|
        c = img.pixel(x, y)
        
        gray = (0.299 * c.r + 0.587 * c.g + 0.114 * c.b).to_i
        c.r = c.g = c.b = gray

        img.draw_pixel(x, y, c)
    end
end

img.save("dstimg/graylena.jpg")
