print ("\x1bc\x1b[43;37m")
files="/usr/include/"+input("give me the file include name ? .h  :")
f1=open(files,"r")
files=f1.read()
f1.close()
fill=files.split("\n")
fff=False
for n in fill:
    f=n.find("extern")
    t=n.find("(")
    if f>-1 and t>-1:
        f=1
    else:
        f=-1
    if f>-1 or fff:
        n=n.replace("extern ","")
        n=n.replace("\t","")
        n=n.replace("     "," ")
        n=n.replace("    "," ")
        n=n.replace("   "," ")
        n=n.replace("  "," ")
        n=n.replace("  "," ")
        if 0==0 :
            nnn=n.find(";")
            nn=n.split(")")
            
            fffff=n.find(")")
            print(f"{nn[0]}",end="")
            if fffff>-1 or nnn>-1:
                fff=False
                print(");")
            else:
                fff=True
