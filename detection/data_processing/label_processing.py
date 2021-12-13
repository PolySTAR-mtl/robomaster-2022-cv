#!/usr/bin/env python

"""
@file label_processing.py
@brief Process labels to produce darknet label formats from xml

@details Copy of darknet/script/voc_label.py. Need to modify to process the .xml accordingly

@author FlowSs <ton mail ici>
"""


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
    in_file_path = f'../dataset/{set_name}/image_annotation/{image_id}.xml'

    with open(in_file_path) as in_file:
        tree = ET.parse(in_file)

    root = tree.getroot()

    # If filename in annotation is different from the image name
    if(root.find('filename').text != image_id+".jpg" and root.find('filename').text != image_id+".png"):
        return False

    out_file = open(f'../dataset/{set_name}/labels/{image_id}.txt', 'w')

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

    out_file.close()

    return True


if __name__ == "__main__":

    for set_name in sets:
        print(f'Processing {set_name}...')

        if not os.path.exists(f'../dataset/{set_name}'):
            print(f"No directory {set_name}")
            continue

        if not os.path.exists(f'../dataset/{set_name}/labels/'):
            os.makedirs(f'../dataset/{set_name}/labels/')

        image_ids = [f for f in listdir(
            f'../dataset/{set_name}/image/') if isfile(join(f'../dataset/{set_name}/image/', f))]

        image_ids_ = [splitext(f)[0] for f in image_ids]

        list_file = open(f'../dataset/{set_name}/{set_name}.txt', 'w')

        for i, image_id in enumerate(image_ids_):
            if((i/len(image_ids)*100) % 10 == 0):
                print('{:0.2f}% done'.format(i / len(image_ids) * 100))

            if(convert_annotation(set_name, image_id)):
                list_file.write(
                    f'../dataset/{set_name}/image/{image_id}.jpg\n')

        list_file.close()
