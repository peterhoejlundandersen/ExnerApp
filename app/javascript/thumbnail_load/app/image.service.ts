import { Injectable  } from '@angular/core';
import { Http, HttpModule } from '@angular/http';

import 'rxjs/add/operator/map';

@Injectable()

export class ImageService {
  constructor(private http: Http) {}

  getThumbnailImages(image_category_id) {
    return this.http.get('/works/images.json?image_category_id=' + image_category_id)
      .map(response => response.json());
  }
}
