/*
 * GeoTransfer.c
 *
 *  Created on: 2010-9-7
 *      Author: yunfeng.wang
 */

#include "GeoTransfer.h"

#include "math.h"
#include "stdio.h"
#include "stdlib.h"

void InitConverter(Converter* c)
{
    c->casm_rr = 0;
    c->casm_t1 = 0;
    c->casm_t2 = 0;
    c->casm_x1 = 0;
    c->casm_y1 = 0;
    c->casm_x2 = 0;
    c->casm_y2 = 0;
    c->casm_f = 0;
}

double yj_sin2(double x)
{
    double tt;
    double ss;
    double ff;
    double s2;
    int cc;
    ff = 0;
    if (x < 0)
    {
        x = -x;
        ff = 1;
    }

    cc = (int)(x / 6.28318530717959);

    tt = x - cc * 6.28318530717959;
    if (tt > 3.1415926535897932)
    {
        tt = tt - 3.1415926535897932;
        if (ff == 1)
        {
            ff = 0;
        }
        else if (ff == 0)
        {
            ff = 1;
        }
    }
    x = tt;
    ss = x;
    s2 = x;
    tt = tt * tt;
    s2 = s2 * tt;
    ss = ss - s2 * 0.166666666666667;
    s2 = s2 * tt;
    ss = ss + s2 * 8.33333333333333E-03;
    s2 = s2 * tt;
    ss = ss - s2 * 1.98412698412698E-04;
    s2 = s2 * tt;
    ss = ss + s2 * 2.75573192239859E-06;
    s2 = s2 * tt;
    ss = ss - s2 * 2.50521083854417E-08;
    if (ff == 1)
    {
        ss = -ss;
    }
    return ss;
}

double Transform_yj5(double x, double y)
{
    double tt;
    tt = 300 + 1 * x + 2 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(sqrt(x * x));
    tt = tt + (20 * yj_sin2(18.849555921538764 * x) + 20 * yj_sin2(6.283185307179588 * x)) * 0.6667;
    tt = tt + (20 * yj_sin2(3.141592653589794 * x) + 40 * yj_sin2(1.047197551196598 * x)) * 0.6667;
    tt = tt + (150 * yj_sin2(0.2617993877991495 * x) + 300 * yj_sin2(0.1047197551196598 * x)) * 0.6667;
    return tt;
}

double Transform_yjy5(double x,double y)
{
    double tt;
    tt = -100 + 2 * x + 3 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(sqrt(x * x));
    tt = tt + (20 * yj_sin2(18.849555921538764 * x) + 20 * yj_sin2(6.283185307179588 * x)) * 0.6667;
    tt = tt + (20 * yj_sin2(3.141592653589794 * y) + 40 * yj_sin2(1.047197551196598 * y)) * 0.6667;
    tt = tt + (160 * yj_sin2(0.2617993877991495 * y) + 320 * yj_sin2(0.1047197551196598 * y)) * 0.6667;
    return tt;
}

double Transform_jy5(double x, double xx)
{
    double n;
    double a;
    double e;
    a = 6378245;
    e = 0.00669342;
    n = sqrt(1 - e * yj_sin2(x * 0.0174532925199433) * yj_sin2(x * 0.0174532925199433));
    n = (xx * 180) / (a / n * cos(x * 0.0174532925199433) * 3.1415926);
    return n;
}

double Transform_jyj5(double x,double yy)
{
    double m;
    double a;
    double e;
    double mm;
    a = 6378245;
    e = 0.00669342;
    mm = 1 - e * yj_sin2(x * 0.0174532925199433) * yj_sin2(x * 0.0174532925199433);
    m = (a * (1 - e)) / (mm * sqrt(mm));
    return (yy * 180) / (m * 3.1415926);
}

double random_yj(Converter* c)
{
    double t;
    double casm_a = 314159269;
    double casm_c = 453806245;
    c->casm_rr = casm_a * c->casm_rr + casm_c;
    t = (int)(c->casm_rr / 2);
    c->casm_rr = c->casm_rr - t * 2;
    c->casm_rr = c->casm_rr / 2;
    return (c->casm_rr);
}

void IniCasm(Converter* c, double w_time, double w_lng, double w_lat)
{
    double tt;
    c->casm_t1 = w_time;
    c->casm_t2 = w_time;
    tt = (int)(w_time / 0.357);
    c->casm_rr = w_time - tt * 0.357;
    if (w_time == 0)
    	c->casm_rr = 0.3;
    c->casm_x1 = w_lng;
    c->casm_y1 = w_lat;
    c->casm_x2 = w_lng;
    c->casm_y2 = w_lat;
    c->casm_f = 3;
}

int wgtochina_lb(Converter *c, int wg_flag,int wg_lng, int wg_lat, int wg_heit, int wg_week, int wg_time, double *dx, double *dy)
{
    double  x_add;
    double  y_add;
    double  h_add;
    double  x_l;
    double  y_l;
    double  casm_v;
    double  t1_t2;
    double  x1_x2;
    double  y1_y2;

    if (wg_heit > 5000)
    {
        return -1;
    }

    x_l = wg_lng;
    x_l = x_l / 3686400.0;
    y_l = wg_lat;
    y_l = y_l / 3686400.0;
    if (x_l < 72.004)
    {
        return -1;
    }
    if (x_l > 137.8347)
    {
        return -1;
    }
    if (y_l < 0.8293)
    {
        return -1;
    }
    if (y_l > 55.8271)
    {
        return -1;
    }
    if (wg_flag == 0)
    {
        IniCasm(c, wg_time, wg_lng, wg_lat);
		*dx = wg_lng;
        *dy = wg_lat;
        return 0;
    }
    c->casm_t2 = wg_time;
    t1_t2 = (c->casm_t2 - c->casm_t1) / 1000.0;
    if (t1_t2 <= 0)
    {
    	c->casm_t1 = c->casm_t2;
    	c->casm_f = c->casm_f + 1;
    	c->casm_x1 = c->casm_x2;
    	c->casm_f = c->casm_f + 1;
    	c->casm_y1 = c->casm_y2;
    	c->casm_f = c->casm_f + 1;
    }
    else
    {
        if (t1_t2 > 120)
        {
            if (c->casm_f == 3)
            {
            	c->casm_f = 0;
            	c->casm_x2 = wg_lng;
            	c->casm_y2 = wg_lat;
                x1_x2 = c->casm_x2 - c->casm_x1;
                y1_y2 = c->casm_y2 - c->casm_y1;
                casm_v = sqrt(x1_x2 * x1_x2 + y1_y2 * y1_y2) / t1_t2;
                if (casm_v > 3185)
                {
                    return -1;
                }
            }
            c->casm_t1 = c->casm_t2;
            c->casm_f = c->casm_f + 1;
            c->casm_x1 = c->casm_x2;
            c->casm_f = c->casm_f + 1;
            c->casm_y1 = c->casm_y2;
            c->casm_f = c->casm_f + 1;
        }
    }
    x_add = Transform_yj5(x_l - 105, y_l - 35);
    y_add = Transform_yjy5(x_l - 105, y_l - 35);
    h_add = wg_heit;
    x_add = x_add + h_add * 0.001 + yj_sin2(wg_time * 0.0174532925199433) + random_yj(c);
    y_add = y_add + h_add * 0.001 + yj_sin2(wg_time * 0.0174532925199433) + random_yj(c);
    *dx = x_l + Transform_jy5(y_l, x_add);
	*dy = y_l + Transform_jyj5(y_l, y_add);
    return 0;
}

void getEncryPoint( double x, double y, double *dEx, double *dEy )
{
    double x1;
    double y1;

    Converter c;

    InitConverter(&c);

    x1 = x * 3686400.0;
    y1 = y * 3686400.0;
    int gpsWeek = 0;
    int gpsWeekTime = 0;
    int gpsHeight = 0;
    wgtochina_lb(&c, 1, (int)(x1), (int)(y1), gpsHeight, gpsWeek, gpsWeekTime, dEx, dEy );
}



