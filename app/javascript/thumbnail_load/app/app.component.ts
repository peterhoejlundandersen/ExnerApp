import { Component, OnInit, HostListener } from '@angular/core';
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
        <div class="work-arrows" id="leftArrow" (click)="changeImage(image_index - 1)"></div>
        <div class="work-arrows" id="rightArrow" (click)="changeImage(image_index + 1)"></div>
      </div>
    </div>
  </div>
  <!-- image categories -->
  <div class="blog-nav img-cat-nav sortable-images" data-navbar="img">
    <div *ngFor="let image_cat of image_cats; let i = index"
    class="nav-link sortable-image-item text-center"
    [attr.data-id]="image_cat.id"
    data-type="ImageCategory">
      <div (click)="changeCategory(image_cat.id, i)" class="nav-link sortable-image-item text-center">
        {{image_cat.name}}
      </div>
    </div>
  </div>
  <!-- thumbnails -->
  <div class="thumb-images row sortable-images">
    <div *ngFor="let thumb_image of thumb_images; let i = index"
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item"
    (click)="changeImage(i)"
    [attr.data-id]="thumb_image.id" data-type="Image">
      <img src="{{thumb_image.image.thumb.url}}">
    </div>
  </div>
  `,
  host: {
    '(document:keyup)': 'onKeyUp($event)'
  }
})

export class AppComponent implements OnInit {

  thumb_images: null;
  image_cats: null;
  large_image: null;
  image_index: number = 0;
  image_cats_index: number = 0;

  constructor( private _image_service: ImageService) {};

  ngOnInit() {
    var img_cat_id = document.getElementById('imgCat').getAttribute("data-img-cat");
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(data => {
        this.thumb_images = data.images,
          this.image_cats = data.image_cats,
          this.large_image = data.large_image,
          this.image_cats_index = data.image_cats_index
      });
  }

  onKeyUp = function(ev) {
    if (ev.key == "ArrowRight") {
      this.changeImage(this.image_index++);
    } else if (ev.key == "ArrowLeft") {
      this.changeImage(this.image_index--);
    }
  }

  changeCategory = function(img_cat_id, index) { // Get image data from the json call
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(
        data => this.thumb_images = data.images,
        err => console.log(err),
        () => { this.changeLargeImage(0); this.image_cats_index = index; this.image_index = 0; }
      )
  }

  changeLargeImage = function(image_index) {
    this.large_image = this.thumb_images[image_index];
  }

  changeImage = function(image_index) {
    this.changeLargeImage(image_index);
    this.image_index = image_index;
  }

}
