import { Component, OnInit } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule } from '@angular/http';

import { ImageService } from './image.service';

@Component({
  selector: 'thumbnail-load',
  template: `
  <div class="thumb-images row sortable-images">
    <div *ngFor="let thumb_image of thumb_images" 
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item"
    [attr.data-id]="thumb_image.id" data-type="Image">
      <img src="{{thumb_image.thumb_url}}">
    </div>
  </div>
  `,
})
export class AppComponent implements OnInit {
  thumb_images: null;
  constructor( 
    public http: Http,
    private image_service: ImageService
  ) {};

  ngOnInit() {
    var img_cat_id = document.getElementById('imgCat').getAttribute("data-img-cat");
    this.image_service.getThumbnailImages(img_cat_id)
      .subscribe(data => this.thumb_images = data.images);
  }
}
