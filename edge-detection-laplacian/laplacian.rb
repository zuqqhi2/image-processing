require 'imlib2'

img = Imlib2::Image.load("srcimg/lena.jpg")

img.h.times do |y|
    img.w.times do |x|
        color = img.pixel(x, y)
        
        gray = (0.299 * color.r + 0.587 * color.g + 0.114 * color.b).to_i
        color.r = color.g = color.b = gray

        img.draw_pixel(x, y, color)
    end
end

dstimg = Imlib2::Image.create(img.width, img.height)
laplacian_filter=[[1,1,1],[1,-8,1],[1,1,1]]
dstimg.h.times do |y|
    dstimg.w.times do |x|
        if x == 0 or x == dstimg.width
            next
        end
        if y == 0 or y == dstimg.height
            next
        end
        
        sum = 0
        for i in -1..1 do
            for j in -1..1 do
                color = img.pixel(x+j, y+i)
                sum += color.r * laplacian_filter[i+1][j+1]
            end
        end
        color = img.pixel(x,y)
        color.r = color.b = color.g = sum

        dstimg.draw_pixel(x, y, color)
    end
end


img.save("dstimg/edge.jpg")
