#!/usr/bin/env python

from PIL import Image, ImageDraw, ImageFont
def main():

    folder = '/home/nitsi/documents/screenshots/'
    filename = "timeline"
    ext = '.png'

    size = width, height = 64, 1080
    image = Image.new("RGB", size, 'white')

    fnt = ImageFont.truetype(
        '/usr/local/share/fonts/n/NotoSans-Regular.ttf', 20)
    draw = ImageDraw.Draw(image)

    # image.save(folder+yesterday+"/timeline/"+filename + "%03d" % pic + ext)
    image.show()
    del image


if __name__ == "__main__":
    main()
