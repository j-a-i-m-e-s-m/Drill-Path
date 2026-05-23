# from flask import Flask, request, jsonify
# from flask_cors import CORS
# import math
# import pandas as pd

# app = Flask(__name__)
# CORS(app)

# def grados_atan(valor):
#     return math.degrees(math.atan(valor))

# def grados_asen(valor):
#     return math.degrees(math.asin(valor))

# def grados_acos(valor):
#     n = max(-1, min(1, n))
#     return math.degrees(math.acos(valor))

# def sen_rad(grados):
#     return math.sin(math.radians(grados))

# def cos_rad(grados):
#     return math.cos(math.radians(grados))

# def tan_rad(grados):
#     return math.tan(math.radians(grados))

# def calcular_trayectoria(Nt, Ns, Et, Es, BUR, KOP, TVD, ProfExt, tipo_pozo):
#     if tipo_pozo == "s":
#         Pdes = Nt + Ns
#         Pvfc = Nt - Ns
#         Dfc = 1

#         df = pd.DataFrame({
#             "Survey": [1, 2, 3],
#             "MD": [Pdes, Pvfc, Dfc],
#             "LMD": [0, 0, 0],
#             "BUR": [BUR, BUR, BUR]
#         })

#     elif tipo_pozo == "h":
#         Pdes = Nt - Ns
#         Pvfc = Nt + Ns
#         Dfc = 2

#         df = pd.DataFrame({
#             "Survey": [1, 2, 3],
#             "MD": [Pdes, Pvfc, Dfc],
#             "LMD": [0, 0, 0],
#             "BUR": [BUR, BUR, BUR]
#         })

#     elif tipo_pozo == "j":
#         Nx = (Nt - Ns)
#         Ex = (Et - Es)
#         DH = (((Nx) ** 2) + ((Ex) ** 2)) ** 0.5
#         At = 0
#         if Nx >= 0 and Ex >= 0:
#             At = round(grados_atan(Ex / Nx), 2)
#         elif Nx < 0 and Ex >= 0:
#             At = round(grados_atan(Ex / Nx) + 180, 2)
#         elif Nx >= 0 and Ex < 0:
#             At = round(grados_atan(Ex / Nx) + 360, 2)
#         elif Nx < 0 and Ex < 0:
#             At = round(grados_atan(Ex / Nx) + 180, 2)

#         Rc = (180 / math.pi) * (1 / BUR) * 30
#         a = Rc - DH
#         b = TVD - KOP
#         c = DH - Rc
#         e = grados_atan(b / c) if c != 0 else 0
#         Angm = 0
#         if Rc > DH:
#             Angm = round(grados_asen(Rc / ((a**2 + b**2) ** 0.5)) - grados_atan(a / b), 2)
#         elif Rc < DH:
#             Angm = round(180 - grados_atan(b / c) - grados_acos(Rc / b) * grados_asen(e), 2)
#         Larc = (Angm / BUR) * 30
#         Omega = grados_asen(Rc / ((a**2 + b**2) ** 0.5)) if Rc > DH else grados_asen(Rc / ((c**2 + b**2) ** 0.5))
#         Ltan = Rc / tan_rad(Omega)
#         Pdes = round(KOP + Larc + Ltan, 2)
#         Pvfc = round(KOP + (Rc * sen_rad(Angm)), 2)
#         Dfc = round(Rc * (1 - cos_rad(Angm)), 2)
#         lsurv=float(30.00)
#         md=[0]
#         lmd=[0]
#         x=0
#         i=[1]
#         ii=1
#         bur=[0]
#         inc=[0]
#         az=[0]
#         dl=[0]
#         f=[0]
#         v=[0]
#         tvd=[0]
#         nors=[0]
#         estw=[0]
#         ntg=[Ns]
#         etg=[Es]
#         nof=[0]
#         eof=[0]
#         cd=[0]
#         acd=[0]
#         vs=[0]
        

#         while KOP>0:
#             KOP=KOP-lsurv
#             md.append(x+lsurv)
#             tvd.append(x+lsurv)
#             x=x+lsurv
#             lmd.append(float(lsurv))
#             i.append(float(ii+1))
#             ii=ii+1
#             bur.append(float(0))
#             inc.append(float(0))
#             az.append(float(0))
#             dl.append(float(0))
#             f.append(float(1))
#             v.append(float(lsurv))
#             nors.append(float(0))
#             estw.append(float(0))
#             ntg.append(float(Ns))
#             etg.append(float(Es))
#             nof.append(float(0))
#             eof.append(float(0))
#             cd.append(float(0))
#             acd.append(float(0))
#             vs.append(float(0))
#         while inc [-1]<Angm:
#                 md.append(float(x+lsurv))
#                 inc.append(float(inc[-1]+BUR))
#                 lmd.append(float(lsurv))
#                 x=x+lsurv
#                 i.append(float(ii+1))
#                 ii=ii+1
#                 bur.append(float(BUR))
#                 az.append(float(At))
#                 dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
#                 f.append(float(round((2/(math.radians(dl[-1]))*(tan_rad(dl[-1]/2))),9)))
#                 v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
#                 tvd.append(float(round(v[-1]+tvd[-1],3)))
#                 nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
#                 estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
#                 ntg.append(float(round(ntg[-1]+nors[-1],2)))
#                 etg.append(float(round(etg[-1]+estw[-1],2)))
#                 nof.append(float(round(ntg[0]-ntg[-1],2)))
#                 eof.append(float(round(etg[0]-etg[-1],2)))
#                 cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
#                 acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
#                 vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
#         while TVD> tvd[-1]:
#                     md.append(float(x+lsurv))
#                     inc.append(float(inc[-1]))
#                     lmd.append(float(lsurv))
#                     x=x+lsurv
#                     i.append(float(ii+1))
#                     ii=ii+1
#                     bur.append(float(0))
#                     az.append(float(At))
#                     dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
#                     f.append(float(1))
#                     v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
#                     tvd.append(float(round(v[-1]+tvd[-1],3)))
#                     nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
#                     estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
#                     ntg.append(float(round(ntg[-1]+nors[-1],2)))
#                     etg.append(float(round(etg[-1]+estw[-1],2)))
#                     nof.append(float(round(ntg[0]-ntg[-1],2)))
#                     eof.append(float(round(etg[0]-etg[-1],2)))
#                     cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
#                     acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
#                     vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
#         if md[-1]>Pdes:
#                         md.pop()
#                         md.append(Pdes)
#                         lmd.pop()
#                         lmd.append(round(Pdes-md[-2],2))
#                         v.pop()
#                         v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
#                         tvd.pop()
#                         tvd.append(float(round(v[-1]+tvd[-1],2)))
#                         nors.pop()
#                         nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
#                         estw.pop()
#                         estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
#                         ntg.pop()
#                         ntg.append(float(round(ntg[-1]+nors[-1],2)))
#                         etg.pop()
#                         etg.append(float(round(etg[-1]+estw[-1],2)))
#                         nof.pop()
#                         nof.append(float(round(ntg[0]-ntg[-1],2)))
#                         eof.pop()
#                         eof.append(float(round(etg[0]-etg[-1],2)))
#                         cd.pop()
#                         cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
#                         acd.pop()
#                         acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
#                         vs.pop()
#                         vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
#         df=pd.DataFrame({"Survey":list(i),"MD":list(md),"LMD":list(lmd),"BUR":list(bur),"Inc":list(inc),
#                 "Az":list(az),"Dla":list(dl),"F":list(f),"V":list(v),"TVD":list(tvd),"DeltNS":(nors),"DeltEW":(estw),
#                 "Northing":list(ntg),"Easting":list(etg),"Nof":list(nof),"Eof":list(eof),"Cd":list(cd),"Acd":list(acd),"Vs":list(vs),})


        
#     # Extraer survey y lmd del DataFrame
#     survey = [float(x) for x in df["Dla"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
#     Dlamax = max(survey)
#     lmd = [float(x) for x in df["MD"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados 
#     tvd = [float(x) for x in df["TVD"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
#     vs = [float(x) for x in df["Vs"].tolist()]
#     inc = [float(x) for x in df["Inc"].tolist()]
#     ntg = [float(x) for x in df["Northing"].tolist()]
#     etg = [float(x) for x in df["Easting"].tolist()]
#     Az = [float(x) for x in df["Az"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados falta vs
#     Nof = [float(x) for x in df["Nof"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
#     Eof = [float(x) for x in df["Eof"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados
#     print(df.to_string())
#     return {
#         "Pdes": Pdes,
#         "Pvfc": Pvfc,
#         "Dfc": Dfc,
#         "Angm": Angm,
#         "At": At,
#         "survey": survey,
#         "Dlamax": Dlamax,            
#         "lmd": lmd,
#         "ntg": ntg,
#         "etg": etg,
#         "Az": Az,
#         "inc": inc,
#         "tvd": tvd,
#         "vs": vs,
#         "Nof": Nof,
#         "Eof": Eof,
#         "data": df.to_dict(orient="records")
#     }

# @app.route('/calcular', methods=['POST'])
# def procesar():
#     try:
#         data = request.get_json()
#         print("Datos recibidos:", data)

#         Nt = float(data.get('coordenadas_ns_target', 0))
#         Ns = float(data.get('coordenadas_ns_superficie', 0))
#         Et = float(data.get('coordenadas_ew_target', 0))
#         Es = float(data.get('coordenadas_ew_superficie', 0))
#         BUR = float(data.get('ritmo_incremento', 0))
#         ritmo_reduccion = float(data.get('ritmo_reduccion', 0))
#         KOP = float(data.get('inicio_desviacion', 0))
#         TVD = float(data.get('profundidad_objetivo', 0))
#         ProfExt = float(data.get('distancia_post_curva', 0))
#         tipo_pozo = data.get('tipo_pozo', 'j')

#         resultado = calcular_trayectoria(
#             Nt, Ns, Et, Es, BUR, KOP, TVD, ProfExt, tipo_pozo
#         )

#         return jsonify({
#             "status": "success",
#             "data": resultado
#         })

#     except Exception as e:
#         return jsonify({
#             "status": "error",
#             "message": str(e)
#         })

# if __name__ == '__main__':
#     app.run(host="127.0.0.1", port=5000, debug=False, use_reloader=False)
from flask import Flask, request, jsonify
from flask_cors import CORS
import math
import pandas as pd

app = Flask(__name__)
CORS(app)

def grados_atan(valor):
    return math.degrees(math.atan(valor))

def grados_asen(valor):
    return math.degrees(math.asin(valor))

def grados_acos(valor):
    valor = max(-1, min(1, valor))
    return math.degrees(math.acos(valor))

def sen_rad(grados):
    return math.sin(math.radians(grados))

def cos_rad(grados):
    return math.cos(math.radians(grados))

def tan_rad(grados):
    return math.tan(math.radians(grados))

def calcular_trayectoria(Nt, Ns, Et, Es, BUR, DOR, KOP, TVD, ProfExt, tipo_pozo):
    Pvfc = None  
    Dfc = None
#Desde aqui empiezan las formulas y el algoritmo para las distintas trayectorias 
    if tipo_pozo == "s":
        Nx=(Nt-Ns)
        Ex=(Et-Es)
        DH= (((Nx)**2)+((Ex)**2))**.5
        At=0
        if Nx>=0 and Ex >=0:
            At=float(grados_atan(Ex/Nx))
            At=round(At,2)
        elif Nx<0 and Ex >=0:
            At=float(grados_atan(Ex/Nx))+180
            At=round(At,2)
        elif Nx>=0 and Ex <0:
            At=float(grados_atan(Ex/Nx))+360
            At=round(At,2)
        elif Nx<0 and Ex <0:
            At=float(grados_atan(Ex/Nx))+180
            At=round(At,2)
                #----------R,ang,larc,ltan,dm,d2,x2
        Rca=round((180/math.pi)*(1/BUR)*30,14)
        Rcb=round((180/math.pi)*(1/DOR)*30,14)
        Rt=Rca+Rcb
        a=Rt-DH #r2+r1-x4
        b=TVD-KOP#d4-d1
        c=DH-(Rca-Rcb) #x4-(r1-r2)
        d=DH-(Rt) #x4-(r1+r2)
        e=(grados_atan(b/a))
        f=(grados_atan(b/d))
        Angm=0
        if Rt>DH:
            Angm=float(grados_atan(b/a))-(grados_acos((Rt/b)*(sen_rad(e))))
            Angm=round(Angm,14)
        elif Rt<DH:
            Angm=float(180-(grados_atan(b/c))-(grados_acos(Rt/b)*(grados_asen(f))))
            Angm=round(Angm,14)
            
        At=At
        Larca=round(((Angm/BUR)*30),4)
        Larcb=round(((Angm/BUR)*30),4)
        Pvfci=round(KOP+(Rca*(sen_rad(Angm))),2)
        Dhfci=round(Rca*(1-(cos_rad(Angm))),2)
        Pvfst=round(TVD-(Rcb*(sen_rad(Angm))),2)
        Dhfst=round(DH-(Rcb*(1-(cos_rad(Angm)))),2)
        Omega=float(grados_asen(Rca/(((Dhfst-Rca)**2+(Pvfst-KOP)**2)**.5)))
        Ltan=round((Rca/(tan_rad(Omega))),2)
        Pdes=round(KOP+Larca+Ltan+Larcb+ProfExt,2)
        Pdfci=round(KOP+Larca,2)
        Pdfst=round(KOP+Larca+Ltan,2)
        Pdfcd=round(KOP+Larca+Ltan+Larcb,2)
        DH=DH
        angmax=round(Angm,2)
        

        lsurv=float(30.00)
        md=[0]
        lmd=[0]
        x=0
        i=[1]
        ii=1
        bur=[0]
        burin=float(BUR)
        dorin=float(DOR)
        inc=[0]
        az=[0]
        dl=[0]
        f=[0]
        v=[0]
        tvd=[0]
        nors=[0]
        ns=float(Ns)
        estw=[0]
        es=float(Es)
        ntg=[Ns]
        etg=[Es]
        nof=[0]
        eof=[0]
        cd=[0]
        acd=[0]
        vs=[0]
        while KOP>0:
            KOP=KOP-lsurv
            md.append(x+lsurv)
            tvd.append(x+lsurv)
            x=x+lsurv
            lmd.append(float(lsurv))
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            inc.append(float(0))
            az.append(float(0))
            dl.append(float(0))
            f.append(float(1))
            v.append(float(lsurv))
            nors.append(float(0))
            estw.append(float(0))
            ntg.append(float(ns))
            etg.append(float(es))
            nof.append(float(0))
            eof.append(float(0))
            cd.append(float(0))
            acd.append(float(0))
            vs.append(float(0))
        

        while inc [-1]<angmax:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]+burin))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(burin))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(round((2/(math.radians(dl[-1]))*(tan_rad(dl[-1]/2))),9)))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
            
        while Pvfst> tvd[-1]:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(1))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
           
        if tvd[-1]>Pvfst:####### continuamos desdeaqui
            lmd.pop()
            lmd.append((1/cos_rad(inc[-1]))*(Pvfst-tvd[-2]))
            md.pop()
            md.append(round(md[-1]+lmd[-1],1))
            v.pop()
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),2)))
            tvd.pop()
            tvd.append(float(round(Pvfst,2)))
            nors.pop()
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.pop()
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.pop()
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.pop()
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.pop()
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.pop()
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.pop()
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.pop()
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.pop()
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
            
        while inc [-1]>0:
            md.append(float(md[-1]+lsurv))
            inc.append(float(inc[-1]-dorin))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(dorin))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(round((2/(math.radians(dl[-1]))*(tan_rad(dl[-1]/2))),9)))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
            
            
        while Pdes>md[-1]:
            md.append(float(md[-1]+lsurv))
            inc.append(float(inc[-1]))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(0)
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(1)
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2))) 
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
               
        if md[-1]>Pdes: 
            md.pop()
            md.append(Pdes)
            lmd.pop()
            lmd.append(round(Pdes-md[-2],2))
            v.pop()
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.pop()
            tvd.append(float(round(v[-1]+tvd[-1],2)))
            nors.pop()
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
            estw.pop()
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
            ntg.pop()
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.pop()
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.pop()
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.pop()
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.pop()
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.pop()
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.pop()
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))  

    elif tipo_pozo == "h":
        Nx=(Nt-Ns)
        Ex=(Et-Es)
        DH= round((((Nx)**2)+((Ex)**2))**.5,2)
        At=0
        if Nx>=0 and Ex >=0:
            At=float(grados_atan(Ex/Nx))
            At=round(At,2)
        elif Nx<0 and Ex >=0:
            At=float(grados_atan(Ex/Nx))+180
            At=round(At,2)
        elif Nx>=0 and Ex <0:
            At=float(grados_atan(Ex/Nx))+360
            At=round(At,2)
        elif Nx<0 and Ex <0:
            At=float(grados_atan(Ex/Nx))+180
            At=round(At,2)
        #----------R,ang,larc,ltan,dm,d2,x2
        Rc=round((180/math.pi)*(1/BUR)*30,2)
        Angm=round((grados_acos(1-(DH/Rc))))
        Dhfci=round(Rc*(1-(cos_rad(Angm))),2)
        Larc=round((Angm/BUR)*30,2)
        Pdes=KOP+Larc+ProfExt
        At=At
        Larca=round(((Angm/BUR)*30),4)
        Larcb=round(0,2)
        Pvfci=round(0,2)
        Pvfst=round(0,2)
        Dhfst=round(0,2)
        Ltan=round(0,2)
        Pdfci=round(KOP+Larca,2)
        Pdfst=round(0,2)
        Pdfcd=round(0,2)
        DH=DH
        angmax=round(Angm,2)


        lsurv=float(30.00)
        md=[0]
        lmd=[0]
        x=0
        i=[1]
        ii=1
        bur=[0]
        inc=[0]
        az=[0]
        dl=[0]
        f=[0]
        v=[0]
        tvd=[0]
        nors=[0]
        ns=float(Ns)
        estw=[0]
        es=float(Es)
        ntg=[Ns]
        etg=[Es]
        nof=[0]
        eof=[0]
        cd=[0]
        acd=[0]
        vs=[0]

        while KOP>0:
            KOP=KOP-lsurv
            md.append(x+lsurv)
            tvd.append(x+lsurv)
            x=x+lsurv
            lmd.append(float(lsurv))
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            inc.append(float(0))
            az.append(float(0))
            dl.append(float(0))
            f.append(float(1))
            v.append(float(lsurv))
            nors.append(float(0))
            estw.append(float(0))
            ntg.append(float(ns))
            etg.append(float(es))
            nof.append(float(0))
            eof.append(float(0))
            cd.append(float(0))
            acd.append(float(0))
            vs.append(float(0))

        while inc [-1]<Angm:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]+BUR))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(BUR))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(round((2/(math.radians(dl[-1]))*(tan_rad(dl[-1]/2))),9)))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
        while md[-1]< Pdes:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(1))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),16)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),16)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
        if md[-1]>Pdes:
            md.pop()
            md.append(Pdes)
            lmd.pop()
            lmd.append(round(Pdes-md[-2],2))
            v.pop()
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.pop()
            tvd.append(float(round(v[-1]+tvd[-1],2)))
            nors.pop()
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
            estw.pop()
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
            ntg.pop()
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.pop()
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.pop()
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.pop()
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.pop()
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.pop()
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.pop()
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
        

    elif tipo_pozo == "j":
        Nx = (Nt - Ns)
        Ex = (Et - Es)
        DH = (((Nx) ** 2) + ((Ex) ** 2)) ** 0.5
        At = 0
        if Nx >= 0 and Ex >= 0:
            At = round(grados_atan(Ex / Nx), 2)
        elif Nx < 0 and Ex >= 0:
            At = round(grados_atan(Ex / Nx) + 180, 2)
        elif Nx >= 0 and Ex < 0:
            At = round(grados_atan(Ex / Nx) + 360, 2)
        elif Nx < 0 and Ex < 0:
            At = round(grados_atan(Ex / Nx) + 180, 2)

        Rc = (180 / math.pi) * (1 / BUR) * 30
        a = Rc - DH
        b = TVD - KOP
        c = DH - Rc
        e = grados_atan(b / c) if c != 0 else 0
        Angm = 0
        if Rc > DH:
            Angm = round(grados_asen(Rc / ((a**2 + b**2) ** 0.5)) - grados_atan(a / b), 2)
        elif Rc < DH:
            Angm = round(180 - grados_atan(b / c) - grados_acos(Rc / b) * grados_asen(e), 2)
        Larca = (Angm / BUR) * 30
        Omega = grados_asen(Rc / ((a**2 + b**2) ** 0.5)) if Rc > DH else grados_asen(Rc / ((c**2 + b**2) ** 0.5))
        Ltan = Rc / tan_rad(Omega)
        Pdes = round(KOP + Larca + Ltan, 2)
        Pvfci = round(KOP + (Rc * sen_rad(Angm)), 2)
        Dhfci = round(Rc * (1 - cos_rad(Angm)), 2)
        At=At
        Larcb=round(0,2)
        Pvfst=round(0,2)
        Dhfst=round(0,2)
        Pdfci=round(0,2)
        Pdfst=round(0,2)
        Pdfcd=round(0,2)
        DH=DH
        angmax=round(Angm,2)

        lsurv=float(30.00)
        md=[0]
        lmd=[0]
        x=0
        i=[1]
        ii=1
        bur=[0]
        inc=[0]
        az=[0]
        dl=[0]
        f=[0]
        v=[0]
        tvd=[0]
        nors=[0]
        estw=[0]
        ntg=[Ns]
        etg=[Es]
        nof=[0]
        eof=[0]
        cd=[0]
        acd=[0]
        vs=[0]
        

        while KOP>0:
            KOP=KOP-lsurv
            md.append(x+lsurv)
            tvd.append(x+lsurv)
            x=x+lsurv
            lmd.append(float(lsurv))
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            inc.append(float(0))
            az.append(float(0))
            dl.append(float(0))
            f.append(float(1))
            v.append(float(lsurv))
            nors.append(float(0))
            estw.append(float(0))
            ntg.append(float(Ns))
            etg.append(float(Es))
            nof.append(float(0))
            eof.append(float(0))
            cd.append(float(0))
            acd.append(float(0))
            vs.append(float(0))
        while inc [-1]<Angm:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]+BUR))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(BUR))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(round((2/(math.radians(dl[-1]))*(tan_rad(dl[-1]/2))),9)))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
        while TVD> tvd[-1]:
            md.append(float(x+lsurv))
            inc.append(float(inc[-1]))
            lmd.append(float(lsurv))
            x=x+lsurv
            i.append(float(ii+1))
            ii=ii+1
            bur.append(float(0))
            az.append(float(At))
            dl.append(float(round(grados_acos((cos_rad(inc[-2])*cos_rad(inc[-1])+(sen_rad(inc[-2])*sen_rad(inc[-1])*cos_rad(az[-2]-az[-1])))),2)))
            f.append(float(1))
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.append(float(round(v[-1]+tvd[-1],3)))
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))
        if md[-1]>Pdes:
            md.pop()
            md.append(Pdes)
            lmd.pop()
            lmd.append(round(Pdes-md[-2],2))
            v.pop()
            v.append(float(round(f[-1]*(lmd[-1]/2)*(cos_rad(inc[-2])+cos_rad(inc[-1])),7)))
            tvd.pop()
            tvd.append(float(round(v[-1]+tvd[-1],2)))
            nors.pop()
            nors.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*cos_rad(az[-2])+sen_rad(inc[-1])*cos_rad(az[-1])),5)))
            estw.pop()
            estw.append(float(round(f[-1]*(lmd[-1]/2)*(sen_rad(inc[-2])*sen_rad(az[-2])+sen_rad(inc[-1])*sen_rad(az[-1])),5)))
            ntg.pop()
            ntg.append(float(round(ntg[-1]+nors[-1],2)))
            etg.pop()
            etg.append(float(round(etg[-1]+estw[-1],2)))
            nof.pop()
            nof.append(float(round(ntg[0]-ntg[-1],2)))
            eof.pop()
            eof.append(float(round(etg[0]-etg[-1],2)))
            cd.pop()
            cd.append(float(math.sqrt(nof[-1]**2 + eof[-1]**2)))
            acd.pop()
            acd.append(float(grados_atan(eof[-1]/nof[-1] if (nof[-1] != 0) else 0)))
            vs.pop()
            vs.append(float(cos_rad(az[-2]-az[-1])*cd[-1]))

    df=pd.DataFrame({"Survey":list(i),"MD":list(md),"LMD":list(lmd),"BUR":list(bur),"Inc":list(inc),
            "Az":list(az),"Dla":list(dl),"F":list(f),"V":list(v),"TVD":list(tvd),"DeltNS":(nors),"DeltEW":(estw),
            "Northing":list(ntg),"Easting":list(etg),"Nof":list(nof),"Eof":list(eof),"Cd":list(cd),"Acd":list(acd),"Vs":list(vs),})
#hasta aqui se crea la lista de estaciones/surveys con los que cuenta la trayectoria determinada

        
    # Extraer survey y lmd del DataFrame
    survey = [float(x) for x in df["Dla"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
    Dlamax = max(survey)
    lmd = [float(x) for x in df["MD"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados 
    tvd = [float(x) for x in df["TVD"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
    vs = [float(x) for x in df["Vs"].tolist()]
    inc = [float(x) for x in df["Inc"].tolist()]
    ntg = [float(x) for x in df["Northing"].tolist()]
    etg = [float(x) for x in df["Easting"].tolist()]
    Az = [float(x) for x in df["Az"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados falta vs
    Nof = [float(x) for x in df["Nof"].tolist()] #estaba "Survey", lo cambie  dla para que se grafique dl
    Eof = [float(x) for x in df["Eof"].tolist()] #estaba "LMD", lo cambie  md para que se grafiquen los desarrollados
    print(df.to_string())
    return {
        "Pdes": Pdes,
        "Pvfc": Pvfc,
        "Dfc": Dfc,
        "Angm": Angm,
        "At": At,
        "survey": survey,
        "Dlamax": Dlamax,            
        "lmd": lmd,
        "ntg": ntg,
        "etg": etg,
        "Az": Az,
        "inc": inc,
        "tvd": tvd,
        "vs": vs,
        "Nof": Nof,
        "Eof": Eof,
        "data": df.to_dict(orient="records"),
        "Pvfci": Pvfci,
        "Dhfci": Dhfci,
        "Larca": Larca,
        "Larcb": Larcb,
        "Ltan": Ltan,
        "Pvfst": Pvfst,
        "Dhfst": Dhfst,
        "Pdfci": Pdfci,
        "Pdfst": Pdfst,
        "Pdfcd": Pdfcd,
        "DH": DH,
        "angmax": angmax
    }

@app.route('/calcular', methods=['POST'])
def procesar():
    try:
        data = request.get_json()
        print("Datos recibidos:", data)

        Nt = float(data.get('coordenadas_ns_target', 0))
        Ns = float(data.get('coordenadas_ns_superficie', 0))
        Et = float(data.get('coordenadas_ew_target', 0))
        Es = float(data.get('coordenadas_ew_superficie', 0))
        BUR = float(data.get('ritmo_incremento', 0))
        DOR = float(data.get('ritmo_reduccion', 0))
        KOP = float(data.get('inicio_desviacion', 0))
        TVD = float(data.get('profundidad_objetivo', 0))
        ProfExt = float(data.get('distancia_post_curva', 0))
        tipo_pozo = data.get('tipo_pozo')

        resultado = calcular_trayectoria(
            Nt, Ns, Et, Es, BUR, DOR, KOP, TVD, ProfExt, tipo_pozo
        )

        return jsonify({
            "status": "success",
            "data": resultado
        })

    except Exception as e:
        return jsonify({
            "status": "error",
            "message": str(e)
        })

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=False, use_reloader=False)