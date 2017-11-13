import { Component } from '@angular/core';
import { BrowserModule } from "@angular/platform-browser";
import { Http, HttpModule } from '@angular/http';


@Component({
  selector: 'thumbnail-load',
  template: `
  <div *ngFor="let image of images" class="text-center thumb-image col-lg-2 col-md-3 col-6 col-xs-6 sortable-image-item" data-id="image.id" data-type="Image">
    <img src="{{image.url}}">
  </div>
  <button> Få alle billederne</button>
  `
})
export class AppComponent {
  images = [
    {id: 12, url: "https://exnerbilleder.s3.amazonaws.com/nye/uploads/image/image/989/thumb_L1080217.jpg"},
  ]
  constructor( 
    public http: Http
  ) {
    this.http.get('/works/images.json?image_category_id=10')
      .subscribe(
        data => this.images = data.json().images,
        err => console.log(err)
      )
  };

}
