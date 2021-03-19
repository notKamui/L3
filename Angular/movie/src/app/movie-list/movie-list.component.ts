import { Component, Input, OnInit } from "@angular/core";
import { MovieShortInformations } from "../model/movie";

@Component({
  selector: "app-movie-list",
  templateUrl: "./movie-list.component.html",
  styleUrls: ["./movie-list.component.css"],
})
export class MovieListComponent implements OnInit {
  @Input()
  movies: MovieShortInformations[];

  constructor() {}

  ngOnInit() {}
}
