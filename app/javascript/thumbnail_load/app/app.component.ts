import { Component, OnInit } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";

import { ImageService } from './image.service';
import { ImageCat } from './image_cat';

@Component({
  selector: 'thumbnail-load',
  template: `
  <!-- large image -->
  <div class="large-image">
    <div *ngIf="large_image" class="vertical-center">
      <div class="image-desc-wrapper">
        <img [attr.src]="large_image.image.url" id="largeImage">
      </div>
    </div>
  </div>
  <!-- image categories -->
  <div class="blog-nav img-cat-nav sortable-images" data-navbar="img">
    <div *ngFor="let image_cat of image_cats"
    class="nav-link sortable-image-item text-center"
    [attr.data-id]="image_cat.id"
    data-type="ImageCategory">
      <div (click)="changeCategory(image_cat.id)" class="nav-link sortable-image-item text-center">
        {{image_cat.name}}
      </div>
    </div>
  </div>
  <!-- thumbnails -->
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
  image_cats: null;
  large_image: null;

  constructor( 
    private _image_service: ImageService
  ) {};

  changeCategory(img_cat_id) {
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(data => this.thumb_images = data.images)
  }
  changeLargeImage(image_id) {
    console.log(image_id);
  }
  ngOnInit() {
    var img_cat_id = document.getElementById('imgCat').getAttribute("data-img-cat");
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(data => {
        this.thumb_images = data.images,
        this.image_cats = data.image_cats,
        this.large_image = data.large_image
      });

  }
}
