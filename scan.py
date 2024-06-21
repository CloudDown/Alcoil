
print("\033[0;33m"r'''
   _                                                     
,-'  `-._                                          
|=========|                                          
(  \/     )    _____  .__               .__.__            
 | !!    |     /  _  \ |  |   ____  ____ |__|  |          
 | __,   |    /  /_\  \|  | _/ ___\/  _ \|  |  |       
 |       |   /    |    \  |_\  \__(  <_> )  |  |__     
 `=======    \____|__  /____/\___  >____/|__|____/     Cheat by CloudDown               
^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~^~        

''')

print('\033[0m'+"ㅤF4 :"+'\033[0;32m'+"ㅤ[On"+'\033[0m'+" / "+'\033[0;31m'+"Off]","\n")
print('\033[0m'+"ㅤF8 :"+'\033[0;31m'+"ㅤClose","\n"+'\033[7;37m')

from PIL import Image
import os


ls = os.listdir(os.getcwd()+r"\weapon")
for i in range (len(ls)):
   if i%5 == 0:
      print("\n")
   print('['+str(i+1)+']',ls[i][:-7],end=" ")
print("\n"+"\n"+'\033[0m')
fichier = int(input("Choose the no-recoil weapon file : "))
print("")
inf=ls[fichier-1][-6]


image = Image.open(os.getcwd()+r"\weapon\\"+ls[fichier-1])
image = image.convert('RGB')
long, hauteur = image.size
liste_coo=[]
for y in range(hauteur):
   for x in range(long):
      r,g,b=image.getpixel((x, hauteur-y-1))
      if r <=235 and g <=235 and b <= 235:
         liste_coo.append((x,hauteur-y-1))

liste_moov=[""]
sujet=liste_coo[0]
for i in range(len(liste_coo)-1):
   x=sujet[0]
   y=sujet[1]
   r,g,b=image.getpixel((x, y))
   if r >=100:
      liste_moov.append("W1")
      sujet=(x,y-1)
   elif g >=100:
      liste_moov.append("W2")
      sujet=(x,y-1)
   elif b >=100:
      liste_moov.append("W3")
      sujet=(x,y-1)
   elif (x,y-1) in liste_coo and liste_moov[-1]!="D":
      liste_moov.append("U")
      sujet=(x,y-1)
   elif (x,y+1) in liste_coo and liste_moov[-1]!="U" and liste_moov[-1][0]!="W":
      liste_moov.append("D")
      sujet=(x-1,y-1)
   elif (x-1,y) in liste_coo and liste_moov[-1]!="R":
      liste_moov.append("L")
      sujet=(x-1,y)
   elif (x+1,y) in liste_coo and liste_moov[-1]!="L":
      liste_moov.append("R")
      sujet=(x+1,y)
   elif (x-1,y-1) in liste_coo and liste_moov[-1]!="RD":
      liste_moov.append("LU")
      sujet=(x-1,y-1)
   elif (x+1,y-1) in liste_coo and liste_moov[-1]!="LD":
      liste_moov.append("RU")
      sujet=(x+1,y-1)
   elif (x+1,y+1) in liste_coo and liste_moov[-1]!="LU":
      liste_moov.append("RD")
      sujet=(x+1,y+1)
   elif (x,y+1) in liste_coo and liste_moov[-1]!="RU":
      liste_moov.append("LD")
      sujet=(x-1,y-1)

liste_moov=liste_moov[1:]



with open('mousemoove.txt', 'w') as file:
      file.write(inf)
      file.write(",")
      for elt in liste_moov:
         file.write(elt)
         file.write(",")
      




