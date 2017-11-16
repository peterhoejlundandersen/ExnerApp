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
    [ngClass]="{'active-cat': i == image_cats_index }"
    [attr.data-id]="image_cat.id"
    data-type="ImageCategory">
      <div (click)="changeCategory(i)" class="nav-link sortable-image-item text-center">
        {{image_cat.name}}
      </div>
    </div>
  </div>
  <!-- thumbnails -->
  <div class="thumb-images row sortable-images">
    <div *ngFor="let thumb_image of thumb_images; let i = index"
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item"
    [ngClass]="{'thumbnail-active': i == image_index}"
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
      this.changeImage(this.image_index + 1);
    } else if (ev.key == "ArrowLeft") {
      this.changeImage(this.image_index - 1);
    }
  }

  changeCategory = function(i, last = false) { // Get image data from the json call
    if (this.image_cats[i]) {
      var img_cat_id =  this.image_cats[i].id;
      this.image_cats_index = i;
    } else { 
      var image_cats_length = this.image_cats.length -1;
      if (i > image_cats_length) { //If last image cat, start from first
        var img_cat_id = this.image_cats[0].id;
        this.image_cats_index = 0;
      } else { //If first image cat, start from last
        var img_cat_id = this.image_cats[image_cats_length].id;
        this.image_cats_index = image_cats_length;
        console.log("jhasdjkhkjh");
      }
    }
    this._image_service.getImagesAndImageCats(img_cat_id)
      .subscribe(
        data => this.thumb_images = data.images,
        err => console.log(err),
        () => { 
          if (last) {
            var last_image_index = this.thumb_images.length - 1;
            this.changeLargeImage(last_image_index);
          } else {
            this.changeLargeImage(0);
          }
        }
      )
  }

  changeLargeImage = function(image_index) {
    if (this.thumb_images[image_index]) { // If index finds image in array
      this.large_image = this.thumb_images[image_index];
    } else {
      if (image_index < 0) { // change to prev image_cat
        this.changeCategory(this.image_cats_index - 1, true); //last_image true
      } else { // change to next image
        this.changeCategory(this.image_cats_index + 1);
      }
    }
    this.image_index = image_index;
  }

  changeImage = function(image_index) {
    this.changeLargeImage(image_index);
  }

}
