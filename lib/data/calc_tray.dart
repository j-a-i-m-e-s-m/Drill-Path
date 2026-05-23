import 'dart:math' as math;

class WellTrajectoryService {
  // Custom trigonometric functions
  double grados_atan(double x) => math.atan(x) * 180 / math.pi;
  double sen_rad(double x) => math.sin(x * math.pi / 180);
  double cos_rad(double x) => math.cos(x * math.pi / 180);
  double tan_rad(double x) => math.tan(x * math.pi / 180);
  double grados_acos(double x) {
    x = x.clamp(-1.0, 1.0); // Ensure input is valid for acos
    return math.acos(x) * 180 / math.pi;
  }
  double grados_asen(double x) => math.asin(x) * 180 / math.pi;

  Map<String, dynamic> calculateWellTrajectory({
    required String tipoPozo,
    required double Nt,
    required double Ns,
    required double Et,
    required double Es,
    required double TVD,
    required double KOP,
    required double BUR,
    required double DOR,
    required double ProfExt,
  }) {
    double Nx = 0.0;
    double Ex = 0.0;
    double DH = 0.0;
    double At = 0.0;
    double Rc = 0.0;
    double Rca = 0.0;
    double Rcb = 0.0;
    double Rt = 0.0;
    double a = 0.0;
    double b = 0.0;
    double c = 0.0;
    double d = 0.0;
    double e = 0.0;
    double f_local = 0.0;
    double Angm = 0.0;
    double Larca = 0.0;
    double Larcb = 0.0;
    double Pvfci = 0.0;
    double Dhfci = 0.0;
    double Pvfst = 0.0;
    double Dhfst = 0.0;
    double Omega = 0.0;
    double Ltan = 0.0;
    double Pdes = 0.0;
    double Pdfci = 0.0;
    double Pdfst = 0.0;
    double Pdfcd = 0.0;
    double angmax = 0.0;

    double lsurv = 30.0;
    List<double> md = [0];
    List<double> lmd = [0];
    double x = 0;
    List<double> i = [1];
    double ii = 1;
    List<double> bur = [0];
    double burin = BUR;
    double dorin = DOR;
    List<double> inc = [0];
    List<double> az = [0];
    List<double> dl = [0];
    List<double> f = [0];
    List<double> v = [0];
    List<double> tvd = [0];
    List<double> nors = [0];
    double ns = Ns;
    List<double> estw = [0];
    double es = Es;
    List<double> ntg = [Ns];
    List<double> etg = [Es];
    List<double> nof = [0];
    List<double> eof = [0];
    List<double> cd = [0];
    List<double> acd = [0];
    List<double> vs = [0];
/////////////////Desde aqui empiezan las formulas y el algoritmo para las distintas trayectorias 
    if (tipoPozo == "s") {
      Nx = Nt - Ns;
      Ex = Et - Es;
      DH = math.sqrt(Nx * Nx + Ex * Ex);
      At = 0;
      if (Nx >= 0 && Ex >= 0) {
        At = grados_atan(Ex / Nx);
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx < 0 && Ex >= 0) {
        At = grados_atan(Ex / Nx) + 180;
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx >= 0 && Ex < 0) {
        At = grados_atan(Ex / Nx) + 360;
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx < 0 && Ex < 0) {
        At = grados_atan(Ex / Nx) + 180;
        At = double.parse(At.toStringAsFixed(2));
      }

      Rca = double.parse(((180 / math.pi) * (1 / BUR) * 30).toStringAsFixed(14));
      Rcb = double.parse(((180 / math.pi) * (1 / DOR) * 30).toStringAsFixed(14));
      Rt = Rca + Rcb;
      a = Rt - DH;
      b = TVD - KOP;
      c = DH - (Rca - Rcb);
      d = DH - Rt;
      e = grados_atan(b / a);
      f_local = grados_atan(b / d);
      Angm = 0;
      if (Rt > DH) {
        Angm = grados_atan(b / a) - grados_acos((Rt / b) * sen_rad(e));
        Angm = double.parse(Angm.toStringAsFixed(14));
      } else if (Rt < DH) {
        Angm = 180 - grados_atan(b / c) - (grados_acos(Rt / b) * grados_asen(f_local));
        Angm = double.parse(Angm.toStringAsFixed(14));
      }

      At = At;
      Larca = double.parse(((Angm / BUR) * 30).toStringAsFixed(4));
      Larcb = double.parse(((Angm / DOR) * 30).toStringAsFixed(4));
      Pvfci = double.parse((KOP + (Rca * sen_rad(Angm))).toStringAsFixed(2));
      Dhfci = double.parse((Rca * (1 - cos_rad(Angm))).toStringAsFixed(2));
      Pvfst = double.parse((TVD - (Rcb * sen_rad(Angm))).toStringAsFixed(2));
      Dhfst = double.parse((DH - (Rcb * (1 - cos_rad(Angm)))).toStringAsFixed(2));
      Omega = grados_asen(Rca / math.sqrt((Dhfst - Rca) * (Dhfst - Rca) + (Pvfst - KOP) * (Pvfst - KOP)));
      Ltan = double.parse((Rca / tan_rad(Omega)).toStringAsFixed(2));
      Pdes = double.parse((KOP + Larca + Ltan + Larcb + ProfExt).toStringAsFixed(2));
      Pdfci = double.parse((KOP + Larca).toStringAsFixed(2));
      Pdfst = double.parse((KOP + Larca + Ltan).toStringAsFixed(2));
      Pdfcd = double.parse((KOP + Larca + Ltan + Larcb).toStringAsFixed(2));
      DH = DH;
      angmax = double.parse(Angm.toStringAsFixed(2));

      while (KOP > 0) {
        KOP = KOP - lsurv;
        md.add(x + lsurv);
        tvd.add(x + lsurv);
        x = x + lsurv;
        lmd.add(lsurv);
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        inc.add(0);
        az.add(0);
        dl.add(0);
        f.add(1);
        v.add(lsurv);
        nors.add(0);
        estw.add(0);
        ntg.add(ns);
        etg.add(es);
        nof.add(0);
        eof.add(0);
        cd.add(0);
        acd.add(0);
        vs.add(0);
      }

      while (inc.last < angmax) {
        md.add(x + lsurv);
        inc.add(inc.last + burin);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(burin);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(double.parse(
            (2 / (dl.last * math.pi / 180) * tan_rad(dl.last / 2)).toStringAsFixed(9)));
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      while (Pvfst > tvd.last) {
        md.add(x + lsurv);
        inc.add(inc.last);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(1);
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      if (tvd.last > Pvfst) {
        lmd.removeLast();
        lmd.add((1 / cos_rad(inc.last)) * (Pvfst - tvd[tvd.length - 2]));
        md.removeLast();
        md.add(double.parse((md.last + lmd.last).toStringAsFixed(1)));
        v.removeLast();
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(2)));
        tvd.removeLast();
        tvd.add(double.parse(Pvfst.toStringAsFixed(2)));
        nors.removeLast();
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.removeLast();
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.removeLast();
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.removeLast();
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.removeLast();
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.removeLast();
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.removeLast();
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.removeLast();
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.removeLast();
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      while (inc.last > 0) {
        md.add(md.last + lsurv);
        inc.add(inc.last - dorin);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(dorin);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(double.parse(
            (2 / (dl.last * math.pi / 180) * tan_rad(dl.last / 2)).toStringAsFixed(9)));
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      while (Pdes > md.last) {
        md.add(md.last + lsurv);
        inc.add(inc.last);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(4)));
        f.add(1);
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        
        tvd.add(double.parse((tvd.last + v.last).toStringAsFixed(4)));
        if (tvd.last < tvd[tvd.length - 2]) {
              tvd[tvd.length - 1] = tvd[tvd.length - 2]; // Evitar reducción de TVD
              // print('Advertencia: tvd.last ajustado para evitar reducción');
              }
        // print('Después de tvd.add: tvd.last = ${tvd.last}, v.last = ${v.last}');
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      if (md.last > Pdes) {
        // print('Ejecutando ajuste: md.last = ${md.last}, Pdes = $Pdes, tvd.last antes = ${tvd.last}');
        md.removeLast();
        md.add(Pdes);
        lmd.removeLast();/////
        lmd.add(double.parse((Pdes - md[md.length - 2]).toStringAsFixed(4)));
        if (lmd.last < 0) {
            lmd[lmd.length - 1] = 0.0; // Evitar valores negativos
            // print('Advertencia: lmd.last era negativo, ajustado a 0');
          }
        
      
        v.removeLast();
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.removeLast();
        tvd.add(double.parse((tvd.last + v.last).toStringAsFixed(4)));
        if (tvd.last < tvd[tvd.length - 2]) {
          tvd[tvd.length - 1] = tvd[tvd.length - 2]; // Evitar reducción de TVD
          // print('Advertencia: tvd.last ajustado para evitar reducción');
        }
        // print('Después del ajuste: tvd.last = ${tvd.last}, v.last = ${v.last}');
        nors.removeLast();
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(5)));
        estw.removeLast();
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(5)));
        ntg.removeLast();
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.removeLast();
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.removeLast();
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.removeLast();
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.removeLast();
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.removeLast();
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.removeLast();
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }
    } else if (tipoPozo == "h") {
      DOR=0;
      Nx = Nt - Ns;
      Ex = Et - Es;
      DH = double.parse(math.sqrt((Nx * Nx) + (Ex * Ex)).toStringAsFixed(2));
      At = 0;
      if (Nx >= 0 && Ex >= 0) {
        At = grados_atan(Ex / Nx);
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx < 0 && Ex >= 0) {
        At = grados_atan(Ex / Nx) + 180;
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx >= 0 && Ex < 0) {
        At = grados_atan(Ex / Nx) + 360;
        At = double.parse(At.toStringAsFixed(2));
      } else if (Nx < 0 && Ex < 0) {
        At = grados_atan(Ex / Nx) + 180;
        At = double.parse(At.toStringAsFixed(2));
      }

      Rc = double.parse(((180 / math.pi) * (1 / BUR) * 30).toStringAsFixed(2));
      Angm = double.parse(grados_acos(1 - (DH / Rc)).toStringAsFixed(2));
      Dhfci = double.parse((Rc * (1 - cos_rad(Angm))).toStringAsFixed(2));
      Larca = double.parse(((Angm / BUR) * 30).toStringAsFixed(2));
      Pdes = KOP + Larca + ProfExt;
      At = At;
      Larcb = double.parse(0.toStringAsFixed(2));
      Pvfci = double.parse(0.toStringAsFixed(2));
      Pvfst = double.parse(0.toStringAsFixed(2));
      Dhfst = double.parse(0.toStringAsFixed(2));
      Ltan = double.parse(0.toStringAsFixed(2));
      Pdfci = double.parse((KOP + Larca).toStringAsFixed(2));
      Pdfst = double.parse(0.toStringAsFixed(2));
      Pdfcd = double.parse(0.toStringAsFixed(2));
      DH = DH;
      angmax = double.parse(Angm.toStringAsFixed(2));

      while (KOP > 0) {
        KOP = KOP - lsurv;
        md.add(x + lsurv);
        tvd.add(x + lsurv);
        x = x + lsurv;
        lmd.add(lsurv);
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        inc.add(0);
        az.add(0);
        dl.add(0);
        f.add(1);
        v.add(lsurv);
        nors.add(0);
        estw.add(0);
        ntg.add(ns);
        etg.add(es);
        nof.add(0);
        eof.add(0);
        cd.add(0);
        acd.add(0);
        vs.add(0);
      }

      while (inc.last < Angm) {
        md.add(x + lsurv);
        inc.add(inc.last + BUR);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(BUR);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(double.parse(
            (2 / (dl.last * math.pi / 180) * tan_rad(dl.last / 2)).toStringAsFixed(9)));
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      while (md.last < Pdes) {
        md.add(x + lsurv);
        inc.add(inc.last);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(1);
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        // tvd.add(1700);    
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(16)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(16)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      if (md.last > Pdes) {
        md.removeLast();
        md.add(Pdes);
        lmd.removeLast();
        lmd.add(double.parse((Pdes - md[md.length - 2]).toStringAsFixed(2)));
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(2)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(5)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(5)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }
    } else if (tipoPozo == "j") {
      DOR=0;
      ProfExt=0;

      Nx = Nt - Ns;
      Ex = Et - Es;
      DH = math.sqrt(Nx * Nx + Ex * Ex);
      At = 0;
      if (Nx >= 0 && Ex >= 0) {
        At = double.parse(grados_atan(Ex / Nx).toStringAsFixed(2));
      } else if (Nx < 0 && Ex >= 0) {
        At = double.parse((grados_atan(Ex / Nx) + 180).toStringAsFixed(2));
      } else if (Nx >= 0 && Ex < 0) {
        At = double.parse((grados_atan(Ex / Nx) + 360).toStringAsFixed(2));
      } else if (Nx < 0 && Ex < 0) {
        At = double.parse((grados_atan(Ex / Nx) + 180).toStringAsFixed(2));
      }

      Rc = (180 / math.pi) * (1 / BUR) * 30;
      a = Rc - DH;
      b = TVD - KOP;
      c = DH - Rc;
      e = c != 0 ? grados_atan(b / c) : 0;
      Angm = 0;
      if (Rc > DH) {
        Angm = double.parse(
            (grados_asen(Rc / math.sqrt(a * a + b * b)) - grados_atan(a / b)).toStringAsFixed(2));
      } else if (Rc < DH) {
        Angm = double.parse(
            (180 - grados_atan(b / c) - grados_acos(Rc / b) * grados_asen(e)).toStringAsFixed(2));
      }
      Larca = (Angm / BUR) * 30;
      Omega = Rc > DH
          ? grados_asen(Rc / math.sqrt(a * a + b * b))
          : grados_asen(Rc / math.sqrt(c * c + b * b));
      Ltan = Rc / tan_rad(Omega);
      Pdes = double.parse((KOP + Larca + Ltan).toStringAsFixed(2));
      Pvfci = double.parse((KOP + (Rc * sen_rad(Angm))).toStringAsFixed(2));
      Dhfci = double.parse((Rc * (1 - cos_rad(Angm))).toStringAsFixed(2));
      At = At;
      Larcb = double.parse(0.toStringAsFixed(2));
      Pvfst = double.parse(0.toStringAsFixed(2));
      Dhfst = double.parse(0.toStringAsFixed(2));
      Pdfci = double.parse(0.toStringAsFixed(2));
      Pdfst = double.parse(0.toStringAsFixed(2));
      Pdfcd = double.parse(0.toStringAsFixed(2));
      DH = DH;
      angmax = double.parse(Angm.toStringAsFixed(2));

      while (KOP > 0) {
        KOP = KOP - lsurv;
        md.add(x + lsurv);
        tvd.add(x + lsurv);
        x = x + lsurv;
        lmd.add(lsurv);
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        inc.add(0);
        az.add(0);
        dl.add(0);
        f.add(1);
        v.add(lsurv);
        nors.add(0);
        estw.add(0);
        ntg.add(Ns);
        etg.add(Es);
        nof.add(0);
        eof.add(0);
        cd.add(0);
        acd.add(0);
        vs.add(0);
      }

      while (inc.last < Angm) {
        md.add(x + lsurv);
        inc.add(inc.last + BUR);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(BUR);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(double.parse(
            (2 / (dl.last * math.pi / 180) * tan_rad(dl.last / 2)).toStringAsFixed(9)));
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(5)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(5)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      while (TVD > tvd.last) {
        md.add(x + lsurv);
        inc.add(inc.last);
        lmd.add(lsurv);
        x = x + lsurv;
        i.add(ii + 1);
        ii = ii + 1;
        bur.add(0);
        az.add(At);
        dl.add(double.parse(
            (grados_acos(cos_rad(inc[inc.length - 2]) * cos_rad(inc.last) +
                    sen_rad(inc[inc.length - 2]) * sen_rad(inc.last) * cos_rad(az[az.length - 2] - az.last)))
                .toStringAsFixed(2)));
        f.add(1);
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(3)));
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(5)));
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(5)));
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }

      if (md.last > Pdes) {
        md.removeLast();
        md.add(Pdes);
        lmd.removeLast();
        lmd.add(double.parse((Pdes - md[md.length - 2]).toStringAsFixed(2)));
        v.removeLast();
        v.add(double.parse(
            (f.last * (lmd.last / 2) * (cos_rad(inc[inc.length - 2]) + cos_rad(inc.last))).toStringAsFixed(7)));
        tvd.removeLast();
        tvd.add(double.parse((v.last + tvd.last).toStringAsFixed(2)));
        nors.removeLast();
        nors.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * cos_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * cos_rad(az.last))).toStringAsFixed(5)));
        estw.removeLast();
        estw.add(double.parse(
            (f.last * (lmd.last / 2) * (sen_rad(inc[inc.length - 2]) * sen_rad(az[az.length - 2]) +
                    sen_rad(inc.last) * sen_rad(az.last))).toStringAsFixed(5)));
        ntg.removeLast();            
        ntg.add(double.parse((ntg.last + nors.last).toStringAsFixed(2)));
        etg.removeLast();
        etg.add(double.parse((etg.last + estw.last).toStringAsFixed(2)));
        nof.removeLast();
        nof.add(double.parse((ntg.last - ntg[0]).toStringAsFixed(2)));
        eof.removeLast();
        eof.add(double.parse((etg.last - etg[0]).toStringAsFixed(2)));
        cd.removeLast();
        cd.add(math.sqrt(nof.last * nof.last + eof.last * eof.last));
        acd.removeLast();
        acd.add(nof.last != 0 ? grados_atan(eof.last / nof.last) : 0);
        vs.removeLast();
        vs.add(cos_rad(az[az.length - 2] - az.last) * cd.last);
      }
    }

    // Create DataFrame-like structure
    List<Map<String, dynamic>> df = [];
    for (int idx = 0; idx < i.length; idx++) {
      df.add({
        "Survey": i[idx],
        "MD": md[idx],
        "LMD": lmd[idx],
        "BUR": bur[idx],
        "Inc": inc[idx],
        "Az": az[idx],
        "Dla": dl[idx],
        "F": f[idx],
        "V": v[idx],
        "TVD": tvd[idx],
        "DeltNS": nors[idx],
        "DeltEW": estw[idx],
        "Northing": ntg[idx],
        "Easting": etg[idx],
        "Nof": nof[idx],
        "Eof": eof[idx],
        "Cd": cd[idx],
        "Acd": acd[idx],
        "Vs": vs[idx],
      });
    }
////////////////////hasta aqui se crea la lista de estaciones/surveys con los que cuenta la trayectoria determinada
    // Extract lists for compatibility with Flask output
    final survey = dl.map((x) => x).toList();
    final lmdList = md.map((x) => x).toList();
    final tvdList = tvd.map((x) => x).toList();
    final vsList = vs.map((x) => x).toList();
    final incList = inc.map((x) => x).toList();
    final ntgList = ntg.map((x) => x).toList();
    final etgList = etg.map((x) => x).toList();
    final azList = az.map((x) => x).toList();
    final nofList = nof.map((x) => x).toList();
    final eofList = eof.map((x) => x).toList();
    final dlamax = dl.isNotEmpty ? dl.reduce(math.max) : 0.0;

    return {
      'status': 'success',
      'data': {
        'Pdes': Pdes,
        'Pvfc': null,
        'Dfc': null,
        'Angm': Angm,
        'At': At,
        'survey': survey,
        'Dlamax': dlamax,
        'lmd': lmdList,
        'ntg': ntgList,
        'etg': etgList,
        'Az': azList,
        'inc': incList,
        'tvd': tvdList,
        'vs': vsList,
        'Nof': nofList,
        'Eof': eofList,
        'data': df,
        'Pvfci': Pvfci,
        'Dhfci': Dhfci,
        'Larca': Larca,
        'Larcb': Larcb,
        'Ltan': Ltan,
        'Pvfst': Pvfst,
        'Dhfst': Dhfst,
        'Pdfci': Pdfci,
        'Pdfst': Pdfst,
        'Pdfcd': Pdfcd,
        'DH': DH,
        'angmax': angmax,
      },
    };
  }
}