# Copy of darknet/script/voc_label.py
# Need to modify to process the .xml accordingly
import xml.etree.ElementTree as ET
import pickle
import os
from os import listdir, getcwd
from os.path import join, isfile, splitext

# Directories name
sets = ['robomaster_Central China Regional Competition', 'robomaster_Final Tournament',
        'robomaster_North China Regional Competition', 'robomaster_South China Regional Competition']
# List of classes
classes = ["red_armor", "blue_armor", "grey_armor", "base", "watcher", "car"]


def convert(size, box):
    dw = 1./(size[0])
    dh = 1./(size[1])
    x = (box[0] + box[1])/2.0 - 1
    y = (box[2] + box[3])/2.0 - 1
    w = box[1] - box[0]
    h = box[3] - box[2]
    x = x*dw
    w = w*dw
    y = y*dh
    h = h*dh
    return (x, y, w, h)


def convert_annotation(set_name, image_id):
    in_file = open('../dataset/%s/image_annotation/%s.xml' %
                   (set_name, image_id))

    tree = ET.parse(in_file)
    root = tree.getroot()

    # If filename in annotation is different from the image name
    if(root.find('filename').text != image_id+".jpg"):
        return False

    out_file = open('../dataset/%s/labels/%s.txt' % (set_name, image_id), 'w')

    size = root.find('size')
    w = int(size.find('width').text)
    h = int(size.find('height').text)

    for obj in root.iter('object'):
        difficult = 0
        if obj.find('difficulty') is not None:
            difficult = obj.find('difficulty').text
        cls = obj.find('name').text
        cls_color = ""
        if obj.find('armor_color') is not None:
            cls_color = obj.find('armor_color').text + "_"
        if cls_color+cls not in classes or int(difficult) > 1:
            continue
        cls_id = classes.index(cls_color+cls)
        xmlbox = obj.find('bndbox')
        b = (float(xmlbox.find('xmin').text), float(xmlbox.find('xmax').text), float(
            xmlbox.find('ymin').text), float(xmlbox.find('ymax').text))
        bb = convert((w, h), b)
        out_file.write(str(cls_id) + " " +
                       " ".join([str(a) for a in bb]) + '\n')

    return True


if __name__ == "__main__":

    for set_name in sets:
        print("Processing %s..." % (set_name))
        if not os.path.exists('../dataset/%s' % (set_name)):
            print("No directory %s" % (set_name))
            continue
        if not os.path.exists('../dataset/%s/labels/' % (set_name)):
            os.makedirs('../dataset/%s/labels/' % (set_name))
        image_ids = [f for f in listdir(
            '../dataset/%s/image/' % (set_name)) if isfile(join('../dataset/%s/image/' % (set_name), f))]
        image_ids_ = [splitext(f)[0] for f in image_ids]
        list_file = open('../dataset/%s/%s.txt' % (set_name, set_name), 'w')
        for i, image_id in enumerate(image_ids_):
            if((i/len(image_ids)*100) % 10 == 0):
                print("{:0.2f}% done".format(i/len(image_ids)*100))
            if(convert_annotation(set_name, image_id)):
                list_file.write('../dataset/%s/image/%s.jpg\n' %
                                (set_name, image_id))
        list_file.close()
