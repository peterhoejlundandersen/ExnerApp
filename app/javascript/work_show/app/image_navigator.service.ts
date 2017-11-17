import { Injectable } from '@angular/core';

@Injectable()

export class ImageNavigatorService {
  image_cats_index: number;

  categoryChangerChecker = function(image_cats, i) {
    if (image_cats[i]) {
      var img_cat_id =  image_cats[i].id;
      this.image_cats_index = i;
    } else { 
      var image_cats_length = image_cats.length -1;
      if (i > image_cats_length) { //If last image cat, start from first
        var img_cat_id = image_cats[0].id;
        this.image_cats_index = 0;
      } else { //If first image cat, start from last
        var img_cat_id = image_cats[image_cats_length].id;
        this.image_cats_index = image_cats_length;
      }
    }
    return [img_cat_id, this.image_cats_index];
  }

}
