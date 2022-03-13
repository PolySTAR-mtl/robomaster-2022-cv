Le résultat produit par votre méthode de suivi devrait être fourni dans un
fichier 'results.txt', et devrait être formaté afin que nous puissions le
lire automatiquement. Nous nous attendons à la structure suivante:

 <frameid> <cupid> <xmin> <xmax> <ymin> <ymax>

Exemple: si pour la 36e trame de la séquence votre méthode détermine que
la tasse 1 (en noir) est dans le rectangle définit par les deux points 
<x,y> [32,45] et [65,112], et que la tasse 2 (en rouge) est dans le rectangle 
défini par les deux points <x,y> [18,30] et [42,75], alors la sortie pour la 
ligne équivalente dans 'results.txt' sera:

 36 1 32 65 45 112
 36 2 18 42 30 75

Ce fichier devrait contenir exactement 2022 lignes, et la première devrait
posséder un index de trame de 1. Notez par ailleurs que la boîte donnée pour
l'initialisation de votre méthode dans 'init.txt' est donnée sous ce format.

----------------------

The output of your tracker should be provided in a 'results.txt' file,
and should be formatted so that we can read it automatically. We expect
the following structure for our parser:

 <frameid> <cupid> <xmin> <xmax> <ymin> <ymax>

Example: if for the 36th frame of the sequence your method says the cup1 (in 
black) is in the rectangle defined with the two <x,y> points [32,45] and 
[65,112] and the cup2 (in red) is in the rectangle defined with the two <x,y> 
points [18,30] and [42,75], then the output for that line in 'results.txt' 
should be:

 36 1 32 65 45 112
 36 2 18 42 30 75

That file should contain exactly 2022 lines, and the first line should start
with a frame index of 1. Besides, note that the bounding box provided for
the initialization of your method in 'init.txt' is formatted the same way.
