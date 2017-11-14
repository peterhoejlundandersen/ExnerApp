import { Component, OnInit } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule } from '@angular/http';


@Component({
  selector: 'thumbnail-load',
  template: `
  <div class="thumb-images row sortable-images">
    <div *ngFor="let image of images" 
    class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item"
    [attr.data-id]="image.id" data-type="Image">
      <img src="{{image.thumb_url}}">
    </div>
  </div>
  `,
})
export class AppComponent implements OnInit {
  images: null;
  constructor( 
    public http: Http
  ) {};


  getThumbImages(image_category_id) {
    this.http.get('/works/images.json?image_category_id=' + image_category_id)
      .subscribe(
        data => this.images = data.json().images,
        err => console.log(err)
      )
  };

  ngOnInit() {
    var img_cat_id = document.getElementById('imgCat').getAttribute("data-img-cat");
    this.getThumbImages(img_cat_id);
  }
}
