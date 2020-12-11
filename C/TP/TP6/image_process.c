#include <stdio.h>
#include <math.h>

#define IMAGE_SIZE 512
#define IMAGE_SIZE_X IMAGE_SIZE
#define IMAGE_SIZE_Y IMAGE_SIZE
#define PIXEL_SIZEOF 4

int min(int a, int b) {
  return a < b ? a : b;
}

int max(int a, int b) {
  return a > b ? a : b;
}

void invert_color(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      bitmap[i][j][0] = 255 - bitmap[i][j][0];
      bitmap[i][j][1] = 255 - bitmap[i][j][1];
      bitmap[i][j][2] = 255 - bitmap[i][j][2];
    }
  }
}

void avg_gray(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j, value;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      value = (bitmap[i][j][0]+bitmap[i][j][1]+bitmap[i][j][2])/3;
      bitmap[i][j][0] = value;
      bitmap[i][j][1] = value;
      bitmap[i][j][2] = value;
    }
  }
}

void clear_gray(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j, value, mini, maxi;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      mini = min(min(bitmap[i][j][0], bitmap[i][j][1]), bitmap[i][j][2]);
      maxi = max(max(bitmap[i][j][0], bitmap[i][j][1]), bitmap[i][j][2]);
      value = (mini+maxi)/2;
      bitmap[i][j][0] = value;
      bitmap[i][j][1] = value;
      bitmap[i][j][2] = value;
    }
  }
}

void lum_gray(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j, value;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      value = 0.2126*bitmap[i][j][0]+0.7152*bitmap[i][j][1]+0.0722*bitmap[i][j][2];
      bitmap[i][j][0] = value;
      bitmap[i][j][1] = value;
      bitmap[i][j][2] = value;
    }
  }
}

void threshold_bnw(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j;
  
  lum_gray(bitmap);
  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      if (bitmap[i][j][0] > 128) {
        bitmap[i][j][0] = 255;
        bitmap[i][j][1] = 255;
        bitmap[i][j][2] = 255;
      } else {
        bitmap[i][j][0] = 0;
        bitmap[i][j][1] = 0;
        bitmap[i][j][2] = 0;
      }
    }
  }
}

void redder(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j;
  
  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      bitmap[i][j][0] = (255+bitmap[i][j][0])/2.0;
    }
  }
}

void red_blue_gradient(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]){
  int i, j;
  float coef = 0;
  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
        coef = (i+j)/(1024.0);
        bitmap[i][j][0] = (1 - coef)*bitmap[i][j][0]; 
        bitmap[i][j][1] = 0;
        bitmap[i][j][2] = coef*bitmap[i][j][2];
    }
  }
}

void img_avg(unsigned char bitmap1[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF], unsigned char bitmap2[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i){
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      bitmap1[i][j][0] = (bitmap1[i][j][0]+bitmap2[i][j][0])/2.0;
      bitmap1[i][j][1] = (bitmap1[i][j][1]+bitmap2[i][j][1])/2.0;
      bitmap1[i][j][2] = (bitmap1[i][j][2]+bitmap2[i][j][2])/2.0;
    }
  }
}

void mid_light(unsigned char bitmap[IMAGE_SIZE_Y][IMAGE_SIZE_X][PIXEL_SIZEOF]) {
  int i, j;
  double coef;

  for (i=0 ; i<IMAGE_SIZE_Y ; ++i) {
    for (j=0 ; j<IMAGE_SIZE_X ; ++j){
      coef = pow((1 - ((256 - i)*(256 - i) + (256 - j)*(256 - j)) / (2.0*(256*256))), 10);
      bitmap[i][j][0] *= coef;
      bitmap[i][j][1] *= coef;
      bitmap[i][j][2] *= coef;
    }
  }
}