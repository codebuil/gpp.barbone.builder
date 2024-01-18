import re
print ("\x1bc\x1b[43;37m")
files="/tmp/null"
f1=open(files,"r")
files=f1.read()
f1.close()
fill=files.split("\n")
fff=False
fsss=False
nx=""
fssss=False
finds=input("process to find...")
for n in fill:
    f=n.find(">:")
    fg= n.find(finds)
    nx=n
    if fg>-1 and fsss==False:
        fsss=True
    if f>-1 and fsss or fff:
        n=n.replace(">:",":")
        nn=n.split("<");
        print(f"{nn[1]}")
    else:
        nn=n.split(":")
        
        
        if len(nn)>1 and fsss:
            n=nn[1]
            m=re.search(r"\s{2}[a-zA-Z].*",n)
            if m!=None:
                n=m[0]
                f=n.find(">")
                if f>-1:
                    n=n.replace(">","")
                    
                    #try:
                     
                    mm=re.search(r"[a-zA-Z]{2,}(.*\s<).*$",n)
                    if mm!=None:
                        n=n.replace(mm[1]," ")
                        print(f"{n}")
                        fg= nx.find("ret")
                        if fg>0:
                             fsss=False
                
                else:
                   
                    print(f"{n}")
                    fg= nx.find("ret")
                    if fg>0:
                         fsss=False
                         
                         
                         
                         
                
