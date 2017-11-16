import { Component, OnInit, HostListener } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";

import { ImageService } from './image.service';
import { ImageNavigatorService } from './image_navigator.service';
import { ImageCat } from './image_cat';

@Component({
  selector: 'thumbnail-load',
  template: `
  <!-- large image -->
  <div class="large-image">
    <div *ngIf="large_image" class="vertical-center">
      <div class="image-desc-wrapper">
        <img [attr.src]="large_image.image.url" id="largeImage">
        <div class="work-arrows" id="leftArrow" (click)="changeLargeImage(image_index - 1)"></div>
        <div class="work-arrows" id="rightArrow" (click)="changeLargeImage(image_index + 1)"></div>
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
    (click)="changeLargeImage(i)"
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

  constructor( 
    private _image_service: ImageService,
    public _image_navigator_service: ImageNavigatorService
  ) {};

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

  onKeyUp = function(event) {
    if (event.key == "ArrowRight") {
      this.changeLargeImage(this.image_index + 1, this.thumb_images);
    } else if (event.key == "ArrowLeft") {
      this.changeLargeImage(this.image_index - 1, this.thumb_images);
    }
  }

  changeCategory = function(i, last = false) { // Get image data from the json call
    var [image_cat_id, image_cats_index] = this._image_navigator_service.categoryChangerChecker(this.image_cats, i); 
    this.image_cats_index = image_cats_index;
    this._image_service.getImagesAndImageCats(image_cat_id)
      .subscribe(
        data => this.thumb_images = data.images,
        err => console.log(err),
        () => {  //Last image should be focused when using arrowkeys prev to another img cat
          this.image_index = (last) ? this.thumb_images.length - 1 : 0;
          this.changeLargeImage(this.image_index);
        }
      )
  }

  changeLargeImage = function(i) {
    if (this.thumb_images[i]) { // If the index is inside the scope - normal change
      this.large_image = this.thumb_images[i], this.image_index = i;
    } else { // If not, see if it's the end of the img_cat or the start
      (i < 0) ? this.changeCategory(this.image_cats_index - 1, true) : this.changeCategory(this.image_cats_index + 1) 
    }
  }

}
