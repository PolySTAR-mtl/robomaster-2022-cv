#!/usr/bin/env python

"""
@file label_processing.py
@brief Process labels to produce darknet label formats from xml

@details Copy of darknet/script/voc_label.py. Need to modify to process the .xml accordingly

@author FlowSs <ton mail ici>
"""


#import
import cv2  # OpenCV (image processing)
import matplotlib.pyplot as plt # visualization (could do it with OpenCV but Colab doesn't like that)
from xml.dom import minidom
import numpy as np

# Pour créer la bounding box
import matplotlib.patches as patches
# pour copie les xmls
import shutil
# pour gérer les paths
import os

# Directories name

sets = ['robomaster_Central China Regional Competition', 'robomaster_Final Tournament',
        'robomaster_North China Regional Competition', 'robomaster_South China Regional Competition']

# Stand alone script
class Armor:
  def __init__(self, type, color, xmin, ymin, xmax, ymax): 
    self.type = type
    self.color = color
    self.xmin = xmin
    self.xmax = xmax
    self.ymin = ymin
    self.ymax = ymax
  
  def print_class(self):
    return "Type: {}, Color: {}, Bounding Box: {}".format(self.type, self.color, (self.xmin, self.ymin, self.xmax, self.ymax))
  
  def __str__(self):
    return "Type: {}, Color: {}, Bounding Box: {}".format(self.type, self.color, (self.xmin, self.ymin, self.xmax, self.ymax))

class Robot(Armor):
  def __init__(self, type, color, xmin, ymin, xmax, ymax, list_armor): 
    super().__init__(type, color, xmin, ymin, xmax, ymax)
    self.list_armor = list_armor
  
  def __str__(self):
    res = ''
    res = res + "Type: {}, Color: {}, Bounding Box: {}".format(self.type, self.color, (self.xmin, self.ymin, self.xmax, self.ymax))
    res += "\nArmor list connected: \n"
    for i in range(len(self.list_armor)):
      res += self.list_armor[i].print_class()+'\n'
    return res


def liste_robot(image_xml, directory): #Entrée : Un fichier xml

  doc = minidom.parse(directory+'/image_annotation/'+image_xml)
  elements = doc.getElementsByTagName("object")
  # Contient la liste des Robots avec leurs modules d'armure
  car_list = []

  for i in elements :  # boucle for me retounre la un dictionnaire avec un robot et la ses armors        
      if i.getElementsByTagName('name')[0].firstChild.data == 'car' or i.getElementsByTagName('name')[0].firstChild.data == 'base' or i.getElementsByTagName('name')[0].firstChild.data == 'watcher':  # me permet de trouver les robots
        car_list.append(Robot(i.getElementsByTagName('name')[0].firstChild.data,None,float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data),float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data),float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data),float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data), []))
        for j in elements :
          if j.getElementsByTagName('name')[0].firstChild.data == 'armor': # me permet de trouver les armors
            # trouve le milieu de la bounding box  (x,y) de l'armor
            milieu_bndbox = ((float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data) + float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data))/2 , (float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data) + float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data))/2) 
            if milieu_bndbox[0] > float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data) and milieu_bndbox[0] < float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data) and milieu_bndbox[1] > float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data) and milieu_bndbox[1] < float(i.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data) :
                car_list[-1].list_armor.append(Armor(j.getElementsByTagName('name')[0].firstChild.data,j.getElementsByTagName('armor_color')[0].firstChild.data,float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data),float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data),float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data),float(j.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data))) 
  return car_list

def image_annote(dict_im,img):
  img = cv2.imread(img, cv2.IMREAD_COLOR)
  img_conv = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
  fig, ax = plt.subplots(figsize=(20, 20))
  ax.imshow(img_conv)
  for i in range(len(dict_im)):
    width = dict_im[i].xmax - dict_im[i].xmin
    height = dict_im[i].ymax - dict_im[i].ymin
    x, y = dict_im[i].xmin, dict_im[i].ymax
    rect = patches.Rectangle((x, y), width, -height, linewidth=1, edgecolor='r', facecolor='none')
    ax.add_patch(rect)
    if dict_im[i].type == 'car' or dict_im[i].type == 'watcher' or dict_im[i].type == 'base':
      ax.annotate(dict_im[i].type, (x, y-height), c='blue')
      for ele in dict_im[i].list_armor:
          width = ele.xmax - ele.xmin
          height = ele.ymax - ele.ymin
          x, y = ele.xmin, ele.ymax
          rect = patches.Rectangle((x, y), width, -height, linewidth=1, edgecolor='r', facecolor='none')
          ax.add_patch(rect)
          ax.annotate(ele.type+"_"+ele.color, (x, y-height), c='red')
  return plt.show()

def nouvelle_images(car_list,imagexml,imagejpg, directory):
  img_conv = cv2.imread(directory+'/image/'+imagejpg, cv2.IMREAD_COLOR)
  # constante pour agrandir gauche/droite de la bounding box (avoir une image
  # qui ne se limite pas qu'a la bounding box mais a celle ci + constante)
  OFFSET_CONST = 50
  ind = 0

  for _, ele in enumerate(car_list):
    # Pour l'image
    # On regarde déjà les coins
    # Attention !! Sur les bords, il faut regarder que l'on ne passe pas en dessous de 0
    # ou au dessus de la taille max (d'où les conditions avec min/max)
    ymin = max(0,int(ele.ymin)-OFFSET_CONST)
    ymax = min(int(ele.ymax)+OFFSET_CONST, img_conv.shape[0])
    xmin = max(0, int(ele.xmin)-OFFSET_CONST)
    xmax = min(int(ele.xmax)+OFFSET_CONST,img_conv.shape[1])
    
    # On ignore l'objet s'il se trouve en dehors du cadre
    if(ele.xmin >= img_conv.shape[1] or ele.ymin >= img_conv.shape[0] or ele.xmax <= 0 or ele.ymax <= 0):
      print('Bounding box element ({}, {}, {}, {}) is out of the image, skipping...'.format(ele.xmin, ele.xmax, ele.ymin, ele.ymax))
      continue


    # les axes sont inverses dans le np.array
    subimg = img_conv[ymin:ymax,xmin:xmax,:]
    imagexml2 = imagexml.rstrip('.xml')
    cv2.imwrite(directory+"/image/%s_%s.jpg"% (imagexml2,ind), subimg)
    # Pour le xml, on copie le fichier original et on retire tout ce qui n'est pas
    # dans l'element courant
    # TODO: Surement une meilleure façon de le faire !
    shutil.copy(directory+"/image_annotation/" +  imagexml, directory+"/image_annotation/%s_%s.xml"% (imagexml2,ind))
    xmlcopy = directory+"/image_annotation/%s_%s.xml"% (imagexml2,ind)
    doc = minidom.parse(xmlcopy)
    # On met a jour la taille
    element = doc.getElementsByTagName("size")
    element[0].getElementsByTagName('width')[0].firstChild.data = str(np.abs(int(ele.xmin)-int(ele.xmax))+2*OFFSET_CONST)
    element[0].getElementsByTagName('height')[0].firstChild.data =  str(np.abs(int(ele.ymin)-int(ele.ymax))+2*OFFSET_CONST)
    # Pareil pour le nom
    doc.getElementsByTagName("filename")[0].firstChild.data = "%s_%s.png"% (imagexml2,ind)

    modification = 0
    # On enleve les attributs xml non utilises
    for subele in doc.getElementsByTagName("object"):
      # If it's the car, settings the bounding box as the global image
      # On suppose que si les xmin et ymin sont egales, alors meme images (vu que
      # la bounding box commence alors au meme point)
      # TODO verifier que c'est OK !
      found = False
      # On verifie si c'est la bounding box du robot
      if float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data) == ele.xmin and \
        float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data) == ele.ymin and \
        float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data) == ele.xmax and \
        float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data) == ele.ymax:
        # Valeur dans le nouveau repere
        subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data = str(OFFSET_CONST)
        subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data = str(OFFSET_CONST)
        subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data =  str(np.abs(int(ele.xmin)-int(ele.xmax))+OFFSET_CONST)
        subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data = str(np.abs(int(ele.ymin)-int(ele.ymax))+OFFSET_CONST)
        found = True
        modification += 1
        # on continue de boucler sur les elems si on a trouve le robot
        continue
      # Sinon
      else:
        # On va boucler sur la liste des armures du robot
        for k in range(len(ele.list_armor)):
          if float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data) == ele.list_armor[k].xmin and \
            float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data) == ele.list_armor[k].ymin and \
            float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data) == ele.list_armor[k].xmax and \
            float(subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data) == ele.list_armor[k].ymax:


            subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmin')[0].firstChild.data = str(int(ele.list_armor[k].xmin) - int(ele.xmin)+OFFSET_CONST)
            subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymin')[0].firstChild.data = str(int(ele.list_armor[k].ymin) - int(ele.ymin)+OFFSET_CONST)
            subele.getElementsByTagName('bndbox')[0].getElementsByTagName('xmax')[0].firstChild.data = str(int(ele.list_armor[k].xmax) - int(ele.xmin) + OFFSET_CONST)
            subele.getElementsByTagName('bndbox')[0].getElementsByTagName('ymax')[0].firstChild.data = str(int(ele.list_armor[k].ymax) - int(ele.ymin) + OFFSET_CONST)
            modification += 1
            found = True
            # On sort de cette boucle si on l'a trouve
            break
      
      # Si jamais on ne trouve pas la balise du robot ou de ses armures
      if(not(found)):
        # on la retire du nouveau .xml
        doc.getElementsByTagName("annotation")[0].removeChild(subele) 
      
    # On verifie que si le robot a par exemple trois modules d'armure detectes dans l'image,
    # On a bien modifie 4 fois (3 + 1 robot)
    if(modification != len(ele.list_armor) + 1):
        print(modification)
        raise Exception("Number of modification ({}) is different from number of armor for the given robot element in the image ({}). This may indicate overlapping bounding box.".format(modification, len(ele.list_armor) + 1))
    
    # On met a jour le xml
    with open(xmlcopy, "w" ) as fs: 
    
          fs.write(doc.toxml())
          fs.close()

    ind += 1


if __name__ == "__main__":

    for set_name in sets:
        print(f'Processing {set_name}...')

        if not os.path.exists(f'../dataset/{set_name}'):
            print(f"No directory {set_name}")
            continue

        image_ids = [f for f in os.listdir(
            f'../dataset/{set_name}/image/') if os.path.isfile(os.path.join(f'../dataset/{set_name}/image/', f))]
        xml_ids = [f for f in os.listdir(
            f'../dataset/{set_name}/image_annotation/') if os.path.isfile(os.path.join(f'../dataset/{set_name}/image_annotation/', f))]

        assert len(image_ids) == len(xml_ids)

        for i, (image_id, xml_id) in enumerate(zip(image_ids, xml_ids)):
            if((i/len(image_ids)*100) % 10 == 0):
                print('{:0.2f}% done'.format(i / len(image_ids) * 100))
            car_list = liste_robot(xml_id, f'../dataset/{set_name}')
            nouvelle_images(car_list,xml_id,image_id, f'../dataset/{set_name}')
