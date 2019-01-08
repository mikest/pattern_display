/*
 *   Written 2004 by <mgix@mgix.com>
 *   This code is in the public domain
 *   See http://www.mgix.com/snippets for details
 *
 *   Adapted for Processing by Mike Estee, 2011, still in the public domain.
 */

void mult( float[] r, float[] a, float[] b )
{
  float a0 = a[ 0]; 
  float a1 = a[ 1]; 
  float a2 = a[ 2];
  float a3 = a[ 3];
  float a4 = a[ 4]; 
  float a5 = a[ 5]; 
  float a6 = a[ 6]; 
  float a7 = a[ 7];
  float a8 = a[ 8]; 
  float a9 = a[ 9]; 
  float aa = a[10]; 
  float ab = a[11];
  float ac = a[12]; 
  float ad = a[13]; 
  float ae = a[14]; 
  float af = a[15];

  float b0 = b[ 0]; 
  float b1 = b[ 1]; 
  float b2 = b[ 2]; 
  float b3 = b[ 3];
  float b4 = b[ 4]; 
  float b5 = b[ 5]; 
  float b6 = b[ 6]; 
  float b7 = b[ 7];
  float b8 = b[ 8]; 
  float b9 = b[ 9]; 
  float ba = b[10]; 
  float bb = b[11];
  float bc = b[12]; 
  float bd = b[13]; 
  float be = b[14]; 
  float bf = b[15];

  r[ 0] = a0*b0 + a1*b4 + a2*b8 + a3*bc;
  r[ 1] = a0*b1 + a1*b5 + a2*b9 + a3*bd;
  r[ 2] = a0*b2 + a1*b6 + a2*ba + a3*be;
  r[ 3] = a0*b3 + a1*b7 + a2*bb + a3*bf;

  r[ 4] = a4*b0 + a5*b4 + a6*b8 + a7*bc;
  r[ 5] = a4*b1 + a5*b5 + a6*b9 + a7*bd;
  r[ 6] = a4*b2 + a5*b6 + a6*ba + a7*be;
  r[ 7] = a4*b3 + a5*b7 + a6*bb + a7*bf;

  r[ 8] = a8*b0 + a9*b4 + aa*b8 + ab*bc;
  r[ 9] = a8*b1 + a9*b5 + aa*b9 + ab*bd;
  r[10] = a8*b2 + a9*b6 + aa*ba + ab*be;
  r[11] = a8*b3 + a9*b7 + aa*bb + ab*bf;

  r[12] = ac*b0 + ad*b4 + ae*b8 + af*bc;
  r[13] = ac*b1 + ad*b5 + ae*b9 + af*bd;
  r[14] = ac*b2 + ad*b6 + ae*ba + af*be;
  r[15] = ac*b3 + ad*b7 + ae*bb + af*bf;
}

void id( float[]  m)
{
  m[ 0] = 1.0;     
  m[ 1] = 0.0; 
  m[ 2] = 0.0;     
  m[ 3] = 0.0;
  m[ 4] = 0.0;     
  m[ 5] = 1.0; 
  m[ 6] = 0.0;     
  m[ 7] = 0.0;
  m[ 8] = 0.0;     
  m[ 9] = 0.0; 
  m[10] = 1.0;     
  m[11] = 0.0;
  m[12] = 0.0;     
  m[13] = 0.0; 
  m[14] = 0.0;     
  m[15] = 1.0;
}

float D( float[] m, int a, int b, int c, int d )
{
  return m[a]*m[b] - m[c]*m[d];
}

void inv( float[] i, float[] m )
{
  float d0= D(m, 10,15,14,11);
  float d1= D(m, 9,15,13,11);
  float d2= D(m, 9,14,13,10);
  float d3= D(m, 8,15,12,11);
  float d4= D(m, 8,14,12,10);
  float d5= D(m, 8,13,12, 9);

  float c0 = m[ 5]*d0 - m[ 6]*d1 + m[ 7]*d2;
  float c1 = m[ 4]*d0 - m[ 6]*d3 + m[ 7]*d4;
  float c2 = m[ 4]*d1 - m[ 5]*d3 + m[ 7]*d5;
  float c3 = m[ 4]*d2 - m[ 5]*d4 + m[ 6]*d5;

  float det = c0*m[0] - c1*m[1] + c2*m[2] - c3*m[3];
  det = 1.0/det;

  float d6= D(m, 6,15,14, 7);
  float d7= D(m, 5,15,13, 7);
  float d8= D(m, 5,14,13, 6);
  float d9= D(m, 4,15,12, 7);
  float da= D(m, 4,14,12, 6);
  float db= D(m, 4,13,12, 5);
  float dc= D(m, 6,11,10, 7);
  float dd= D(m, 5,11, 9, 7);
  float de= D(m, 5,10, 9, 6);
  float df= D(m, 4,11, 8, 7);
  float dg= D(m, 4,10, 8, 6);
  float dh= D(m, 4, 9, 8, 5);

  float c4 = m[ 1]*d0 - m[ 2]*d1 + m[ 3]*d2;
  float c5 = m[ 0]*d0 - m[ 2]*d3 + m[ 3]*d4;
  float c6 = m[ 0]*d1 - m[ 1]*d3 + m[ 3]*d5;
  float c7 = m[ 0]*d2 - m[ 1]*d4 + m[ 2]*d5;
  float c8 = m[ 1]*d6 - m[ 2]*d7 + m[ 3]*d8;
  float c9 = m[ 0]*d6 - m[ 2]*d9 + m[ 3]*da;
  float ca = m[ 0]*d7 - m[ 1]*d9 + m[ 3]*db;
  float cb = m[ 0]*d8 - m[ 1]*da + m[ 2]*db;
  float cc = m[ 1]*dc - m[ 2]*dd + m[ 3]*de;
  float cd = m[ 0]*dc - m[ 2]*df + m[ 3]*dg;
  float ce = m[ 0]*dd - m[ 1]*df + m[ 3]*dh;
  float cf = m[ 0]*de - m[ 1]*dg + m[ 2]*dh;

  i[ 0]=  c0*det;
  i[ 1]= -c4*det;
  i[ 2]=  c8*det;
  i[ 3]= -cc*det;
  i[ 4]= -c1*det;
  i[ 5]=  c5*det;
  i[ 6]= -c9*det;
  i[ 7]=  cd*det;
  i[ 8]=  c2*det;
  i[ 9]= -c6*det;
  i[10]=  ca*det;
  i[11]= -ce*det;
  i[12]= -c3*det;
  i[13]=  c7*det;
  i[14]= -cb*det;
  i[15]=  cf*det;
}


void pin(
float[] m,
float[] px,
float[] py
)
{
  float a = px[0];
  float b = py[0];
  float c = px[1];
  float d = py[1];
  float e = px[2];
  float f = py[2];
  float g = px[3];
  float h = py[3];

  float ret;
  float det = ret = d*e - c*f - d*g + f*g + c*h - e*h;
  det = 1.0/det;

  float[] p = new float[16];

  p[ 0] = det*( b*c*e - a*d*e - b*c*g + a*d*g - a*f*g + c*f*g + a*e*h - c*e*h);
  p[ 1] = det*(-a*d*e + a*c*f + b*c*g - b*e*g + d*e*g - c*f*g - a*c*h + a*e*h);
  p[ 2] =  0.0;
  p[ 3] =  a;

  p[ 4] = det*( b*c*f - a*d*f - b*f*g + d*f*g - b*c*h + a*d*h + b*e*h - d*e*h);
  p[ 5] = det*(-b*d*e + b*c*f + b*d*g - b*f*g - a*d*h + d*e*h + a*f*h - c*f*h);
  p[ 6] =  0.0;
  p[ 7] =  b;

  p[ 8] =  0.0;
  p[ 9] =  0.0;
  p[10] =  1.0;
  p[11] =  0.0;

  p[12] =  det*(b*e - d*e - a*f + c*f - b*g + d*g + a*h - c*h);
  p[13] =  det*(b*c - a*d - b*e + a*f + d*g - f*g - c*h + e*h);
  p[14] =  0.0;
  p[15] =  1.0;

  mult(m, p, m);
}


void pin(
float[] m,   // matrix out
float[] sx,  // source points
float[] sy,
float[] px,  // dest points
float[] py
)
{
  float[] s = new float[16];
  id(s);
  pin(s, sx, sy);
  inv(s, s);

  float[] d = new float[16];
  id(d);
  pin(d, px, py);

  mult(m, s, m);
  mult(m, d, m);
}
