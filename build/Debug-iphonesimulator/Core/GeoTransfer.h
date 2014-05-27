/*
 * GeoTransfer.h
 *
 *  Created on: 2010-9-7
 *      Author: yunfeng.wang
 */

#ifndef CONVERTER_INCLUDE_H
#define CONVERTER_INCLUDE_H

typedef struct
{
    double casm_rr;
    double casm_t1;
    double casm_t2;
    double casm_x1;
    double casm_y1;
    double casm_x2;
    double casm_y2;
    double casm_f;
} Converter;

extern void InitConverter(Converter* c);

extern void getEncryPoint( double x, double y, double *dEx, double *dEy );

extern void IniCasm(Converter* c , double w_time, double w_lng, double w_lat);
extern double random_yj(Converter* c);
extern int wgtochina_lb(Converter* c, int wg_flag,int wg_lng, int wg_lat, int wg_heit, int wg_week, int wg_time, double *dx, double *dy);

extern double yj_sin2(double x);
extern double Transform_yj5(double x, double y);
extern double Transform_yjy5(double x,double y);
extern double Transform_jy5(double x, double xx);
extern double Transform_jyj5(double x,double yy);

#endif /* GEOTRANSFER_H_ */
