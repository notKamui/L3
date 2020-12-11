from ctypes import c_ubyte, cdll
from PIL import Image

Pix_c = c_ubyte * 4
Img_c_line = Pix_c * 512
Img_c = Img_c_line * 512

image_libc = cdll.LoadLibrary("./image_process.so")

# A class to manipulate images
class ImageFX:
    # Converts a given Image to an Img_c
    def __convert_bitmap_to_c(_, img):
        img_c = Img_c()
        bitmap = img.load()
        for i in range(512):
            for j in range(512):
                for k in range(4):
                    img_c[i][j][k] = bitmap[i, j][k]
        return img_c

    # Reverts the convertion
    def __rebuild_image(_, img_c, img):
        bitmap = img.load()
        for i in range(512):
            for j in range(512):
                bitmap[i, j] = (img_c[i][j][0], img_c[i][j][1], img_c[i][j][2], img_c[i][j][3])

    # Opens an image
    def open(self, fname):
        self.img = Image.open(fname).convert("RGBA")
        self.img_c = self.__convert_bitmap_to_c(self.img)

    # Shows an image (Lazy conversion)
    def show(self):
        self.__rebuild_image(self.img_c, self.img)
        self.img.show()

    # Closes an image
    def close(self):
        self.img.close()
        self.img_c = None

    # Inverts the colors of the current image
    def invert_color(self):
        image_libc.invert_color(self.img_c)

    # Average the current image to grays
    def avg_gray(self):
        image_libc.avg_gray(self.img_c)

    # Applies gray clearance to current image
    def clear_gray(self):
        image_libc.clear_gray(self.img_c)

    # Applies gray luminance to current image
    def lum_gray(self):
        image_libc.lum_gray(self.img_c)

    # Applies a threshold filer to the current image
    def threshold_bnw(self):
        image_libc.threshold_bnw(self.img_c)

    # Makes the current image redder
    def redder(self):
        image_libc.redder(self.img_c)

    # Applies a red to blue gradient on the current image
    def red_blue_gradient(self):
        image_libc.red_blue_gradient(self.img_c)

    # Averages the current image on a given image
    def img_avg(self, fname):
        other = Image.open(fname).convert("RGBA")
        other_c = self.__convert_bitmap_to_c(other)
        image_libc.img_avg(self.img_c, other_c)

    # Applies a filter that looks like a lamp on the current image
    def mid_light(self):
        image_libc.mid_light(self.img_c)

    
