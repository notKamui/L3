#! /usr/bin/python3

from imagefx import ImageFX

ifx = ImageFX()

ifx.open("Lenna.png")

ifx.invert_color()
ifx.show()

ifx.avg_gray()
ifx.show()

ifx.threshold_bnw()
ifx.show()

ifx.redder()
ifx.show()

ifx.red_blue_gradient()
ifx.show()

ifx.img_avg("panda.png")
ifx.show()

ifx.mid_light()
ifx.show()

ifx.close()